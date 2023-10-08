import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_app/services/core/config.dart';

final authenticationServiceProvider =
    ChangeNotifierProvider<AuthenticationService>((ref) {
  return AuthenticationService();
});

class AuthenticationService extends ChangeNotifier {
  AuthenticationService() {
    initUserToken();
  }

  String _accessToken = "";

  String get accessToken => _accessToken;

  set accessToken(String value) {
    _accessToken = value;
    notifyListeners();
  }

  User _appUserData = User();

  User get appUserData => _appUserData;

  set appUserData(User value) {
    _appUserData = value;
    notifyListeners();
  }

  Future<void> initUserToken() async {
    accessToken = Config.getTokenAPI;
  }
}

class User {
  String firstName = "";
  String secondName = "";
  double latitude = 0; // "latitude": 45.4836389,
  double longitude = 0; // "longitude": 9.2249464,
}
