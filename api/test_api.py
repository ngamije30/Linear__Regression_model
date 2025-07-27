#!/usr/bin/env python3
"""
Test script for the Bike Sharing Prediction API
Tests the POST /predict endpoint with various inputs
"""

import requests
import json
import time

BASE_URL = "http://127.0.0.1:8000"

def test_health():
    """Test the health endpoint"""
    try:
        response = requests.get(f"{BASE_URL}/health")
        if response.status_code == 200:
            result = response.json()
            print("Health Check:", result)
            return True
        else:
            print(f"Health check failed with status {response.status_code}:", response.text)
            return False
    except Exception as e:
        print(f"Health check failed: {e}")
        return False

def test_prediction():
    """Test the prediction endpoint"""
    test_data = {
        "season": 2,  # Summer
        "yr": 1,      # 2012
        "mnth": 6,    # June
        "holiday": 0, # No holiday
        "weekday": 1, # Monday
        "workingday": 1, # Working day
        "weathersit": 1, # Clear
        "temp": 0.5,  # Moderate temperature
        "atemp": 0.5, # Moderate feeling temperature
        "hum": 0.6,   # Moderate humidity
        "windspeed": 0.2, # Low wind
        "day_of_year": 150, # Day 150 of the year
        "month": 6,   # June
        "day_of_week": 1  # Monday
    }
    
    try:
        response = requests.post(f"{BASE_URL}/predict", json=test_data)
        if response.status_code == 200:
            result = response.json()
            print("Prediction Test:", result)
            return True
        else:
            print(f"Prediction failed with status {response.status_code}:", response.text)
            return False
    except Exception as e:
        print(f"Prediction test failed: {e}")
        return False

def test_validation():
    """Test input validation"""
    invalid_data = {
        "season": 5,  # Invalid season (should be 1-4)
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
    
    try:
        response = requests.post(f"{BASE_URL}/predict", json=invalid_data)
        if response.status_code == 422:  # Validation error
            print("Validation Test: PASSED - Invalid data properly rejected")
            return True
        else:
            print(f"Validation test failed - expected 422, got {response.status_code}")
            return False
    except Exception as e:
        print(f"Validation test failed: {e}")
        return False

def test_multiple_predictions():
    """Test multiple different scenarios"""
    test_scenarios = [
        {
            "name": "Summer Working Day",
            "data": {
                "season": 2, "yr": 1, "mnth": 7, "holiday": 0, "weekday": 2,
                "workingday": 1, "weathersit": 1, "temp": 0.7, "atemp": 0.7,
                "hum": 0.5, "windspeed": 0.1, "day_of_year": 180, "month": 7, "day_of_week": 2
            }
        },
        {
            "name": "Winter Weekend",
            "data": {
                "season": 4, "yr": 0, "mnth": 1, "holiday": 0, "weekday": 0,
                "workingday": 0, "weathersit": 2, "temp": 0.2, "atemp": 0.1,
                "hum": 0.8, "windspeed": 0.4, "day_of_year": 15, "month": 1, "day_of_week": 0
            }
        },
        {
            "name": "Spring Holiday",
            "data": {
                "season": 1, "yr": 1, "mnth": 4, "holiday": 1, "weekday": 6,
                "workingday": 0, "weathersit": 1, "temp": 0.4, "atemp": 0.4,
                "hum": 0.6, "windspeed": 0.3, "day_of_year": 100, "month": 4, "day_of_week": 6
            }
        }
    ]
    
    print("\n🧪 Testing Multiple Scenarios:")
    print("=" * 40)
    
    for scenario in test_scenarios:
        try:
            response = requests.post(f"{BASE_URL}/predict", json=scenario["data"])
            if response.status_code == 200:
                result = response.json()
                print(f"✅ {scenario['name']}: {result['predicted_rentals']} rentals (confidence: {result['confidence']})")
            else:
                print(f"❌ {scenario['name']}: Failed with status {response.status_code}")
        except Exception as e:
            print(f"❌ {scenario['name']}: Error - {e}")

def test_api_documentation():
    """Test if Swagger UI is accessible"""
    try:
        response = requests.get(f"{BASE_URL}/docs")
        if response.status_code == 200:
            print("✅ API Documentation: Accessible")
            return True
        else:
            print(f"❌ API Documentation: Failed with status {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ API Documentation: Error - {e}")
        return False

if __name__ == "__main__":
    print("🚀 Testing Bike Sharing Prediction API...")
    print("=" * 50)
    
    # Wait a moment for API to start
    print("⏳ Waiting for API to start...")
    time.sleep(2)
    
    # Test health endpoint
    health_ok = test_health()
    
    # Test prediction endpoint
    prediction_ok = test_prediction()
    
    # Test validation
    validation_ok = test_validation()
    
    # Test multiple scenarios
    test_multiple_predictions()
    
    # Test documentation
    docs_ok = test_api_documentation()
    
    print("\n" + "=" * 50)
    print("📊 Test Results Summary:")
    print(f"Health Check: {'✅ PASS' if health_ok else '❌ FAIL'}")
    print(f"Prediction: {'✅ PASS' if prediction_ok else '❌ FAIL'}")
    print(f"Validation: {'✅ PASS' if validation_ok else '❌ FAIL'}")
    print(f"Documentation: {'✅ PASS' if docs_ok else '❌ FAIL'}")
    
    if health_ok and prediction_ok and validation_ok:
        print("\n🎉 All tests passed! API is working correctly.")
        print(f"📖 Swagger UI available at: {BASE_URL}/docs")
    else:
        print("\n⚠️ Some tests failed. Please check the API.")
    
    print("\n💡 To start the API, run:")
    print("   python api/api.py")
    print(f"💡 Then visit: {BASE_URL}/docs") 