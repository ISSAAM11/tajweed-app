import 'dart:async';

import 'package:flutter/material.dart';

import 'src/app/app_widget.dart';
import 'src/app/binding/app_bindings.dart';
import 'src/core/api/requester_config.dart';

part 'error_handling.dart';

void main() => runZonedGuarded(() async {
  await AppBinding().all();

  AppEnvironment.setupEnvironment(Environment.dev);

  RequesterConfig.configure();

  runApp(
    const AppWidget(
      showMaterialGrid: false,
      invertOversizedImages: true,
      showPerformanceOverlay: false,
    ),
  );
}, _recordError);
