import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? _weatherCodition;

  void _reloadWeatherCondition() {
    final yumemiWeather = YumemiWeather();
    setState(() {
      _weatherCodition = yumemiWeather.fetchSimpleWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox.expand(
          child: FractionallySizedBox(
            widthFactor: 0.5,
            alignment: FractionalOffset.center,
            child: Column(
              children: <Widget>[
                const Spacer(),
                _WeatherTemperature(
                  weatherCondition: _weatherCodition,
                ),
                Flexible(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      _Buttons(
                        onReloaded: _reloadWeatherCondition,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({required String weatherCondition})
      : _weatherCondition = weatherCondition;
  final String _weatherCondition;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/$_weatherCondition.svg',
    );
  }
}

class _WeatherTemperature extends StatelessWidget {
  const _WeatherTemperature({
    String? weatherCondition,
  }) : _weatherCondition = weatherCondition;
  final String? _weatherCondition;

  @override
  Widget build(BuildContext context) {
    const defaultTemperature = '**℃';
    final temperatureTextStyle = Theme.of(context).textTheme.labelLarge!;

    final weatherIcon = switch (_weatherCondition) {
      null => const Placeholder(),
      final String value => _WeatherIcon(weatherCondition: value),
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

class _Buttons extends StatelessWidget {
  const _Buttons({
    required void Function() onReloaded,
  }) : _onReloaded = onReloaded;
  final VoidCallback _onReloaded;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final textWidth = screenSize.width / 4;

    return Row(
      children: [
        SizedBox(
          width: textWidth,
          child: Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('Close'),
            ),
          ),
        ),
        SizedBox(
          width: textWidth,
          child: Center(
            child: TextButton(
              onPressed: _onReloaded,
              child: const Text('Reload'),
            ),
          ),
        ),
      ],
    );
  }
}
