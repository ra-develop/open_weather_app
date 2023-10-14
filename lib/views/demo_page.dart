import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_weather_app/widgets/waiting_view.dart';

import '../models/data/CurrentWeatherData.dart';
import '../providers/get_current_weather_data.dart';
import '../services/core/app_routes.dart';
import '../services/utils/location_helpers.dart';
import '../widgets/sized_spaces.dart';

class DemoPage extends ConsumerStatefulWidget {
  const DemoPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  ConsumerState<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends ConsumerState<DemoPage> {
  int _counter = 0;
  final GetCurrentWeatherDataArgs _getCurrentWeatherDataArgs =
      const GetCurrentWeatherDataArgs();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    // _placesFilteringArgs = widget.placesFilterArgs ??
    //     PlacesFilterArgs(mode: PlacesFilterMode.upcoming);
    ref.read(positionProvider);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<Position> currentPosition = ref.watch(positionProvider);

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            currentPosition.when(
              loading: () => const Expanded(child: WaitingView()),
              error: (error, stack) => Expanded(
                  child: WaitingView(
                message: "Error: ${error.toString()}",
                duration: const Duration(seconds: 1),
                color: Colors.red,
                infoIcon: const WarningSign(
                  color: Colors.red,
                ),
              )),
              data: (currentPosition) {
                // setState(() {
                // _getCurrentWeatherDataArgs.latitude =
                //     currentPosition.latitude;
                // _getCurrentWeatherDataArgs.longitude =
                //     currentPosition.longitude;
                final getCurrentWeatherDataArgs = GetCurrentWeatherDataArgs(
                    latitude: currentPosition.latitude,
                    longitude: currentPosition.longitude);
                // });

                AsyncValue<CurrentWeatherData> currentWeatherData = ref.watch(
                    getCurrentWeatherDataProvider(getCurrentWeatherDataArgs));
                return Column(
                  children: [
                    const Text("Your geo position is:"),
                    Text("latitude: ${_getCurrentWeatherDataArgs.latitude}"),
                    Text("longitude: ${_getCurrentWeatherDataArgs.longitude}"),
                    const VSpacer(20),
                    currentWeatherData.when(
                        data: (currentWeatherData) {
                          return Column(
                            children: [
                              const Text("Current weather is:"),
                              Text("City: ${currentWeatherData.name}"),
                              Text("Temp: ${currentWeatherData.main?.temp}"),
                            ],
                          );
                        },
                        error: (error, stack) => WaitingView(
                              message: "Error: ${error.toString()}",
                              duration: const Duration(seconds: 1),
                              color: Colors.red,
                              infoIcon: const WarningSign(
                                color: Colors.red,
                              ),
                            ),
                        loading: () => const CircularProgressIndicator()),
                  ],
                );
              },
            ),
            const VSpacer(20),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const VSpacer(20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  developer.log("Test waiting view pushed",
                      name: "WaitingView");
                  Navigator.pushNamed(context, AppRoutes.simpleWait,
                      arguments: "Test waiting view");
                });
              },
              child: const Text(
                "Test waiting view",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  developer.log("Test waiting view pushed",
                      name: "WaitingView");
                  final arguments = WaitingViewArgs(
                    message: "Test waiting view with Duration",
                    duration: const Duration(seconds: 5),
                  );
                  Navigator.pushNamed(context, AppRoutes.waitingView,
                      arguments: arguments);
                });
              },
              child: const Text(
                "Test waiting view with Duration",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  developer.log("Test waiting view pushed",
                      name: "WaitingView");
                  final arguments = WaitingViewArgs(
                    message: """
Test waiting view as warning message
       Test waiting view as warning message
                Test waiting view as warning message
                                Test waiting view as warning message
Test waiting view as warning message
    Test waiting view as warning message
      Test waiting view as warning message
Test waiting view as warning message. Test waiting view as warning message. Test waiting view as warning message. Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
Test waiting view as warning message
                 """,
                    duration: const Duration(seconds: 1),
                    color: Colors.red,
                    infoIcon: const WarningSign(
                      color: Colors.red,
                    ),
                  );
                  Navigator.pushNamed(context, AppRoutes.waitingView,
                      arguments: arguments);
                });
              },
              child: const Text(
                "Test waiting view as warning message",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

