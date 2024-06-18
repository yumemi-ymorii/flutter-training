import 'package:flutter_training/weather/weather_condition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.g.dart';
part 'weather.freezed.dart';

@freezed
class Weather with _$Weather {
  const factory Weather({
    @JsonKey(name: 'weather_condition') required WeatherCondition condition,
    required int maxTemperature,
    required int minTemperature,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}
