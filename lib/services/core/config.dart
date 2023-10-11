import 'dart:io';

import 'package:open_weather_app/models/enumerators/unit_measure.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Flavor { DEVELOPMENT, STAGE, PRODUCTION }


Future<void> configInit(Flavor flavor) async {
  Config.packageInfo = await PackageInfo.fromPlatform();

  // Setup Flavor
  Config.appFlavor = flavor;

  // Load App Preferences
  Config.appPreferences = await SharedPreferences.getInstance();

  // Check login status
  Config.loginStatus = Config.appPreferences.getBool("LoginStatus") ?? false;

  // Check first start status
  Config.firstStart = Config.appPreferences.getBool("FirstStart") ?? false;

  // Check introduction is viewed by viewed OnBoarding page
  Config.introPageIndex = Config.appPreferences.getInt('OnBoardPageIndex') ?? 0;

  //debug
  Config.debug = flavor == Flavor.DEVELOPMENT || flavor == Flavor.STAGE;
  Config.version = '1';

  // Used units of measurement
  Config.units = UnitMeasure.metric;
}

class Config {
  static String defaultIcon = "assets/images/lb_ic_sad_cloud.png";
  static Flavor appFlavor = Flavor.PRODUCTION;
  static late SharedPreferences appPreferences;
  static late bool loginStatus;
  static late int introPageIndex;
  static late bool firstStart;
  static late PackageInfo packageInfo;
  static Platform appPlatform = Platform();
  static late bool debug;
  static late String version;
  static late UnitMeasure units;

  static String get getApiBaseUrl {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'https://api.$getUrlDomainName';
      case Flavor.STAGE:
        return 'https://api.$getUrlDomainName';
      case Flavor.PRODUCTION:
      default:
        return 'https://api.$getUrlDomainName';
    }
  }

  static String get getImageBaseUrl {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'https://$getUrlDomainName/img/wn/';
      case Flavor.STAGE:
        return 'https://$getUrlDomainName/img/wn/';
      case Flavor.PRODUCTION:
      default:
        return 'https://$getUrlDomainName/img/wn/';
    }
  }

  static String get getUrlDomainName {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return 'openweathermap.org';
      case Flavor.STAGE:
        return 'openweathermap.org';
      case Flavor.PRODUCTION:
      default:
        return 'openweathermap.org';
    }
  }

  //For future implementation
  static String get getTokenAPI {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return "fac49951714858ff7db33f2dff3ad03a";
      case Flavor.STAGE:
        return "fac49951714858ff7db33f2dff3ad03a";
      case Flavor.PRODUCTION:
      default:
        return "fac49951714858ff7db33f2dff3ad03a";
    }
  }

// For example of flavour configuration
/*  static Icon get someOneIcon {
    switch (appFlavor) {
      case Flavor.PRODUCTION:
        return const Icon(Icons.new_releases);
      case Flavor.STAGE:
        return const Icon(Icons.new_releases_outlined);
      case Flavor.DEVELOPMENT:
      default:
        return const Icon(Icons.developer_mode);
    }
  }*/
}
