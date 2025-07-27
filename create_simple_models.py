import pickle
import os

print("Creating simple model files for testing...")

# Create a simple mock model class
class MockModel:
    def predict(self, X):
        # Return a simple prediction based on temperature (first feature)
        return [1000 + X[0][7] * 2000]  # temp is at index 7

# Create a simple mock scaler
class MockScaler:
    def transform(self, X):
        return X  # No transformation for testing

# Create directory
os.makedirs('summative/linear_regression', exist_ok=True)

# Create mock objects
model = MockModel()
scaler = MockScaler()
feature_columns = ['season', 'yr', 'mnth', 'holiday', 'weekday', 'workingday', 'weathersit',
                   'temp', 'atemp', 'hum', 'windspeed', 'day_of_year', 'month', 'day_of_week',
                   'temp_humidity', 'temp_windspeed', 'weather_temp',
                   'spring_temp', 'summer_temp', 'fall_temp', 'winter_temp']

# Save files using pickle (simpler than joblib)
with open('summative/linear_regression/best_model.pkl', 'wb') as f:
    pickle.dump(model, f)

with open('summative/linear_regression/scaler.pkl', 'wb') as f:
    pickle.dump(scaler, f)

with open('summative/linear_regression/feature_columns.pkl', 'wb') as f:
    pickle.dump(feature_columns, f)

print("✅ Mock model files created successfully!")
print("📁 Files created:")
print("   - summative/linear_regression/best_model.pkl")
print("   - summative/linear_regression/scaler.pkl")
print("   - summative/linear_regression/feature_columns.pkl")
print("\nNote: These are mock models for testing. Replace with real models for production.") 