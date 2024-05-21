import 'package:flutter/material.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_condition.dart';
import 'package:flutter_training/weather/weather_icon.dart';

class WeatherPanel extends StatelessWidget {
  const WeatherPanel({
    super.key,
    Weather? weather,
  }) : _weather = weather;

  final Weather? _weather;

  @override
  Widget build(BuildContext context) {
    const defaultTemperature = '**℃';
    final weatherMaxTemperature = _weather?.maxTemperature;
    final weatherMinTemperature = _weather?.minTemperature;
    final temperatureTextStyle = Theme.of(context).textTheme.labelLarge!;

    final weatherIcon = switch (_weather?.condition) {
      null => const Placeholder(),
      final WeatherCondition value => WeatherIcon(weatherCondition: value),
    };

    final temperatureTextGroup = Row(
      children: [
        Expanded(
          child: Text(
            weatherMinTemperature == null
                ? defaultTemperature
                : '$weatherMinTemperature℃',
            textAlign: TextAlign.center,
            style: temperatureTextStyle.copyWith(color: Colors.blue),
          ),
        ),
        Expanded(
          child: Text(
            weatherMaxTemperature == null
                ? defaultTemperature
                : '$weatherMaxTemperature℃',
            textAlign: TextAlign.center,
            style: temperatureTextStyle.copyWith(color: Colors.red),
          ),
        ),
      ],
    );

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: weatherIcon,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: temperatureTextGroup,
        ),
      ],
    );
  }
}
