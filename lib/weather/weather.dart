import 'package:flutter_training/weather/weather_condition.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  Weather({
    required this.condition,
    required this.maxTemperature,
    required this.minTemperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  @JsonKey(name: 'weather_condition')
  final WeatherCondition condition;
  final String maxTemperature;
  final String minTemperature;

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
