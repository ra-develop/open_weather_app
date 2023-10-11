import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_app/models/enumerators/unit_measure.dart';

import '../models/data/CurrentWeatherData.dart';
import '../providers/get_current_weather_data.dart';
import '../services/core/config.dart';
import '../services/core/material_color_generator.dart';
import '../services/utils/common_image_provider.dart';
import '../services/utils/location_helpers.dart';
import '../widgets/waiting_view.dart';

class AppHomePage extends HookConsumerWidget {
  const AppHomePage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getCurrentWeatherDataArgs = useState(GetCurrentWeatherDataArgs());

    final AsyncValue<Position> currentPosition = ref.watch(positionProvider);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: currentPosition.when(
          loading: () => const WaitingView(
            message: "Geo position determination",
          ),
          error: (error, stack) => WaitingView(
            message: "Error: ${error.toString()}",
            duration: const Duration(seconds: 1),
            infoIcon: const Icon(
              Icons.error_outline,
              size: 48,
            ),
          ),
          data: (currentPosition) {
            getCurrentWeatherDataArgs.value = GetCurrentWeatherDataArgs(
                latitude: currentPosition.latitude,
                longitude: currentPosition.longitude);

            final AsyncValue<CurrentWeatherData> getCurrentWeatherData =
                ref.watch(getCurrentWeatherDataProvider(
                    getCurrentWeatherDataArgs.value));

            return getCurrentWeatherData.when(
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
                  infoIcon: const Icon(
                    Icons.error_outline,
                    size: 48,
                  ),
                ),
              ),
              data: (currentWeatherData) {
                var date = DateTime.fromMillisecondsSinceEpoch(
                    (currentWeatherData.dt?.toInt() ??
                            DateTime.now().millisecond) *
                        1000);

                return RefreshIndicator(
                  onRefresh: () async {
                    final position = await ref.refresh(positionProvider.future);

                    getCurrentWeatherDataArgs.value = GetCurrentWeatherDataArgs(
                        latitude: position.latitude,
                        longitude: position.longitude);

                    return await ref.refresh(getCurrentWeatherDataProvider(
                            getCurrentWeatherDataArgs.value)
                        .future);
                  },
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWeekDayText(date),
                        _buildPlaceText(currentWeatherData),
                        _buildWeatherImage(context, currentWeatherData),
                        _buildTempText(currentWeatherData),
                        _buildHumidityText(currentWeatherData),
                        _buildPressureText(currentWeatherData),
                        _buildWindSpeedText(currentWeatherData),
                        BuildForecast(currentPosition: currentPosition)
                      ],
                    ),
                  )),
                );
              },
            );
          },
        ));
  }

  Widget _buildWeatherImage(
      BuildContext context, CurrentWeatherData currentWeatherData) {
    final imageSize = MediaQuery.of(context).size.width / 1.5;
    return Center(
      child: Image(
          width: imageSize,
          height: imageSize,
          image: commonImageProvider(
              "${Config.getImageBaseUrl}${currentWeatherData.weather?.first.icon}@2x.png"),
          fit: BoxFit.cover),
    );
  }

  Widget _buildPlaceText(CurrentWeatherData currentWeatherData) {
    return Text(
      "${currentWeatherData.name}",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Palette.primary),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildHumidityText(CurrentWeatherData currentWeatherData) {
    return Text(
      "Humidity: ${currentWeatherData.main?.humidity}%",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Palette.primary),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildPressureText(CurrentWeatherData currentWeatherData) {
    return Text(
      "Pressure: ${currentWeatherData.main?.pressure} hPa",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Palette.primary),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildWindSpeedText(CurrentWeatherData currentWeatherData) {
    return Text(
      "Wind: ${currentWeatherData.wind?.speed?.toInt()} ${Config.units.speed}",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Palette.primary),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildWeekDayText(DateTime date) {
    return Center(
      child: Text(
        DateFormat('EEEE').format(date),
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Palette.primary),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTempText(CurrentWeatherData currentWeatherData) {
    return Center(
      child: Text(
        "${currentWeatherData.main?.temp?.toInt().toString() ?? "--"} ${Config.units.unitSign}",
        style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Palette.primary),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class BuildForecast extends StatelessWidget {
  const BuildForecast({
    super.key,
    required this.currentPosition,
  });

  final Position currentPosition;

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C', 'D', 'E'];
    final List<int> colorCodes = <int>[600, 500, 400, 300, 100];
    return SizedBox(
      height: 170,
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          scrollDirection: Axis.horizontal,
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                developer.log("Item selected");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 130,
                  width: 130,
                  color: Colors.amber[colorCodes[index]],
                  child: Center(
                      child: Column(
                    children: [
                      Text('Entry ${entries[index]}'),
                      Text(currentPosition.toString())
                    ],
                  )),
                ),
              ),
            );
          }),
    );
  }
}
