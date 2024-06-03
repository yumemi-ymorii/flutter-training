import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/weather/weather_condition.dart';
import 'package:flutter_training/weather/weather_icon.dart';
import 'package:flutter_training/weather/weather_notifier.dart';

class WeatherPanel extends ConsumerWidget {
  const WeatherPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(weatherNotifierProvider);
    const defaultTemperature = '**℃';
    final weatherMaxTemperature = weather?.maxTemperature;
    final weatherMinTemperature = weather?.minTemperature;
    final temperatureTextStyle = Theme.of(context).textTheme.labelLarge!;

    final weatherIcon = switch (weather?.condition) {
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
