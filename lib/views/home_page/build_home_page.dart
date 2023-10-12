import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_app/models/enumerators/unit_measure.dart';

import '../../models/data/CurrentWeatherData.dart';
import '../../models/data/FiveDayWeatherForecast.dart';
import '../../providers/get_five_day_weather_forecast.dart';
import '../../services/core/config.dart';
import '../../services/core/material_color_generator.dart';
import '../../services/utils/location_helpers.dart';
import '../../widgets/sized_spaces.dart';
import '../../widgets/unit_selection.dart';
import '../../widgets/waiting_view.dart';
import '../build_weather_image.dart';
import 'build_forecast.dart';

final selectedDayProvider = StateProvider((ref) => 0);

class BuildHomePage extends HookConsumerWidget {
  const BuildHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getFiveDayWeatherForecastArgs =
        useState(const GetFiveDayWeatherForecastArgs());

    final AsyncValue<Position> currentPosition = ref.watch(positionProvider);

    return currentPosition.when(
      loading: () => const WaitingView(
        message: "Geo position determination",
      ),
      error: (error, stack) => WaitingView(
        message: "Error: ${error.toString()}",
        duration: const Duration(seconds: 1),
        color: Colors.red,
        infoIcon: const WarningSign(
          color: Colors.red,
        ),
        actions: ElevatedButton(
          onPressed: () =>
              _refreshWeatherData(ref, getFiveDayWeatherForecastArgs),
          child: const Text("OK"),
        ),
      ),
      data: (currentPosition) {
        getFiveDayWeatherForecastArgs.value = GetFiveDayWeatherForecastArgs(
            latitude: currentPosition.latitude,
            longitude: currentPosition.longitude);

        final fiveDayWeatherForecast = ref.watch(
            getFiveDayWeatherForecastProvider(
                getFiveDayWeatherForecastArgs.value));

        return fiveDayWeatherForecast.when(
          loading: () => SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const WaitingView(
              message: "Fetching weather data",
            ),
          ),
          error: (error, stack) => SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WaitingView(
              message: "Error: ${error.toString()}",
              duration: const Duration(seconds: 1),
              color: Colors.red,
              infoIcon: const WarningSign(
                color: Colors.red,
              ),
              actions: ElevatedButton(
                onPressed: () =>
                    _refreshWeatherData(ref, getFiveDayWeatherForecastArgs),
                child: const Text("Replay"),
              ),
            ),
          ),
          data: (weatherData) {
            return Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final currentWeatherData =
                    weatherData.list?[ref.watch(selectedDayProvider)];
                return RefreshIndicator(
                  onRefresh: () =>
                      _refreshWeatherData(ref, getFiveDayWeatherForecastArgs),
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildWeekDayText(currentWeatherData),
                              const VSpacer(10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildPlaceText(weatherData),
                                  _buildUnitsSelection(),
                                ],
                              ),
                              BuildWeatherImage(
                                  context: context,
                                  currentWeatherData: currentWeatherData,
                                  imageSize:
                                      MediaQuery.of(context).size.width / 1.5),
                              _buildTempText(currentWeatherData),
                              _buildHumidityText(currentWeatherData),
                              _buildPressureText(currentWeatherData),
                              _buildWindSpeedText(currentWeatherData),
                              BuildForecast(weatherData: weatherData)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  _refreshWeatherData(
      WidgetRef ref,
      ValueNotifier<GetFiveDayWeatherForecastArgs>
          getFiveDayWeatherForecastArgs) async {
    final position = await ref.refresh(positionProvider.future);

    getFiveDayWeatherForecastArgs.value = GetFiveDayWeatherForecastArgs(
        latitude: position.latitude, longitude: position.longitude);

    return await ref.refresh(
        getFiveDayWeatherForecastProvider(getFiveDayWeatherForecastArgs.value)
            .future);
  }

  Widget _buildUnitsSelection() {
    return const UnitSelection();
  }

  Widget _buildHumidityText(CurrentWeatherData? currentWeatherData) {
    return Text(
      "Humidity: ${currentWeatherData?.main?.humidity}%",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          // fontStyle: FontStyle.italic,
          color: McgPalette.primary),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildPressureText(CurrentWeatherData? currentWeatherData) {
    return Text(
      "Pressure: ${currentWeatherData?.main?.pressure} hPa",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          // fontStyle: FontStyle.italic,
          color: McgPalette.primary),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildWindSpeedText(CurrentWeatherData? currentWeatherData) {
    return Text(
      "Wind: ${currentWeatherData?.wind?.speed?.toInt()} ${Config.units.speed}",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          // fontStyle: FontStyle.italic,
          color: McgPalette.primary),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildWeekDayText(CurrentWeatherData? currentWeatherData) {
    final date = DateTime.fromMillisecondsSinceEpoch(
        (currentWeatherData?.dt?.toInt() ?? DateTime.now().millisecond) * 1000);
    return Center(
      child: Text(
        DateFormat('EEEE').format(date),
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            // fontStyle: FontStyle.italic,
            color: McgPalette.primary),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTempText(CurrentWeatherData? currentWeatherData) {
    return Center(
      child: Text(
        "${currentWeatherData?.main?.temp?.toInt().toString() ?? "--"} ${Config.units.unitSign}",
        style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            // fontStyle: FontStyle.italic,
            color: McgPalette.primary),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPlaceText(FiveDayWeatherForecast? weatherData) {
    return Text(
      "${weatherData?.city?.name}",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          // fontStyle: FontStyle.italic,
          color: McgPalette.primary),
      textAlign: TextAlign.left,
    );
  }
}
