import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/utils/location_helpers.dart';

class AppHomePage extends ConsumerStatefulWidget {
  const AppHomePage({required this.title, super.key});

  final String title;

  @override
  AppHomePageState createState() => AppHomePageState();
}

class AppHomePageState extends ConsumerState<AppHomePage> {
  @override
  void initState() {
    ref.read(positionProvider);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(AppHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
    );
  }
}
