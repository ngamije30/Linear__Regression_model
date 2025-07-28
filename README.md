# Bike Sharing Demand Prediction

A comprehensive machine learning project that predicts bike rental demand using linear regression, with a FastAPI backend and Flutter mobile app.

## Project Structure

```
Linear__Regression_model/
├── api/                          # FastAPI backend
│   ├── api.py                   # Main API file
│   ├── requirements.txt          # Python dependencies
│   └── test_api.py              # API testing script
├── summative/                    # Machine learning analysis
│   └── linear_regression/
│       ├── bike_sharing_analysis.ipynb  # Jupyter notebook
│       ├── best_model.pkl       # Trained model
│       ├── scaler.pkl           # Feature scaler
│       └── feature_columns.pkl  # Feature columns
├── FlutterApp/                   # Mobile application
│   └── bike_sharing_prediction/
│       ├── lib/
│       │   ├── main.dart
│       │   ├── config/
│       │   ├── providers/
│       │   └── screens/
│       └── pubspec.yaml
├── day.csv                       # Daily bike sharing data
├── hour.csv                      # Hourly bike sharing data
└── README.md
```

## API Endpoint

**Deployed API URL**: `https://linear-regression-model-69lm.onrender.com`

**Swagger UI**: `https://linear-regression-model-69lm.onrender.com/docs`

**Local API URL**: `http://127.0.0.1:8000` (for development)

**⚠️ IMPORTANT**:
1. For local testing, use `http://127.0.0.1:8000`
2. For production, the API is deployed at `https://linear-regression-model-69lm.onrender.com`
3. The Flutter app is configured to use the deployed API URL

**Prediction Endpoint**: `POST /predict`

## Features

### Machine Learning
- **Linear Regression Model**: Predicts bike rental demand
- **Feature Engineering**: Temporal, weather, and interaction features
- **Data Visualization**: Comprehensive analysis with plots and charts
- **Model Comparison**: Linear Regression vs Decision Tree vs Random Forest
- **Model Persistence**: Saved using pickle for API integration

### API (FastAPI)
- **RESTful API**: FastAPI with automatic documentation
- **Input Validation**: Pydantic models with constraints
- **CORS Support**: Cross-origin resource sharing enabled
- **Error Handling**: Comprehensive error responses
- **Swagger UI**: Interactive API documentation

### Mobile App (Flutter)
- **Cross-platform**: Works on Android and iOS
- **API Integration**: Connects to deployed API
- **User-friendly UI**: Multiple screens with input validation
- **Real-time Predictions**: Get bike rental predictions instantly
- **Error Handling**: User-friendly error messages

## Quick Start

### 1. Run the API Locally
```bash
cd api
pip install -r requirements.txt
python api.py
```

### 2. Run the Mobile App
```bash
cd FlutterApp/bike_sharing_prediction
flutter pub get
flutter run
```

### 3. Access API Documentation
- **Local**: http://127.0.0.1:8000/docs
- **Deployed**: https://linear-regression-model-69lm.onrender.com/docs

## API Usage

### Health Check
```bash
curl https://linear-regression-model-69lm.onrender.com/health
```

### Make a Prediction
```bash
curl -X POST "https://linear-regression-model-69lm.onrender.com/predict" \
  -H "Content-Type: application/json" \
  -d '{
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
  }'
```

## Model Performance

- **R² Score**: 0.85+
- **Mean Absolute Error**: < 200 rentals
- **Features**: 21 engineered features including temporal, weather, and interaction features

## Technologies Used

- **Machine Learning**: Scikit-learn, NumPy, Pandas
- **API**: FastAPI, Pydantic, Uvicorn
- **Mobile**: Flutter, Dart
- **Deployment**: Render
- **Data**: Bike sharing dataset

Video demo link : https://www.loom.com/share/4469f0e0a0d64851b7f6e55f788306b4?sid=335d09aa-b093-4df3-8407-47f64b18060a

github link: https://github.com/ngamije30/Linear__Regression_model.git
