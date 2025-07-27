# Bike Sharing Prediction Flutter App

A Flutter mobile application for predicting bike rental demand using machine learning.

## Features

- ✅ Multiple pages (Home, Prediction, About)
- ✅ 14 input fields for prediction parameters
- ✅ Real-time API integration
- ✅ Input validation and error handling
- ✅ Loading states and user feedback
- ✅ Clean, organized UI

## Prerequisites

1. **Flutter SDK** (version 3.0.0 or higher)
2. **Android Studio** or **Xcode** for mobile development
3. **API Server** running at `http://127.0.0.1:8000`

## Setup Instructions

### 1. Install Dependencies
```bash
cd FlutterApp/bike_sharing_prediction
flutter pub get
```

### 2. Configure API URL
Edit `lib/config/api_config.dart` to set the correct API URL:

```dart
// For local development
static const String localApiUrl = 'http://127.0.0.1:8000';

// For Android emulator
static const String androidEmulatorApiUrl = 'http://10.0.2.2:8000';

// For production (replace with your deployed API URL)
static const String productionApiUrl = 'https://your-api-url.com';
```

### 3. Start the API Server
Make sure your API is running:
```bash
# From the project root
python api/api.py
```

### 4. Run the Flutter App

#### For Android:
```bash
flutter run
```

#### For iOS:
```bash
flutter run
```

## API Configuration

The app connects to these API endpoints:

- **Health Check**: `GET /health`
- **Prediction**: `POST /predict`
- **Documentation**: `GET /docs`

## Input Fields

The app requires 14 input fields:

1. **Season** (1-4): Spring, Summer, Fall, Winter
2. **Year** (0-1): 2011 or 2012
3. **Month** (1-12): January to December
4. **Holiday** (0-1): No or Yes
5. **Weekday** (0-6): Sunday to Saturday
6. **Working Day** (0-1): No or Yes
7. **Weather Situation** (1-4): Clear, Mist, Light Rain, Heavy Rain
8. **Temperature** (0.0-1.0): Normalized temperature
9. **Feeling Temperature** (0.0-1.0): Normalized feeling temperature
10. **Humidity** (0.0-1.0): Normalized humidity
11. **Wind Speed** (0.0-1.0): Normalized wind speed
12. **Day of Year** (1-366): Day number in the year
13. **Month** (1-12): Month number
14. **Day of Week** (0-6): Day of week number

## Troubleshooting

### Common Issues:

1. **"Cannot connect to API"**
   - Make sure your API server is running
   - Check the API URL in `lib/config/api_config.dart`
   - For Android emulator, use `http://10.0.2.2:8000`
   - For iOS simulator, use `http://127.0.0.1:8000`

2. **"Network error"**
   - Check your internet connection
   - Verify the API server is accessible
   - Check firewall settings

3. **"Prediction failed"**
   - Check the API logs for errors
   - Verify input values are within valid ranges
   - Ensure the model files are loaded correctly

### Debug Information:

The app prints debug information to the console:
- API request URLs
- Request data
- Response status and body
- Error messages

## Project Structure

```
FlutterApp/bike_sharing_prediction/
├── lib/
│   ├── main.dart                 # App entry point
│   ├── config/
│   │   └── api_config.dart       # API configuration
│   ├── providers/
│   │   └── prediction_provider.dart  # State management
│   └── screens/
│       ├── home_screen.dart      # Home page
│       ├── prediction_screen.dart # Prediction form
│       └── about_screen.dart     # About page
├── pubspec.yaml                  # Dependencies
└── README.md                     # This file
```

## Dependencies

- `flutter`: Flutter SDK
- `http`: HTTP client for API calls
- `provider`: State management
- `shared_preferences`: Local storage

## License

This project is part of a machine learning assignment.
