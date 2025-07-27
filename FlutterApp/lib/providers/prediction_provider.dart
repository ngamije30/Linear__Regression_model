import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionProvider with ChangeNotifier {
  String _apiUrl = 'http://127.0.0.1:8000'; // Local API URL - change to deployed URL for production
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

    try {
      final response = await http.post(
        Uri.parse('$_apiUrl/predict'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
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
        }),
      );

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
      _error = 'Network error: $e';
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
} 