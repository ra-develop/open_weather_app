import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../models/data/FiveDayWeatherForecast.dart';
import '../providers/get_five_day_weather_forecast.dart';
import '../services/classes/authentication.dart';
import '../services/core/config.dart';
import '../services/network/cms_helpers.dart';

Future<FiveDayWeatherForecast> getFiveDayWeatherForecastApi(
    AuthenticationService auth,
    {GetFiveDayWeatherForecastArgs? getFiveDayWeatherForecastArgs}) async {
  final dio = Dio(dioBaseOptions());
  late final dynamic response;
  Map<String, dynamic> queryParameters = {
    'lat': getFiveDayWeatherForecastArgs?.latitude ?? auth.appUserData.latitude,
    'lon':
        getFiveDayWeatherForecastArgs?.longitude ?? auth.appUserData.longitude,
    'units': Config.units.name,
    'appid': auth.accessToken,
  };
  try {
    response =
        await dio.post('/data/2.5/forecast', queryParameters: queryParameters);
  } on DioException catch (e) {
    dioErrorHandler(e, moduleName: "getFiveDayWeatherForecastApi");
    // rethrow;
    throw Exception("Access to CMS: ${e.message}");
  }
  FiveDayWeatherForecast results = FiveDayWeatherForecast();
  final json = response.data;
  try {
    results = FiveDayWeatherForecast.fromJson(json);
  } catch (error) {
    developer.log("Error is $error", name: "getFiveDayWeatherForecastApi");
    throw Exception("Access to CMS: $error");
    // rethrow;
  }
  // developer.log(JsonMapper.serialize(results), name: "getFiveDayWeatherForecastApi");
  return results;
}
