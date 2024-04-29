import 'package:flutter/material.dart';
import 'package:flutter_training/loading_view.dart';
import 'package:flutter_training/screen.dart';
import 'package:flutter_training/weather/weather_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoadingView(),
      routes: {
        Screen.launch.route: (context) => const LoadingView(),
        Screen.weatherScreen.route: (context) => const WeatherScreen(),
      },
    );
  }
}
