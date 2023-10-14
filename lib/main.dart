import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_weather_app/services/core/config.dart';
import 'package:open_weather_app/services/network/cms_helpers.dart';

import 'app.dart';
import 'main.mapper.g.dart';

Future<void> main() async {
  // To initiate JsonMapper and to use the annotation @jsonSerializable
  // run the code generation step with the root of your package
  // as the current directory:
  // $ dart run build_runner build --delete-conflicting-outputs
  // You'll need to re-run code generation each time you are making
  // changes to lib/main.dart So for development time, use watch like this:
  // $ dart run build_runner watch --delete-conflicting-outputs
  initializeJsonMapper();

  // For resolve fails CERTIFICATE_VERIFY_FAILED for HTTPS site with no certificate
  HttpOverrides.global = CertificateVerifyResolve();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Initiating the Configuration of app
  await configInit(Flavor.DEVELOPMENT);

  // Start App
  runApp(const App());
}
