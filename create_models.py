import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestRegressor
from sklearn.preprocessing import StandardScaler
import pickle
import os

print("Creating model files...")

# Load data
df = pd.read_csv('day.csv')

# Simple feature engineering
df['temp_humidity'] = df['temp'] * df['hum']
df['temp_windspeed'] = df['temp'] * df['windspeed']

# Select features
features = ['season', 'yr', 'mnth', 'holiday', 'weekday', 'workingday', 'weathersit',
           'temp', 'atemp', 'hum', 'windspeed', 'temp_humidity', 'temp_windspeed']

X = df[features]
y = df['cnt']

# Train model
model = RandomForestRegressor(n_estimators=50, random_state=42)
scaler = StandardScaler()

X_scaled = scaler.fit_transform(X)
model.fit(X_scaled, y)

# Create directory
os.makedirs('summative/linear_regression', exist_ok=True)

# Save files using pickle
with open('summative/linear_regression/best_model.pkl', 'wb') as f:
    pickle.dump(model, f)
with open('summative/linear_regression/scaler.pkl', 'wb') as f:
    pickle.dump(scaler, f)
with open('summative/linear_regression/feature_columns.pkl', 'wb') as f:
    pickle.dump(features, f)

print("Model files created successfully!")
print("Files saved:")
print("- summative/linear_regression/best_model.pkl")
print("- summative/linear_regression/scaler.pkl") 
print("- summative/linear_regression/feature_columns.pkl") 