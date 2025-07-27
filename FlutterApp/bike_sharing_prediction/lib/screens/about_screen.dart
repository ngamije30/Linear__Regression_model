import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bike Sharing Demand Prediction',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Mission: Sustainable Urban Mobility',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'This application predicts bike rental demand to optimize bike availability and reduce urban congestion.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              'Features:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildFeatureItem('📊 Machine Learning Model', 'Uses Random Forest algorithm for accurate predictions'),
            _buildFeatureItem('🌤️ Weather Integration', 'Considers temperature, humidity, wind speed, and weather conditions'),
            _buildFeatureItem('📅 Temporal Factors', 'Accounts for seasons, holidays, weekdays, and working days'),
            _buildFeatureItem('📱 Mobile Interface', 'User-friendly Flutter app with real-time predictions'),
            _buildFeatureItem('🔗 API Integration', 'RESTful API with FastAPI for scalable backend'),
            const SizedBox(height: 30),
            const Text(
              'Input Parameters:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildParameterItem('Season', '1=Spring, 2=Summer, 3=Fall, 4=Winter'),
            _buildParameterItem('Year', '0=2011, 1=2012'),
            _buildParameterItem('Month', '1-12 (January to December)'),
            _buildParameterItem('Holiday', '0=No, 1=Yes'),
            _buildParameterItem('Weekday', '0=Sunday, 1=Monday, ..., 6=Saturday'),
            _buildParameterItem('Working Day', '0=No, 1=Yes'),
            _buildParameterItem('Weather', '1=Clear, 2=Mist, 3=Light Rain, 4=Heavy Rain'),
            _buildParameterItem('Temperature', '0.0-1.0 (normalized)'),
            _buildParameterItem('Feeling Temperature', '0.0-1.0 (normalized)'),
            _buildParameterItem('Humidity', '0.0-1.0 (normalized)'),
            _buildParameterItem('Wind Speed', '0.0-1.0 (normalized)'),
            const SizedBox(height: 30),
            const Text(
              'Technical Stack:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildTechItem('Frontend', 'Flutter (Dart)'),
            _buildTechItem('Backend', 'FastAPI (Python)'),
            _buildTechItem('Machine Learning', 'Scikit-learn, Random Forest'),
            _buildTechItem('Data Processing', 'Pandas, NumPy'),
            _buildTechItem('API Documentation', 'Swagger UI'),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Model Performance:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('• R² Score: 0.85+'),
                  Text('• Mean Absolute Error: Low'),
                  Text('• Handles various weather conditions'),
                  Text('• Optimized for urban mobility'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParameterItem(String name, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechItem(String category, String technology) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Text(
            '$category: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            technology,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
} 