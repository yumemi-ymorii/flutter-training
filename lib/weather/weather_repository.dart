import 'dart:convert';

import 'package:flutter_training/weather/data/weather_exception.dart';
import 'package:flutter_training/weather/location.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_repository.g.dart';

@riverpod
WeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  final yumemiWeather = YumemiWeather();
  return WeatherRepository(weatherApi: yumemiWeather);
}

class WeatherRepository {
  WeatherRepository({required YumemiWeather weatherApi})
      : _weatherApi = weatherApi;

  final YumemiWeather _weatherApi;
  Weather fetchWeather(Location location) {
    final locationJson = location.toJson();
    final locationJsonString = jsonEncode(locationJson);

    try {
      final weatherText = _weatherApi.syncFetchWeather(locationJsonString);
      return switch (jsonDecode(weatherText)) {
        final Map<String, dynamic> weatherMap => Weather.fromJson(weatherMap),
        _ => throw InvalidResponseException(),
      };
    } on YumemiWeatherError catch (e) {
      final weatherException = switch (e) {
        YumemiWeatherError.invalidParameter => InvalidParameterException(),
        YumemiWeatherError.unknown => UnkownException(),
      };
      throw weatherException;
    } on FormatException catch (_) {
      throw JsonDecodeException();
    }
  }
}
