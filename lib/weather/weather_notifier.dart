import 'package:flutter_training/weather/weather.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_notifier.g.dart';

@riverpod
class WeatherNotifier extends _$WeatherNotifier {
  @override
  Weather? build() {
    return null;
  }

  void update(Weather weather) {
    state = weather;
  }
}
