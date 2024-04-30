import 'package:flutter/material.dart';
import 'package:flutter_training/weather/weather_icon.dart';

class WeatherPanel extends StatelessWidget {
  const WeatherPanel({
    super.key,
    String? weatherCondition,
  }) : _weatherCondition = weatherCondition;
  final String? _weatherCondition;

  @override
  Widget build(BuildContext context) {
    const defaultTemperature = '**℃';
    final temperatureTextStyle = Theme.of(context).textTheme.labelLarge!;

    final weatherIcon = switch (_weatherCondition) {
      null => const Placeholder(),
      final String value => WeatherIcon(weatherCondition: value),
    };

    final temperatureTextGroup = Row(
      children: [
        Expanded(
          child: Text(
            defaultTemperature,
            textAlign: TextAlign.center,
            style: temperatureTextStyle.copyWith(color: Colors.blue),
          ),
        ),
        Expanded(
          child: Text(
            defaultTemperature,
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
