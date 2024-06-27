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

  // テストで共通して使用するmockをあらかじめ作成
  final mockYumemiWeather = MockYumemiWeather();
  final weatherRepository = WeatherRepository(weatherApi: mockYumemiWeather);

  // mockの初期化
  tearDown(() {
    reset(mockYumemiWeather);
  });

  group('weatherRepositoryの正常系テスト', () {
    test('API結果で天気が晴れの場合', () async {
      // Arrange

      const result = '''
{
  "weather_condition":"sunny",
  "max_temperature":26,
  "min_temperature":3,
  "date":"2020-04-01T12:00:00+09:00"
}''';
      when(mockYumemiWeather.syncFetchWeather(any)).thenReturn(result);

      const expected = Weather(
        condition: WeatherCondition.sunny,
        maxTemperature: 26,
        minTemperature: 3,
      );

      // Act
      final actual = await weatherRepository.fetchWeather(location);

      // Assert
      expect(
        actual,
        expected,
      );
    });
  });

  group('weatherRepositoryの異常系テスト', () {
    test('想定外の形式・値APIレスポンスが返ってきた場合にJsonDecodeExceptionが発生する', () {
      // Arrange
      const result = '';
      when(mockYumemiWeather.syncFetchWeather(any)).thenReturn(result);

      // Act
      Future<Weather> actual() async =>
          weatherRepository.fetchWeather(location);

      // Assert
      expect(
        actual,
        throwsA(const TypeMatcher<JsonDecodeException>()),
      );
    });

    test('InvalidParameterError が発生した時に InvalidParameterException をキャッチ', () {
      // Arrange
      when(mockYumemiWeather.syncFetchWeather(any))
          .thenThrow(YumemiWeatherError.invalidParameter);

      // Act
      Future<Weather> actual() async =>
          weatherRepository.fetchWeather(location);

      // Assert
      expect(
        actual,
        throwsA(const TypeMatcher<InvalidParameterException>()),
      );
    });

    test('UnkownError が発生した時に UnkownException をキャッチ', () {
      // Arrange
      when(mockYumemiWeather.syncFetchWeather(any))
          .thenThrow(YumemiWeatherError.unknown);

      // Act
      Future<Weather> actual() async =>
          weatherRepository.fetchWeather(location);

      // Assert
      expect(
        actual,
        throwsA(const TypeMatcher<UnkownException>()),
      );
    });
  });
}
