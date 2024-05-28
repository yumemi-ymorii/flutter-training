import 'dart:convert';

import 'package:flutter_training/weather/location.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherRepository {
  WeatherRepository({required YumemiWeather weatherApi})
      : _weatherApi = weatherApi;

  final YumemiWeather _weatherApi;
  Weather fetchWeather(Location location) {
    final locationJson = location.toJson();
    final locationJsonString = jsonEncode(locationJson);

    final weatherText = _weatherApi.fetchWeather(locationJsonString);
    return switch (jsonDecode(weatherText)) {
      final Map<String, dynamic> weatherMap => Weather.fromJson(weatherMap),
      _ => throw Exception(),
    };
  }
}
