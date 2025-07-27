import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/prediction_screen.dart';
import 'screens/about_screen.dart';
import 'providers/prediction_provider.dart';

void main() {
  runApp(const BikeSharingApp());
}

class BikeSharingApp extends StatelessWidget {
  const BikeSharingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PredictionProvider(),
      child: MaterialApp(
        title: 'Bike Sharing Prediction',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 2,
          ),
        ),
        home: const HomeScreen(),
        routes: {
          '/prediction': (context) => const PredictionScreen(),
          '/about': (context) => const AboutScreen(),
        },
      ),
    );
  }
} 