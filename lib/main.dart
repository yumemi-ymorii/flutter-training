// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

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
                _WeatherTemperaturerature(),
                Flexible(
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      _Buttons(),
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

class _WeatherTemperaturerature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const defaultTemperature = '**℃';
    final temperatureTextStyle = Theme.of(context).textTheme.labelLarge!;

    const placeholder = AspectRatio(
      aspectRatio: 1,
      child: Placeholder(),
    );

    final TemperatureTextGroup = Row(
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
        placeholder,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: TemperatureTextGroup,
        ),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final textWidth = screenSize.width / 4;

    final buttonGroup = Row(
      children: [
        SizedBox(
          width: textWidth,
          child: Align(
            child: TextButton(
              onPressed: () {},
              child: const Text('Close'),
            ),
          ),
        ),
        SizedBox(
          width: textWidth,
          child: Align(
            child: TextButton(
              onPressed: () {},
              child: const Text('Reload'),
            ),
          ),
        ),
      ],
    );

    return buttonGroup;
  }
}
