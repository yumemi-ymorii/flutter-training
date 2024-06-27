import 'package:flutter_training/weather/location.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_notifier.g.dart';

@riverpod
class WeatherNotifier extends _$WeatherNotifier {
  WeatherRepository get _weatherRepository =>
      ref.read(weatherRepositoryProvider);

  @override
  Weather? build() {
    return null;
  }

  Future<void> fetchWeather(Location location) async {
    final weather = await _weatherRepository.fetchWeather(location);
    state = weather;
  }
}
