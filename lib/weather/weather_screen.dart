import 'package:flutter/material.dart';
import 'package:flutter_training/green_panel.dart';
import 'package:flutter_training/weather/weather_panel.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherScreen();
}

class _WeatherScreen extends State<WeatherScreen> {
  String? _weatherCodition;

  void _reloadWeatherCondition() {
    final yumemiWeather = YumemiWeather();
    setState(() {
      _weatherCodition = yumemiWeather.fetchSimpleWeather();
    });
  }

  Future<void> _closeWeatherScreen() async {
    await Navigator.of(context).push<void>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const GreenPanel();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(-1, 0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: Curves.easeInOut));
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
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
                      onReloaded: _reloadWeatherCondition,
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
    required void Function() onReloaded,
    required void Function() onClose,
  })  : _onReloaded = onReloaded,
        _onClose = onClose;
  final VoidCallback _onReloaded;
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
              // 後で関数にしたい
              onPressed: _onClose,
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
