import 'package:flutter_training/weather/location.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_notifier.g.dart';

@riverpod
class WeatherNotifier extends _$WeatherNotifier {
  final _yumemiWeather = YumemiWeather();
  late final _weatherRepositry = WeatherRepository(weatherApi: _yumemiWeather);

  @override
  Weather? build() {
    return null;
  }

  void fetchWeather(Location location) {
    final weather = _weatherRepositry.fetchWeather(location);
    state = weather;
  }
}
