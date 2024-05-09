import 'dart:async';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_training/weather/weather_alert_dialog.dart';
import 'package:flutter_training/weather/weather_panel.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherScreen();
}

class _WeatherScreen extends State<WeatherScreen> {
  String? _weatherCodition;

  void _reloadWeatherCondition() {
    const location = 'tokyoß';
    final yumemiWeather = YumemiWeather();
    try {
      final weatherCoditionText = yumemiWeather.fetchThrowsWeather(location);
      final weatherCondition = WeatherCondition.values.firstWhereOrNull(
        (w) => w.name == weatherCoditionText,
      );

      if (weatherCondition == null) {
        const errorMessage = '予期しない天気が取得されました。'
            '時間を置いてもエラーが発生する場合はお問い合わせお願いいたします。';
        showWeatherAlertDialog(errorMessage);
      }
      setState(() {
        _weatherCodition = weatherCondition?.name;
      });
    } on YumemiWeatherError catch (e) {
      final errorMessage = switch (e) {
        YumemiWeatherError.invalidParameter => '「$location」は無効な地域名です',
        YumemiWeatherError.unknown => '予期せぬエラーが発生しております。'
            '時間を置いてもエラーが発生する場合はお問い合わせお願いいたします。',
      };
      showWeatherAlertDialog(errorMessage);
    }
  }

  void _closeWeatherScreen() {
    Navigator.pop(context);
  }

  void showWeatherAlertDialog(String errorMessage) {
    if (!mounted) {
      return;
    }
    unawaited(
      showDialog<String>(
        context: context,
        builder: (context) => WeatherAlertDialog(errorMessage: errorMessage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          alignment: FractionalOffset.center,
          child: Column(
            children: <Widget>[
              const Spacer(),
              WeatherPanel(
                weatherCondition: _weatherCodition,
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    _Buttons(
                      onClose: _closeWeatherScreen,
                      onReload: _reloadWeatherCondition,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    required void Function() onReload,
    required void Function() onClose,
  })  : _onReload = onReload,
        _onClose = onClose;
  final VoidCallback _onReload;
  final VoidCallback _onClose;
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
              onPressed: _onClose,
              child: const Text('Close'),
            ),
          ),
        ),
        SizedBox(
          width: textWidth,
          child: Center(
            child: TextButton(
              onPressed: _onReload,
              child: const Text('Reload'),
            ),
          ),
        ),
      ],
    );
  }
}
