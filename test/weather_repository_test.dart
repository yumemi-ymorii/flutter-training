import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/weather/data/weather_exception.dart';
import 'package:flutter_training/weather/location.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_condition.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_repository_test.mocks.dart';

@GenerateMocks([YumemiWeather])
void main() {
  final location = Location(
    area: 'tokyo',
    date: DateTime.parse('2020-04-24T12:09:46+09:00'),
  );
  final locationJson = location.toJson();
  jsonEncode(locationJson);

  group('weatherRepositoryの正常系テスト', () {
    test('When WeatherDataSource returns sunny.', () {
      // Arrange
      final mockYumemiWeather = MockYumemiWeather();
      final weatherRepository =
          WeatherRepository(weatherApi: mockYumemiWeather);

      const result = '''
{
  "weather_condition":"sunny",
  "max_temperature":26,
  "min_temperature":3,
  "date":"2020-04-01T12:00:00+09:00"
}''';
      when(mockYumemiWeather.fetchWeather(any)).thenReturn(result);

      const expected = Weather(
        condition: WeatherCondition.sunny,
        maxTemperature: 26,
        minTemperature: 3,
      );

      // Act
      final actual = weatherRepository.fetchWeather(location);

      // Assert
      expect(
        actual,
        expected,
      );
    });
  });

  group('weatherRepositoryの異常系テスト', () {
    test('When Invalidate response', () {
      // Arrange
      final mockYumemiWeather = MockYumemiWeather();
      final weatherRepository =
          WeatherRepository(weatherApi: mockYumemiWeather);

      const result = '';
      when(mockYumemiWeather.fetchWeather(any)).thenReturn(result);

      // Act
      Weather actual() => weatherRepository.fetchWeather(location);

      // Assert
      expect(
        actual,
        throwsA(const TypeMatcher<JsonDecodeException>()),
      );
    });

    test('When raised InvalidParameter error', () {
      // Arrange
      final mockYumemiWeather = MockYumemiWeather();
      final weatherRepository =
          WeatherRepository(weatherApi: mockYumemiWeather);

      when(mockYumemiWeather.fetchWeather(any))
          .thenThrow(YumemiWeatherError.invalidParameter);

      // Act
      Weather actual() => weatherRepository.fetchWeather(location);

      // Assert
      expect(
        actual,
        throwsA(const TypeMatcher<InvalidParameterException>()),
      );
    });

    test('When raised UnkownException error', () {
      // Arrange
      final mockYumemiWeather = MockYumemiWeather();
      final weatherRepository =
          WeatherRepository(weatherApi: mockYumemiWeather);

      when(mockYumemiWeather.fetchWeather(any))
          .thenThrow(YumemiWeatherError.unknown);

      // Act
      Weather actual() => weatherRepository.fetchWeather(location);

      // Assert
      expect(
        actual,
        throwsA(const TypeMatcher<UnkownException>()),
      );
    });
  });
}