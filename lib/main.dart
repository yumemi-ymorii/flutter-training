import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
                const _WeatherTemperature(),
                Flexible(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      _Buttons(
                        onReloaded: () {},
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

class WeatherIcon extends StatefulWidget {
  final String weather;
  WeatherIcon({required this.weather});

  @override
  _WeatherIcon createState() => _WeatherIcon();
}

class _WeatherIcon extends State<WeatherIcon> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final logoWidth = screenSize.width * 0.5;

    if (widget.weather != '') {
      return SizedBox.square(
        dimension: logoWidth,
        child: const Placeholder(),
      );
    }

    return SvgPicture.asset(
      'assets/${widget.weather}.svg',
      width: logoWidth,
      height: logoWidth,
    );
  }
}

class _WeatherTemperature extends StatelessWidget {
  const _WeatherTemperature();

  @override
  Widget build(BuildContext context) {
    const defaultTemperature = '**℃';
    final temperatureTextStyle = Theme.of(context).textTheme.labelLarge!;

    const placeholder = AspectRatio(
      aspectRatio: 1,
      child: Placeholder(),
    );

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
        WeatherIcon(
          weather: 'cloudy',
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
