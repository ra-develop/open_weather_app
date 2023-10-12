import 'package:flutter/material.dart';

import '../../views/demo_page.dart';
import '../../views/home_page/app_home_page.dart';
import '../../widgets/waiting_view.dart';

class AppRoutes {
  static const demoPage = '/demoPage';
  static const appHome = '/appHomepage';
  static const simpleWait = "/simpleWait";
  static const waitingView = "/waitingView";


  String getInitialRoute() => AppRoutes.appHome;

  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
    /*
      // Example to use AppRoutes:
      case AppRoutes.tutorial:
        return _buildRoute(const Tutorial(), settings: settings);

      case AppRoutes.chat:
        final receiverId = settings.arguments as int?;
        return _buildRoute(
            ChatMessagingPage(
              receiverId: receiverId,
            ),
            settings: settings);

      case AppRoutes.selectDateTime:
        final args = settings.arguments;
        return args == null
            ? throw Exception('Error: required Member Detail Route Arguments ')
            : _buildRoute(
                SelectDateTime(arguments: args as SelectDateTimeRouteArgs),
                settings: settings);

      */

      case AppRoutes.simpleWait:
        final message = settings.arguments as String?;
        return _buildRoute(
            WaitingView(
              message: message,
            ),
            settings: settings);

      case AppRoutes.waitingView:
        final args = settings.arguments as WaitingViewArgs;
        return _buildRoute(
            WaitingView(
              message: args.message,
              duration: args.duration,
              infoIcon: args.infoIcon,
              linearMode: args.linearMode,
              color: args.color,
              actions: args.actions,
            ),
            settings: settings);

      case AppRoutes.demoPage:
        return _buildRoute(const DemoPage(title: 'Flutter Demo Page'),
            settings: settings);

      case AppRoutes.appHome:
        return _buildRoute(const AppHomePage(title: 'Flutter OpenWeather Demo'),
            settings: settings);

      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(Widget child, {RouteSettings? settings}) =>
      MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => child,
      );
}
