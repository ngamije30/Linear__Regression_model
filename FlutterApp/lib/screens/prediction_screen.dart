import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/prediction_provider.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers for text fields
  final _seasonController = TextEditingController(text: '2');
  final _yrController = TextEditingController(text: '1');
  final _mnthController = TextEditingController(text: '6');
  final _holidayController = TextEditingController(text: '0');
  final _weekdayController = TextEditingController(text: '1');
  final _workingdayController = TextEditingController(text: '1');
  final _weathersitController = TextEditingController(text: '1');
  final _tempController = TextEditingController(text: '0.5');
  final _atempController = TextEditingController(text: '0.5');
  final _humController = TextEditingController(text: '0.6');
  final _windspeedController = TextEditingController(text: '0.2');
  final _dayOfYearController = TextEditingController(text: '150');
  final _monthController = TextEditingController(text: '6');
  final _dayOfWeekController = TextEditingController(text: '1');

  @override
  void dispose() {
    _seasonController.dispose();
    _yrController.dispose();
    _mnthController.dispose();
    _holidayController.dispose();
    _weekdayController.dispose();
    _workingdayController.dispose();
    _weathersitController.dispose();
    _tempController.dispose();
    _atempController.dispose();
    _humController.dispose();
    _windspeedController.dispose();
    _dayOfYearController.dispose();
    _monthController.dispose();
    _dayOfWeekController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Prediction'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<PredictionProvider>(
        builder: (context, predictionProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Input fields
                  _buildInputField(
                    controller: _seasonController,
                    label: 'Season (1=Spring, 2=Summer, 3=Fall, 4=Winter)',
                    validator: (value) => _validateRange(value, 1, 4),
                  ),
                  _buildInputField(
                    controller: _yrController,
                    label: 'Year (0=2011, 1=2012)',
                    validator: (value) => _validateRange(value, 0, 1),
                  ),
                  _buildInputField(
                    controller: _mnthController,
                    label: 'Month (1-12)',
                    validator: (value) => _validateRange(value, 1, 12),
                  ),
                  _buildInputField(
                    controller: _holidayController,
                    label: 'Holiday (0=No, 1=Yes)',
                    validator: (value) => _validateRange(value, 0, 1),
                  ),
                  _buildInputField(
                    controller: _weekdayController,
                    label: 'Weekday (0=Sunday, 1=Monday, ..., 6=Saturday)',
                    validator: (value) => _validateRange(value, 0, 6),
                  ),
                  _buildInputField(
                    controller: _workingdayController,
                    label: 'Working Day (0=No, 1=Yes)',
                    validator: (value) => _validateRange(value, 0, 1),
                  ),
                  _buildInputField(
                    controller: _weathersitController,
                    label: 'Weather (1=Clear, 2=Mist, 3=Light Rain, 4=Heavy Rain)',
                    validator: (value) => _validateRange(value, 1, 4),
                  ),
                  _buildInputField(
                    controller: _tempController,
                    label: 'Temperature (0.0-1.0)',
                    validator: (value) => _validateFloat(value, 0.0, 1.0),
                  ),
                  _buildInputField(
                    controller: _atempController,
                    label: 'Feeling Temperature (0.0-1.0)',
                    validator: (value) => _validateFloat(value, 0.0, 1.0),
                  ),
                  _buildInputField(
                    controller: _humController,
                    label: 'Humidity (0.0-1.0)',
                    validator: (value) => _validateFloat(value, 0.0, 1.0),
                  ),
                  _buildInputField(
                    controller: _windspeedController,
                    label: 'Wind Speed (0.0-1.0)',
                    validator: (value) => _validateFloat(value, 0.0, 1.0),
                  ),
                  _buildInputField(
                    controller: _dayOfYearController,
                    label: 'Day of Year (1-366)',
                    validator: (value) => _validateRange(value, 1, 366),
                  ),
                  _buildInputField(
                    controller: _monthController,
                    label: 'Month (1-12)',
                    validator: (value) => _validateRange(value, 1, 12),
                  ),
                  _buildInputField(
                    controller: _dayOfWeekController,
                    label: 'Day of Week (0-6)',
                    validator: (value) => _validateRange(value, 0, 6),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Predict button
                  ElevatedButton(
                    onPressed: predictionProvider.isLoading
                        ? null
                        : _makePrediction,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: predictionProvider.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Predict'),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Error display
                  if (predictionProvider.error.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Text(
                        predictionProvider.error,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  
                  // Result display
                  if (predictionProvider.lastPrediction != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Prediction Result:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Predicted Rentals: ${predictionProvider.lastPrediction!['predicted_rentals']}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Confidence: ${(predictionProvider.lastPrediction!['confidence'] * 100).toStringAsFixed(1)}%',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Message: ${predictionProvider.lastPrediction!['message']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        keyboardType: TextInputType.number,
        validator: validator,
      ),
    );
  }

  String? _validateRange(String? value, int min, int max) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final intValue = int.tryParse(value);
    if (intValue == null) {
      return 'Please enter a valid number';
    }
    if (intValue < min || intValue > max) {
      return 'Value must be between $min and $max';
    }
    return null;
  }

  String? _validateFloat(String? value, double min, double max) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    final doubleValue = double.tryParse(value);
    if (doubleValue == null) {
      return 'Please enter a valid number';
    }
    if (doubleValue < min || doubleValue > max) {
      return 'Value must be between $min and $max';
    }
    return null;
  }

  void _makePrediction() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<PredictionProvider>(context, listen: false);
      
      provider.predictBikeRentals(
        season: int.parse(_seasonController.text),
        yr: int.parse(_yrController.text),
        mnth: int.parse(_mnthController.text),
        holiday: int.parse(_holidayController.text),
        weekday: int.parse(_weekdayController.text),
        workingday: int.parse(_workingdayController.text),
        weathersit: int.parse(_weathersitController.text),
        temp: double.parse(_tempController.text),
        atemp: double.parse(_atempController.text),
        hum: double.parse(_humController.text),
        windspeed: double.parse(_windspeedController.text),
        dayOfYear: int.parse(_dayOfYearController.text),
        month: int.parse(_monthController.text),
        dayOfWeek: int.parse(_dayOfWeekController.text),
      );
    }
  }
} 