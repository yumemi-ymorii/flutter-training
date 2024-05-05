import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_training/green_panel.dart';
import 'package:flutter_training/screen.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<StatefulWidget> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  Future<void> transition() async {
    await SchedulerBinding.instance.endOfFrame;

    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (!mounted) {
      return;
    }

    await Navigator.pushNamed(context, Screen.weatherScreen.route);

    unawaited(transition());
  }

  @override
  void initState() {
    super.initState();
    unawaited(transition());
  }

  @override
  Widget build(BuildContext context) {
    return const GreenPanel();
  }
}
