import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:open_weather_app/models/data/CurrentWeatherData.dart';

import '../providers/get_current_weather_data.dart';
import '../services/classes/authentication.dart';
import '../services/core/config.dart';
import '../services/network/cms_helpers.dart';

Future<CurrentWeatherData> getCurrentWeatherDataApi(AuthenticationService auth,
    {GetCurrentWeatherDataArgs? getCurrentWeatherDataArgs}) async {
  final dio = Dio(dioBaseOptions());
  late final dynamic response;
  Map<String, dynamic> queryParameters = {
    'lat': getCurrentWeatherDataArgs?.latitude ?? auth.appUserData.latitude,
    'lon': getCurrentWeatherDataArgs?.longitude ?? auth.appUserData.longitude,
    'units': Config.units.name,
    'appid': auth.accessToken,
  };
  try {
    response =
        await dio.post('/data/2.5/weather', queryParameters: queryParameters);
  } on DioException catch (e) {
    dioErrorHandler(e, moduleName: "getCurrentWeatherDataApi");
    // rethrow;
    throw Exception("Access to CMS: ${e.message}");
  }
  CurrentWeatherData results = CurrentWeatherData();
  final json = response.data;
  try {
    results = CurrentWeatherData.fromJson(json);
  } catch (error) {
    developer.log("Error is $error", name: "getCurrentWeatherDataApi");
    throw Exception("Access to CMS: $error");
    // rethrow;
  }
  return results;
}
