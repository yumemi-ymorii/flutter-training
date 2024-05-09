import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/weather/weather_condition.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({required WeatherCondition weatherCondition, super.key})
      : _weatherCondition = weatherCondition;
  final WeatherCondition _weatherCondition;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/${_weatherCondition.name}.svg',
    );
  }
}
