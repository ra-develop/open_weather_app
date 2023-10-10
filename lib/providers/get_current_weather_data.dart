import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_app/models/data/CurrentWeatherData.dart';

import '../../services/classes/authentication.dart';
import '../use_cases/get_current_weather_data_api.dart';

/// Get CurrentWeatherData Arguments
///
/// @param double? [latitude]
///
/// @param double? [longitude]
///

@jsonSerializable
class GetCurrentWeatherDataArgs extends Equatable {
  GetCurrentWeatherDataArgs({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  @override
  List<Object?> get props => [latitude, longitude];
}

final getCurrentWeatherDataProvider =
FutureProvider.autoDispose
    .family<CurrentWeatherData, GetCurrentWeatherDataArgs>(
        (ref, getCurrentWeatherDataArgs) async {
  final auth = ref.read(authenticationServiceProvider);
  return await getCurrentWeatherDataApi(auth,
      getCurrentWeatherDataArgs: getCurrentWeatherDataArgs);
});
