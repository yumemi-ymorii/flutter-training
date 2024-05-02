import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/green_panel.dart';
import 'package:flutter_training/mixin/callback_after_layout_mixin.dart';
import 'package:flutter_training/screen.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView>
    with CallbackAfterLayoutMixin {
  Future<void> transition() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (!mounted) {
      return;
    }

    await Navigator.pushNamed(context, Screen.weatherScreen.route);

    unawaited(transition());
  }

  @override
  Widget build(BuildContext context) {
    return const GreenPanel();
  }

  @override
  void callbackAfterLayout() {
    unawaited(transition());
  }
}
