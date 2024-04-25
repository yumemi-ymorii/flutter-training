import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                _WeatherTmp(),
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

class _WeatherTmp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final logoWidth = screenSize.width * 0.5;

    const defaultTemp = '**℃';
    final tempTextStyle = Theme.of(context).textTheme.labelLarge!;

    final placeholder = SizedBox.square(
      dimension: logoWidth,
      child: const Placeholder(),
    );

    final tempTextGroup = Row(
      children: [
        Expanded(
          child: Text(
            defaultTemp,
            textAlign: TextAlign.center,
            style: tempTextStyle.copyWith(color: Colors.blue),
          ),
        ),
        Expanded(
          child: Text(
            defaultTemp,
            textAlign: TextAlign.center,
            style: tempTextStyle.copyWith(color: Colors.red),
          ),
        ),
      ],
    );

    return Column(
      children: [
        placeholder,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: tempTextGroup,
        ),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final logoWidth = screenSize.width * 0.5;
    final textWidth = logoWidth * 0.5;

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
