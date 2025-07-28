class ApiConfig {
  // Deployed API URL
  static const String deployedApiUrl = "https://linear-regression-model-69lm.onrender.com";
  
  // Local development URLs (for testing)
  static const String localApiUrl = "http://127.0.0.1:8000";
  static const String androidEmulatorApiUrl = "http://10.0.2.2:8000";
  
  // Get the appropriate API URL based on platform
  static String getApiUrl() {
    // Use deployed API for production
    return deployedApiUrl;
  }
  
  // Get health check URL
  static String getHealthUrl() {
    return "${getApiUrl()}/health";
  }
  
  // Get prediction endpoint URL
  static String getPredictUrl() {
    return "${getApiUrl()}/predict";
  }
} 