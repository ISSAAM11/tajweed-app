import 'dart:async' show runZonedGuarded;

import 'package:flutter/material.dart';
import 'package:tajweed_ai/src/features/auth/2_sign_in/router/sign_in_route.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/router/surah_listing_route.dart';

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

  await AppBinding().all();

  ConnectivityPlus.init();

  RequesterConfig.configure();

  await AppConfig.setInitialRoute(quranListingRoute.path);

  runApp(
    const AppWidget(
      showMaterialGrid: false,
      invertOversizedImages: true,
      showPerformanceOverlay: false,
    ),
  );
}
