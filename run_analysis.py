#!/usr/bin/env python3
"""
Script to run the bike sharing analysis and generate model files.
This script executes the Jupyter notebook cells programmatically.
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error
from sklearn.preprocessing import StandardScaler
import pickle
import warnings
warnings.filterwarnings('ignore')

def main():
    print("🚴 Starting Bike Sharing Demand Prediction Analysis...")
    print("=" * 60)
    
    # 1. Load the datasets
    print("📊 Loading datasets...")
    day_data = pd.read_csv('day.csv')
    hour_data = pd.read_csv('hour.csv')
    
    print(f"Day dataset shape: {day_data.shape}")
    print(f"Hour dataset shape: {hour_data.shape}")
    
    # 2. Data preprocessing
    print("\n🔧 Preprocessing data...")
    df = day_data.copy()
    
    # Drop instant column
    df = df.drop('instant', axis=1)
    
    # Convert dteday to datetime
    df['dteday'] = pd.to_datetime(df['dteday'])
    
    # Extract additional temporal features
    df['day_of_year'] = df['dteday'].dt.dayofyear
    df['month'] = df['dteday'].dt.month
    df['day_of_week'] = df['dteday'].dt.dayofweek
    
    # Create interaction features
    df['temp_humidity'] = df['temp'] * df['hum']
    df['temp_windspeed'] = df['temp'] * df['windspeed']
    df['weather_temp'] = df['weathersit'] * df['temp']
    
    # Create seasonal temperature features
    df['spring_temp'] = (df['season'] == 1) * df['temp']
    df['summer_temp'] = (df['season'] == 2) * df['temp']
    df['fall_temp'] = (df['season'] == 3) * df['temp']
    df['winter_temp'] = (df['season'] == 4) * df['temp']
    
    # Select features for modeling
    feature_columns = [
        'season', 'yr', 'mnth', 'holiday', 'weekday', 'workingday', 'weathersit',
        'temp', 'atemp', 'hum', 'windspeed', 'day_of_year', 'month', 'day_of_week',
        'temp_humidity', 'temp_windspeed', 'weather_temp',
        'spring_temp', 'summer_temp', 'fall_temp', 'winter_temp'
    ]
    
    X = df[feature_columns]
    y = df['cnt']
    
    print(f"Feature matrix shape: {X.shape}")
    print(f"Target variable shape: {y.shape}")
    
    # 3. Data splitting and scaling
    print("\n⚖️ Splitting and scaling data...")
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    
    scaler = StandardScaler()
    X_train_scaled = scaler.fit_transform(X_train)
    X_test_scaled = scaler.transform(X_test)
    
    # 4. Train models
    print("\n🤖 Training models...")
    
    # Linear Regression
    lr_model = LinearRegression()
    lr_model.fit(X_train_scaled, y_train)
    lr_pred = lr_model.predict(X_test_scaled)
    lr_r2 = r2_score(y_test, lr_pred)
    lr_mae = mean_absolute_error(y_test, lr_pred)
    
    # Decision Tree
    dt_model = DecisionTreeRegressor(random_state=42, max_depth=10)
    dt_model.fit(X_train_scaled, y_train)
    dt_pred = dt_model.predict(X_test_scaled)
    dt_r2 = r2_score(y_test, dt_pred)
    dt_mae = mean_absolute_error(y_test, dt_pred)
    
    # Random Forest
    rf_model = RandomForestRegressor(n_estimators=100, random_state=42, max_depth=10)
    rf_model.fit(X_train_scaled, y_train)
    rf_pred = rf_model.predict(X_test_scaled)
    rf_r2 = r2_score(y_test, rf_pred)
    rf_mae = mean_absolute_error(y_test, rf_pred)
    
    # 5. Compare models
    print("\n📈 Model Comparison:")
    print(f"{'Model':<20} {'R² Score':<10} {'MAE':<10}")
    print("-" * 40)
    print(f"{'Linear Regression':<20} {lr_r2:<10.4f} {lr_mae:<10.2f}")
    print(f"{'Decision Tree':<20} {dt_r2:<10.4f} {dt_mae:<10.2f}")
    print(f"{'Random Forest':<20} {rf_r2:<10.4f} {rf_mae:<10.2f}")
    
    # 6. Select best model
    models = {
        'Linear Regression': (lr_model, lr_r2),
        'Decision Tree': (dt_model, dt_r2),
        'Random Forest': (rf_model, rf_r2)
    }
    
    best_model_name = max(models.keys(), key=lambda x: models[x][1])
    best_model = models[best_model_name][0]
    
    print(f"\n🏆 Best Model: {best_model_name}")
    print(f"R² Score: {models[best_model_name][1]:.4f}")
    
    # 7. Save models
    print("\n💾 Saving models...")
    
    # Create directory if it doesn't exist
    import os
    os.makedirs('summative/linear_regression', exist_ok=True)
    
    # Save the best model using pickle
    with open('summative/linear_regression/best_model.pkl', 'wb') as f:
        pickle.dump(best_model, f)
    with open('summative/linear_regression/scaler.pkl', 'wb') as f:
        pickle.dump(scaler, f)
    with open('summative/linear_regression/feature_columns.pkl', 'wb') as f:
        pickle.dump(feature_columns, f)
    
    print("✅ Models saved successfully!")
    print("📁 Files created:")
    print("   - summative/linear_regression/best_model.pkl")
    print("   - summative/linear_regression/scaler.pkl")
    print("   - summative/linear_regression/feature_columns.pkl")
    
    # 8. Test prediction function
    print("\n🧪 Testing prediction function...")
    
    # Test data
    test_features = np.array([2, 1, 6, 0, 1, 1, 1, 0.5, 0.5, 0.6, 0.2, 150, 6, 1])
    
    # Create interaction features
    temp_humidity = 0.5 * 0.6
    temp_windspeed = 0.5 * 0.2
    weather_temp = 1 * 0.5
    spring_temp = 0
    summer_temp = 0.5
    fall_temp = 0
    winter_temp = 0
    
    all_features = np.concatenate([test_features, [temp_humidity, temp_windspeed, weather_temp,
                                                   spring_temp, summer_temp, fall_temp, winter_temp]])
    
    features_reshaped = all_features.reshape(1, -1)
    features_scaled = scaler.transform(features_reshaped)
    prediction = best_model.predict(features_scaled)[0]
    
    print(f"Test prediction: {int(prediction)} bike rentals")
    
    print("\n🎉 Analysis completed successfully!")
    print("=" * 60)
    print("Next steps:")
    print("1. Deploy the API to Render or similar platform")
    print("2. Update the API URL in the Flutter app")
    print("3. Test the mobile app")
    print("4. Create the video demo")

if __name__ == "__main__":
    main() 