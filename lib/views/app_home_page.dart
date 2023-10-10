import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/data/CurrentWeatherData.dart';
import '../providers/get_current_weather_data.dart';
import '../services/utils/location_helpers.dart';
import '../widgets/waiting_view.dart';

class AppHomePage extends HookConsumerWidget {
  const AppHomePage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getCurrentWeatherDataArgs = useState(GetCurrentWeatherDataArgs());

    final AsyncValue<Position> currentPosition = ref.watch(positionProvider);

    final AsyncValue<CurrentWeatherData> getCurrentWeatherData = ref
        .watch(getCurrentWeatherDataProvider(getCurrentWeatherDataArgs.value));

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
                  child: CustomScrollView(slivers: [
                    SliverFillRemaining(
                        // hasScrollBody: false,
                        child: Column(
                      children: [
                        Text(DateFormat('EEEE').format(date)),
                        Text("${currentWeatherData.name}")
                      ],
                    ))
                  ]),
                );
              },
            );
          },
        ));
  }
}
