import 'dart:async' show runZonedGuarded, unawaited;

import 'package:flutter/material.dart';

import 'src/app/app_widget.dart';
import 'src/app/binding/app_bindings.dart';
import 'src/app/config/app_config.dart';
import 'src/base/datasource/exports.dart';
import 'src/core/api/requester_config.dart';

part 'error_handling.dart';

void main() => runZonedGuarded(_application, _recordError);

void _application() async {
  await AppBinding().all();
  await di.allReady();

  AppEnvironment.setupEnvironment(Environment.dev);

  ConnectivityPlus.init();

  RequesterConfig.configure();

  unawaited(refreshReciterCatalog());

  await AppConfig.setInitialRoute();

  runApp(
    const AppWidget(
      showMaterialGrid: false,
      invertOversizedImages: true,
      showPerformanceOverlay: false,
    ),
  );
}
