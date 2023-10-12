import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/classes/authentication.dart';
import '../models/data/FiveDayWeatherForecast.dart';
import '../use_cases/get_five_day_weather_forecast_api.dart';

/// Get CurrentWeatherData Arguments
///
/// @param double? [latitude]
///
/// @param double? [longitude]
///

@jsonSerializable
class GetFiveDayWeatherForecastArgs extends Equatable {
  const GetFiveDayWeatherForecastArgs({
    this.latitude,
    this.longitude,
  });

  final double? latitude;
  final double? longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}

final getFiveDayWeatherForecastProvider = FutureProvider.autoDispose
    .family<FiveDayWeatherForecast, GetFiveDayWeatherForecastArgs>(
        (ref, getFiveDayWeatherForecastArgs) async {
  final auth = ref.read(authenticationServiceProvider);
  return await getFiveDayWeatherForecastApi(auth,
      getFiveDayWeatherForecastArgs: getFiveDayWeatherForecastArgs);
});
