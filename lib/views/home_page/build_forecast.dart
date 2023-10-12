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
    final List<CurrentWeatherData> entries1 = [];
    List<CurrentWeatherData> entriesDay = [];
    List<CurrentWeatherData> entriesNight = [];

    List<List<CurrentWeatherData>> entries = [];

    if (weatherData.list != null) {
      if (weatherData.list!.isNotEmpty) {
        entriesDay = weatherData.list!
            .where((element) => element.sys?.pod == "d")
            .toList();
        entriesNight = weatherData.list!
            .where((element) => element.sys?.pod == "n")
            .toList();

        // entriesDay.add(weatherData.list!.first);
        // weatherData.list!.asMap().forEach((index, value) {
        //   if (index != 0) {
        //     if (!entriesDay.any((element) => element.dtTxt?.substring(0, 9) == value.dtTxt?.substring(0,9))) {
        //       entriesDay.add(value);
        //     }
        //   }
        //
        //
        //
        //   if (index % 8 == 0) {
        //     entries1.add(value);
        //   }
        // });

        weatherData.list!.asMap().forEach((index, value) {
          if (index % 8 == 0) {
            entries1.add(value);
          }
        });
      }
    }

    return SizedBox(
      height: 170,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          scrollDirection: Axis.horizontal,
          itemCount: entries1.length,
          itemBuilder: (BuildContext context, int index) {
            final item = entries1[index];
            final itemDate = DateTime.fromMillisecondsSinceEpoch(
                (item.dt?.toInt() ?? DateTime.now().millisecond) * 1000);
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
                              currentWeatherData: item,
                              imageSize: 70.0),
                          Text(
                            "${item.main?.tempMin?.toInt().toString() ?? "--"} / ${item.main?.tempMax?.toInt().toString() ?? "--"} ${Config.units.unitSign}",
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
}
