import 'dart:async' show runZonedGuarded;
import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/features/auth/export.dart';
import 'src/app/app_widget.dart';
import 'src/app/config/app_config.dart';
import 'src/app/binding/app_bindings.dart';
import 'src/base/datasource/exports.dart';
import 'src/core/api/requester_config.dart';
part 'error_handling.dart';

void main() => runZonedGuarded(_application, _recordError);

void _application() async {
  await AppBinding().all();

  AppEnvironment.setupEnvironment(Environment.dev);

  AppConfig.setInitialRoute(signUpRoute.path);

  ConnectivityPlus.init();

  RequesterConfig.configure();

  runApp(
    const AppWidget(
      showMaterialGrid: false,
      invertOversizedImages: true,
      showPerformanceOverlay: false,
    ),
  );
}
