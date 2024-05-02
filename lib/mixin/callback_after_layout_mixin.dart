import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

mixin CallbackAfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    unawaited(
      SchedulerBinding.instance.endOfFrame.then((_) => callbackAfterLayout()),
    );
  }

  void callbackAfterLayout();
}
