import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_app/models/enumerators/unit_measure.dart';
import 'package:open_weather_app/views/build_weather_image.dart';

import '../../models/data/CurrentWeatherData.dart';
import '../../models/data/FiveDayWeatherForecast.dart';
import '../../services/core/config.dart';
import '../../services/core/material_color_generator.dart';
import 'build_home_page.dart';

class BuildForecast extends HookConsumerWidget {
  const BuildForecast({
    super.key,
    required this.weatherData,
  });

  final FiveDayWeatherForecast weatherData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<CurrentWeatherData> entriesData = [];
    final List<List<CurrentWeatherData>> entriesPerDay = [];

    if (weatherData.list != null) {
      if (weatherData.list!.isNotEmpty) {
        entriesData.add(weatherData.list!.first);
        weatherData.list!.asMap().forEach((index, value) {
          if (index != 0) {
            final previousDate = entriesData.last.dtTxt ?? "";
            final dateString = value.dtTxt?.substring(0, 10);
            if (!previousDate.contains(dateString as Pattern)) {
              _sortEntries(entriesData);
              entriesPerDay.add(entriesData.toList());
              entriesData.clear();
            }
            entriesData.add(value);
          }
        });
        _sortEntries(entriesData);
        entriesPerDay.add(entriesData.toList());
      }
    }

    return SizedBox(
      height: 170,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          scrollDirection: Axis.horizontal,
          itemCount: entriesPerDay.length,
          itemBuilder: (BuildContext context, int index) {
            final item = entriesPerDay[index];
            final itemDate = DateTime.fromMillisecondsSinceEpoch(
                (item.first.dt?.toInt() ?? DateTime.now().millisecond) * 1000);
            return InkWell(
              onTap: () {
                developer.log("Item selected");
                ref.read(selectedDayProvider.notifier).state = index * 8;
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 130,
                    width: 150,
                    color: McgPalette.colorPalette[50], //Colors.amber[100],
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Text(
                            DateFormat('EEE').format(itemDate),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                // fontStyle: FontStyle.italic,
                                color: McgPalette.primary),
                            textAlign: TextAlign.center,
                          ),
                          BuildWeatherImage(
                              context: context,
                              currentWeatherData: item.first,
                              imageSize: 70.0),
                          Text(
                            "${item.first.main?.temp?.round().toString() ?? "--"} ${Config.units.unitSign} / ${item.last.main?.temp?.round().toString() ?? "--"} ${Config.units.unitSign}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                // fontStyle: FontStyle.italic,
                                color: McgPalette.primary),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void _sortEntries(List<CurrentWeatherData> entriesData) {
    entriesData.sort((a, b) {
      final valueA = a.main?.temp;
      final valueB = b.main?.temp;
      if (valueA != null && valueB != null) {
        return valueA.compareTo(valueB);
      } else {
        return 0;
      }
    });
  }
}
