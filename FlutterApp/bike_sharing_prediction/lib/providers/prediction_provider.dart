import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

class PredictionProvider with ChangeNotifier {
  String _apiUrl = ApiConfig.getApiUrl(); // Get API URL from config
  bool _isLoading = false;
  String _error = '';
  Map<String, dynamic>? _lastPrediction;

  bool get isLoading => _isLoading;
  String get error => _error;
  Map<String, dynamic>? get lastPrediction => _lastPrediction;

  void setApiUrl(String url) {
    _apiUrl = url;
    notifyListeners();
  }

  Future<bool> predictBikeRentals({
    required int season,
    required int yr,
    required int mnth,
    required int holiday,
    required int weekday,
    required int workingday,
    required int weathersit,
    required double temp,
    required double atemp,
    required double hum,
    required double windspeed,
    required int dayOfYear,
    required int month,
    required int dayOfWeek,
  }) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    // Create request data
    final requestData = {
      'season': season,
      'yr': yr,
      'mnth': mnth,
      'holiday': holiday,
      'weekday': weekday,
      'workingday': workingday,
      'weathersit': weathersit,
      'temp': temp,
      'atemp': atemp,
      'hum': hum,
      'windspeed': windspeed,
      'day_of_year': dayOfYear,
      'month': month,
      'day_of_week': dayOfWeek,
    };

    print('🌐 Making API request to: ${ApiConfig.getPredictUrl()}');
    print('📤 Request data: $requestData');

    try {
      final response = await http.post(
        Uri.parse(ApiConfig.getPredictUrl()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(requestData),
      );

      print('📥 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 200) {
        _lastPrediction = json.decode(response.body);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Prediction failed: ${response.statusCode} - ${response.body}';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('❌ Network error: $e');
      _error = 'Network error: $e\n\nMake sure your API is running at ${ApiConfig.getApiUrl()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }

  void clearPrediction() {
    _lastPrediction = null;
    notifyListeners();
  }

  // Test API connection
  Future<bool> testApiConnection() async {
    try {
      final response = await http.get(Uri.parse(ApiConfig.getHealthUrl()));
      print('🔍 API Health Check: ${response.statusCode} - ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('❌ API Health Check Failed: $e');
      return false;
    }
  }
}

ChangeNotifierProvider(
  create: (_) => PredictionProvider(),
  child: MyApp(),
)