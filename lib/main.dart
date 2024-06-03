import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/loading_view.dart';
import 'package:flutter_training/screen.dart';
import 'package:flutter_training/weather/weather_screen.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Screen.loading.route: (context) => const LoadingView(),
        Screen.weatherScreen.route: (context) => const WeatherScreen(),
      },
      initialRoute: Screen.loading.route,
    );
  }
}
