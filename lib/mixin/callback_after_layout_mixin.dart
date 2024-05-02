import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

mixin CallbackAfterLayoutMixin on State {
  @override
  void initState() {
    super.initState();
    unawaited(
      SchedulerBinding.instance.endOfFrame.then((_) => callbackAfterLayout()),
    );
  }

  void callbackAfterLayout();
}
