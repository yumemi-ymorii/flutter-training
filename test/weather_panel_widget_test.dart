import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_test/flutter_svg_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/weather/data/weather_exception.dart';
import 'package:flutter_training/weather/location.dart';
import 'package:flutter_training/weather/weather.dart';
import 'package:flutter_training/weather/weather_condition.dart';
import 'package:flutter_training/weather/weather_panel.dart';
import 'package:flutter_training/weather/weather_repository.dart';
import 'package:flutter_training/weather/weather_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_panel_widget_test.mocks.dart';

void setUp(WidgetTester tester) {
  tester.view.devicePixelRatio = 1;
  // デフォルトはサイズが固定されている（小さい）
  // 研修で用いた端末のサイズと合わせる
  tester.view.physicalSize = const Size(1080, 2220);
}

@GenerateMocks([WeatherRepository])
void main() {
  final mockWeatherRepository = MockWeatherRepository();

  tearDown(() {
    reset(mockWeatherRepository);
  });

  group(' WeatherPanelの正常系テスト', () {
    testWidgets('天気情報が未取得の場合は Placeholder', (tester) async {
      setUp(tester);
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: WeatherPanel(),
          ),
        ),
      );

      expect(find.byType(Placeholder), findsOneWidget);
      expect(find.text('**℃'), findsNWidgets(2));
    });

    final cases = [
      (WeatherCondition.sunny, 'assets/sunny.svg'),
      (WeatherCondition.cloudy, 'assets/cloudy.svg'),
      (WeatherCondition.rainy, 'assets/rainy.svg'),
    ];

    for (final (condition, svg) in cases) {
      testWidgets('天気情報が ${condition.name} の場合に $svg が表示される', (tester) async {
        final weather = Weather(
          condition: condition,
          maxTemperature: 100,
          minTemperature: 0,
        );
        setUp(tester);

        final completer = Completer<Weather>();
        when(mockWeatherRepository.fetchWeather(any)).thenAnswer(
          (_) => completer.future,
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              weatherRepositoryProvider
                  .overrideWithValue(mockWeatherRepository),
            ],
            child: const MaterialApp(
              home: WeatherScreen(),
            ),
          ),
        );

        await tester.tap(find.text('Reload'));
        // 非同期処理を開始(Reloadボタン押下)
        await tester.pump();
        // インジケータが表示されているか
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        completer.complete(weather);
        await tester.pumpAndSettle();

        final asset = SvgPicture.asset(svg);
        expect(find.svg(asset.bytesLoader), findsOneWidget);
        expect(find.text('100℃'), findsOneWidget);
        expect(find.text('0℃'), findsOneWidget);
        // インジケータが消えているか
        expect(find.byType(CircularProgressIndicator), findsNothing);
      });
    }
  });
  group(' WeatherPanelの異常系テスト', () {
    final location = Location(
      area: 'tokyo',
      date: DateTime.parse('2020-04-24T12:09:46+09:00'),
    );

    final errorCases = [
      (InvalidParameterException(), '「${location.area}」は無効な地域名です'),
      (
        UnknownException(),
        '予期せぬエラーが発生しております。'
            '時間を置いてもエラーが発生する場合はお問い合わせお願いいたします。'
      ),
      (
        InvalidResponseException(),
        '予期せぬエラーが発生しております。'
            '時間を置いてもエラーが発生する場合はお問い合わせお願いいたします。'
      ),
      (
        JsonDecodeException(),
        '予期せぬエラーが発生しております。'
            '時間を置いてもエラーが発生する場合はお問い合わせお願いいたします。'
      ),
      (
        CheckedFromJsonException({}, null, '', null),
        '予期しない天気が取得されました。'
            '時間を置いてもエラーが発生する場合はお問い合わせお願いいたします。'
      ),
      (
        Exception(),
        '予期しない天気が取得されました。'
            '時間を置いてもエラーが発生する場合はお問い合わせお願いいたします。'
      ),
    ];

    for (final (exception, errorMessage) in errorCases) {
      testWidgets(
          '''${exception.runtimeType} がスローされた場合にダイアログで "$errorMessage" という文言が表示される''',
          (tester) async {
        setUp(tester);
        final completer = Completer<Weather>();
        when(mockWeatherRepository.fetchWeather(any)).thenAnswer(
          (_) => completer.future,
        );

        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              // 必ずAPIエラーを返すように書き換える
              weatherRepositoryProvider
                  .overrideWithValue(mockWeatherRepository),
            ],
            child: const MaterialApp(
              home: WeatherScreen(),
            ),
          ),
        );

        await tester.tap(find.text('Reload'));
        // 非同期処理を開始(Reloadボタン押下)
        await tester.pump();
        // インジケータが表示されているか
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        completer.completeError(exception);
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(
          find.text(errorMessage),
          findsOneWidget,
        );
        expect(find.text('OK'), findsOneWidget);

        // OKボタン押下でダイアログが閉じる
        await tester.tap(find.text('OK'));
        await tester.pumpAndSettle();

        expect(find.byType(AlertDialog), findsNothing);
        // インジケータが消えているか
        expect(find.byType(CircularProgressIndicator), findsNothing);
      });
    }
  });
}
