import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_app/models/data/CurrentWeatherData.dart';

import '../../services/classes/authentication.dart';
import '../use_cases/get_current_weather_data_api.dart';

/// Get CurrentWeatherData Arguments
///
/// @param double? [latitude]
///
/// @param double? [longitude]
class GetCurrentWeatherDataArgs {
  GetCurrentWeatherDataArgs({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;
}

final getCurrentWeatherDataProvider =
    FutureProvider.family<CurrentWeatherData, GetCurrentWeatherDataArgs>(
        (ref, getCurrentWeatherDataArgs) async {
  final auth = ref.read(authenticationServiceProvider);
  return await getCurrentWeatherDataApi(auth,
      getCurrentWeatherDataArgs: getCurrentWeatherDataArgs);
});
