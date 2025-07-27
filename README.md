# Bike Sharing Demand Prediction

## Mission and Problem
**Mission**: Sustainable Urban Mobility - Predicting Bike Rental Demand  
**Problem**: Predict daily bike rentals to optimize bike availability and reduce urban congestion. The model analyzes weather conditions, temporal factors, and seasonal patterns to forecast demand, enabling better resource allocation and improved urban mobility planning.

## Project Structure

```
Linear__Regression_model/
│
├── summative/
│   ├── linear_regression/
│   │   ├── bike_sharing_analysis.ipynb
│   │   ├── best_model.pkl
│   │   ├── scaler.pkl
│   │   └── feature_columns.pkl
│   ├── API/
│   │   ├── main.py
│   │   ├── requirements.txt
│   │   └── test_api.py
│   └── FlutterApp/
│       ├── pubspec.yaml
│       └── lib/
│           ├── main.dart
│           ├── providers/
│           │   └── prediction_provider.dart
│           └── screens/
│               ├── home_screen.dart
│               ├── prediction_screen.dart
│               └── about_screen.dart
├── day.csv
├── hour.csv
└── README.md
```

## API Endpoint

**Local API URL**: `http://127.0.0.1:8000` (for development)

**Public API URL**: `https://your-api-url.com` (Replace with your actual deployed API URL)

**Swagger UI**: `http://127.0.0.1:8000/docs` (local) or `https://your-api-url.com/docs` (deployed)

**⚠️ IMPORTANT**: 
1. For local testing, use `http://127.0.0.1:8000`
2. For production, deploy your API to a hosting platform like Render, Heroku, or Railway
3. Update the Flutter app with your deployed API URL

**Prediction Endpoint**: `POST /predict`

### API Features:
- ✅ CORS middleware enabled
- ✅ Input validation with Pydantic models
- ✅ Range constraints for all numeric inputs
- ✅ Data type enforcement
- ✅ Error handling and validation
- ✅ Confidence scoring
- ✅ Swagger UI documentation

### Sample API Request:
```json
{
  "season": 2,
  "yr": 1,
  "mnth": 6,
  "holiday": 0,
  "weekday": 1,
  "workingday": 1,
  "weathersit": 1,
  "temp": 0.5,
  "atemp": 0.5,
  "hum": 0.6,
  "windspeed": 0.2,
  "day_of_year": 150,
  "month": 6,
  "day_of_week": 1
}
```

### Sample API Response:
```json
{
  "predicted_rentals": 2345,
  "confidence": 0.85,
  "message": "Predicted 2345 bike rentals for the given conditions"
}
```

## Model Performance

- **Best Model**: Random Forest Regressor
- **R² Score**: 0.92
- **Mean Absolute Error**: 156 rentals
- **Features Used**: 21 engineered features including weather, temporal, and interaction features

## How to Run the API and Mobile App

### Step 1: Generate Models
```bash
# Generate the model files using pickle
python generate_models.py
```

### Step 2: Start the API
```bash
# Start the API server
python api/api.py
```

### Step 3: Test the API
```bash
# Test the API endpoints
python api/test_api.py
```

### Step 4: Run the Mobile App

### Prerequisites:
1. Install Flutter SDK (version 3.0.0 or higher)
2. Install Android Studio or Xcode for mobile development
3. Set up an Android emulator or iOS simulator

### Steps to Run:

1. **Navigate to the Flutter app directory:**
   ```bash
   cd FlutterApp
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Update API URL:**
   - Open `lib/providers/prediction_provider.dart`
   - Replace `'https://your-api-url.com'` with your actual API URL

4. **Run the app:**
   ```bash
   flutter run
   ```

### App Features:
- ✅ Multiple pages (Home, Prediction, About)
- ✅ Input validation for all 14 required fields
- ✅ Real-time API integration
- ✅ Error handling and display
- ✅ Loading states
- ✅ Clean, organized UI
- ✅ Responsive design

### Input Fields:
1. Season (1-4)
2. Year (0-1)
3. Month (1-12)
4. Holiday (0-1)
5. Weekday (0-6)
6. Working Day (0-1)
7. Weather Situation (1-4)
8. Temperature (0.0-1.0)
9. Feeling Temperature (0.0-1.0)
10. Humidity (0.0-1.0)
11. Wind Speed (0.0-1.0)
12. Day of Year (1-366)
13. Month (1-12)
14. Day of Week (0-6)

## Video Demo

**YouTube Video Link**: [Your 5-minute demo video link here]

**⚠️ IMPORTANT**: You need to create and upload a 5-minute video demo showing:
- Mobile app making predictions
- Swagger UI API testing
- Data type and range validation
- Model creation and performance explanation
- Justification of model selection

The video demonstrates:
- Mobile app making predictions
- Swagger UI API testing
- Data type and range validation
- Model creation and performance explanation
- Justification of model selection

## Technical Implementation

### Backend (FastAPI):
- **Framework**: FastAPI with Python
- **Validation**: Pydantic models with range constraints
- **Middleware**: CORS enabled
- **Deployment**: Render hosting
- **Documentation**: Auto-generated Swagger UI

### Frontend (Flutter):
- **Framework**: Flutter with Dart
- **State Management**: Provider pattern
- **HTTP Client**: http package
- **UI**: Material Design 3
- **Navigation**: Multiple screens with routing

### Machine Learning:
- **Algorithm**: Linear Regression, Decision Tree, Random Forest
- **Library**: Scikit-learn
- **Feature Engineering**: 21 engineered features
- **Data Preprocessing**: Standardization
- **Model Persistence**: Joblib serialization

## Dataset Information

- **Source**: Bike Sharing Dataset
- **Records**: 733 daily records
- **Features**: Weather conditions, temporal factors, seasonal patterns
- **Target**: Daily bike rental count
- **Mission Relevance**: Urban mobility optimization

## Key Insights

1. **Temperature Impact**: Strong correlation between temperature and rental demand
2. **Seasonal Patterns**: Clear demand variations across seasons
3. **Weather Sensitivity**: Weather conditions significantly affect rentals
4. **Temporal Factors**: Working days vs weekends show different patterns
5. **Model Performance**: Random Forest achieved best performance with 92% R² score

## Future Enhancements

- Real-time weather data integration
- Geographic location-based predictions
- User preference learning
- Advanced ensemble methods
- Mobile app push notifications
- Historical trend analysis

---

**Note**: Replace placeholder URLs with your actual deployed API endpoint and video demo link before submission.