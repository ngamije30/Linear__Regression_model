import uvicorn
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field, validator
import pickle
import numpy as np
from typing import Optional
import os

# Load the saved model and scaler using pickle
model_path = os.path.join(os.path.dirname(__file__), '..', 'summative', 'linear_regression', 'best_model.pkl')
scaler_path = os.path.join(os.path.dirname(__file__), '..', 'summative', 'linear_regression', 'scaler.pkl')
feature_columns_path = os.path.join(os.path.dirname(__file__), '..', 'summative', 'linear_regression', 'feature_columns.pkl')

try:
    with open(model_path, 'rb') as f:
        model = pickle.load(f)
    with open(scaler_path, 'rb') as f:
        scaler = pickle.load(f)
    with open(feature_columns_path, 'rb') as f:
        feature_columns = pickle.load(f)
    print("✅ Model loaded successfully using pickle!")
except Exception as e:
    print(f"❌ Error loading model: {e}")
    model = None
    scaler = None
    feature_columns = None

app = FastAPI(
    title="Bike Sharing Demand Prediction API",
    description="API for predicting bike rental demand based on weather and temporal features",
    version="1.0.0"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, specify your Flutter app's domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Pydantic model for input validation
class BikeRentalRequest(BaseModel):
    season: int = Field(..., ge=1, le=4, description="Season (1=spring, 2=summer, 3=fall, 4=winter)")
    yr: int = Field(..., ge=0, le=1, description="Year (0=2011, 1=2012)")
    mnth: int = Field(..., ge=1, le=12, description="Month (1-12)")
    holiday: int = Field(..., ge=0, le=1, description="Holiday (0=no, 1=yes)")
    weekday: int = Field(..., ge=0, le=6, description="Day of week (0=Sunday, 1=Monday, ..., 6=Saturday)")
    workingday: int = Field(..., ge=0, le=1, description="Working day (0=no, 1=yes)")
    weathersit: int = Field(..., ge=1, le=4, description="Weather situation (1=clear, 2=mist, 3=light rain/snow, 4=heavy rain/snow)")
    temp: float = Field(..., ge=0.0, le=1.0, description="Normalized temperature (0-1)")
    atemp: float = Field(..., ge=0.0, le=1.0, description="Normalized feeling temperature (0-1)")
    hum: float = Field(..., ge=0.0, le=1.0, description="Normalized humidity (0-1)")
    windspeed: float = Field(..., ge=0.0, le=1.0, description="Normalized wind speed (0-1)")
    day_of_year: int = Field(..., ge=1, le=366, description="Day of year (1-366)")
    month: int = Field(..., ge=1, le=12, description="Month (1-12)")
    day_of_week: int = Field(..., ge=0, le=6, description="Day of week (0-6)")

    @validator('workingday')
    def validate_workingday(cls, v, values):
        if 'holiday' in values and values['holiday'] == 1 and v == 1:
            raise ValueError('Working day cannot be 1 when holiday is 1')
        return v

    @validator('weekday')
    def validate_weekday_workingday(cls, v, values):
        if 'workingday' in values:
            if values['workingday'] == 1 and v in [0, 6]:  # Sunday or Saturday
                raise ValueError('Working day cannot be 1 on weekends (weekday 0 or 6)')
            elif values['workingday'] == 0 and v in [1, 2, 3, 4, 5]:  # Weekdays
                raise ValueError('Working day cannot be 0 on weekdays (weekday 1-5)')
        return v

class BikeRentalResponse(BaseModel):
    predicted_rentals: int
    confidence: float
    message: str

@app.get("/")
async def root():
    return {
        "message": "Bike Sharing Demand Prediction API",
        "version": "1.0.0",
        "status": "running",
        "model_loaded": model is not None
    }

@app.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "model_loaded": model is not None,
        "scaler_loaded": scaler is not None
    }

@app.post("/predict", response_model=BikeRentalResponse)
async def predict_bike_rentals(request: BikeRentalRequest):
    """
    Predict bike rental demand based on input features.
    
    This endpoint accepts weather and temporal features and returns
    the predicted number of bike rentals for the given conditions.
    """
    if model is None or scaler is None:
        raise HTTPException(status_code=500, detail="Model not loaded")
    
    try:
        # Create feature vector
        features = np.array([
            request.season, request.yr, request.mnth, request.holiday, 
            request.weekday, request.workingday, request.weathersit,
            request.temp, request.atemp, request.hum, request.windspeed, 
            request.day_of_year, request.month, request.day_of_week
        ])
        
        # Create interaction features
        temp_humidity = request.temp * request.hum
        temp_windspeed = request.temp * request.windspeed
        weather_temp = request.weathersit * request.temp
        
        # Create seasonal temperature features
        spring_temp = (request.season == 1) * request.temp
        summer_temp = (request.season == 2) * request.temp
        fall_temp = (request.season == 3) * request.temp
        winter_temp = (request.season == 4) * request.temp
        
        # Combine all features
        all_features = np.concatenate([
            features, 
            [temp_humidity, temp_windspeed, weather_temp,
             spring_temp, summer_temp, fall_temp, winter_temp]
        ])
        
        # Reshape for prediction
        features_reshaped = all_features.reshape(1, -1)
        
        # Scale features
        features_scaled = scaler.transform(features_reshaped)
        
        # Make prediction
        prediction = model.predict(features_scaled)[0]
        predicted_rentals = max(0, int(prediction))
        
        # Calculate confidence based on weather conditions
        confidence = 0.8  # Base confidence
        if request.weathersit == 1:  # Clear weather
            confidence += 0.1
        elif request.weathersit >= 3:  # Bad weather
            confidence -= 0.2
        
        if request.temp >= 0.3 and request.temp <= 0.7:  # Comfortable temperature
            confidence += 0.1
        elif request.temp < 0.2 or request.temp > 0.8:  # Extreme temperature
            confidence -= 0.1
        
        confidence = max(0.5, min(0.95, confidence))  # Clamp between 0.5 and 0.95
        
        return BikeRentalResponse(
            predicted_rentals=predicted_rentals,
            confidence=round(confidence, 2),
            message=f"Predicted {predicted_rentals} bike rentals for the given conditions"
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction error: {str(e)}")

@app.get("/docs")
async def get_docs():
    """
    Redirect to the Swagger UI documentation.
    """
    return {"message": "Visit /docs for API documentation"}

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)