import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_weather_app/services/core/config.dart';

import '../models/enumerators/unit_measure.dart';
import '../providers/get_five_day_weather_forecast.dart';
import '../services/utils/location_helpers.dart';
import '../views/home_page/app_home_page.dart';

class UnitSelection extends HookConsumerWidget {
  const UnitSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitMeasure = useState(Config.units);
    return SegmentedButton<UnitMeasure>(
      segments: <ButtonSegment<UnitMeasure>>[
        ButtonSegment<UnitMeasure>(
          value: UnitMeasure.metric,
          label: Text(UnitMeasure.metric.unitSign),
        ),
        ButtonSegment<UnitMeasure>(
          value: UnitMeasure.imperial,
          label: Text(UnitMeasure.imperial.unitSign),
        ),
      ],
      selected: <UnitMeasure>{unitMeasure.value},
      onSelectionChanged: (Set<UnitMeasure> newSelection) async {
        unitMeasure.value = newSelection.first;
        developer.log(unitMeasure.value.capitalName);
        Config.units = unitMeasure.value;
        ref.read(selectedUnitProvider.notifier).state = unitMeasure.value;
        final position = await ref.refresh(positionProvider.future);

        final getFiveDayWeatherForecastArgs = GetFiveDayWeatherForecastArgs(
            latitude: position.latitude, longitude: position.longitude);

        return await ref.refresh(
            getFiveDayWeatherForecastProvider(getFiveDayWeatherForecastArgs)
                .future);
      },
    );
  }
}
