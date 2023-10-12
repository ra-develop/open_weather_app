import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_weather_app/models/enumerators/unit_measure.dart';
import 'package:open_weather_app/views/home_page/build_home_page.dart';

final selectedUnitProvider = StateProvider((ref) => UnitMeasure.metric);

class AppHomePage extends HookConsumerWidget {
  const AppHomePage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(selectedUnitProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(title)),
      ),
      body: const BuildHomePage(),
    );
  }
}
