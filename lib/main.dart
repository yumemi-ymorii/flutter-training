import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SizedBox.expand(
          child: FractionallySizedBox(
            widthFactor: 0.5,
            alignment: FractionalOffset.center,
            child: Column(
              children: <Widget>[
                Spacer(),
                _WeatherTemperature(),
                Flexible(
                  child: Column(
                    children: [
                      SizedBox(height: 80),
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
        placeholder,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: temperatureTextGroup,
        ),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();
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
              onPressed: () {},
              child: const Text('Reload'),
            ),
          ),
        ),
      ],
    );
  }
}
