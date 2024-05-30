import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/weather/location.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_alert_dialog.dart';
import 'package:flutter_training/weather/weather_notifier.dart';
import 'package:flutter_training/weather/weather_panel.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreen();
}

class _WeatherScreen extends ConsumerState<WeatherScreen> {
  final _yumemiWeather = YumemiWeather();
  late final _weatherRepositry = WeatherRepository(weatherApi: _yumemiWeather);

  void _reloadWeatherCondition() {
    final location = Location(
      area: 'tokyo',
      date: DateTime.parse('2020-04-01T12:00:00+09:00'),
    );

    try {
      final weather = _weatherRepositry.fetchWeather(location);
      ref.read(weatherNotifierProvider.notifier).update(weather);
    } on YumemiWeatherError catch (e) {
      final errorMessage = switch (e) {
        YumemiWeatherError.invalidParameter => '「$location」は無効な地域名です',
        YumemiWeatherError.unknown => '予期せぬエラーが発生しております。'
            '時間を置いてもエラーが発生する場合はお問い合わせお願いいたします。',
      };
      _showWeatherAlertDialog(errorMessage);
    } on CheckedFromJsonException catch (_) {
      const errorMessage = '予期しない天気が取得されました。'
          '時間を置いてもエラーが発生する場合はお問い合わせお願いいたします。';
      _showWeatherAlertDialog(errorMessage);
    } on Exception catch (_) {
      const errorMessage = '予期しない天気が取得されました。'
          '時間を置いてもエラーが発生する場合はお問い合わせお願いいたします。';
      _showWeatherAlertDialog(errorMessage);
    }
  }

  void _closeWeatherScreen() {
    Navigator.pop(context);
  }

  void _showWeatherAlertDialog(String errorMessage) {
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
              const WeatherPanel(),
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
