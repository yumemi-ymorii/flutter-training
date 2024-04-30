import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({required String weatherCondition, super.key})
      : _weatherCondition = weatherCondition;
  final String _weatherCondition;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/$_weatherCondition.svg',
    );
  }
}
