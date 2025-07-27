class ApiConfig {
  // API URLs for different environments
  static const String localApiUrl = 'http://127.0.0.1:8000';
  static const String androidEmulatorApiUrl = 'http://10.0.2.2:8000';
  static const String iosSimulatorApiUrl = 'http://127.0.0.1:8000';
  
  // Production URL (replace with your deployed API URL)
  static const String productionApiUrl = 'https://your-api-url.com';
  
  // Get the appropriate API URL based on platform
  static String getApiUrl() {
    // For Android emulator, use 10.0.2.2 instead of 127.0.0.1
    // This is because Android emulator can't access localhost directly
    return androidEmulatorApiUrl;
  }
  
  // API endpoints
  static const String predictEndpoint = '/predict';
  static const String healthEndpoint = '/health';
  static const String docsEndpoint = '/docs';
  
  // Full URLs
  static String getPredictUrl() => '${getApiUrl()}$predictEndpoint';
  static String getHealthUrl() => '${getApiUrl()}$healthEndpoint';
  static String getDocsUrl() => '${getApiUrl()}$docsEndpoint';
} 