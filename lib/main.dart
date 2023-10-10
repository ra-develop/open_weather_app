import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_weather_app/services/core/config.dart';
import 'package:open_weather_app/services/network/cms_helpers.dart';

import 'app.dart';
import 'main.mapper.g.dart';

Future<void> main() async {
  initializeJsonMapper();
  // For resolve fails CERTIFICATE_VERIFY_FAILED for HTTPS site with no certificate
  HttpOverrides.global = CertificateVerifyResolve();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Initiating the Config
  await configInit(Flavor.DEVELOPMENT);

  // Start App
  runApp(const App());
}
