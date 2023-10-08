import 'package:flutter/material.dart';

// import 'package:winker/models/data/person/Person.dart';
// import 'package:winker/services/classes/authentication.dart';
// import 'package:winker/services/widgets/waiting_view.dart';
// import 'package:winker/views/calendar/select_date_time.dart';
// import 'package:winker/views/dating/add_dating.dart';
// import 'package:winker/views/home/filter_page.dart';
// import 'package:winker/views/person/person_edit_page.dart';
// import 'package:winker/views/datespot/datespot_detail_view.dart';
// import 'package:winker/views/person/settings_page.dart';

// import '../models/data/places/Place.dart';
// import '../views/chat/chat_messaging_page.dart';
// import '../views/home/app_main_page.dart';
// import '../views/notification/notification_page.dart';
// import '../views/on_boarding/tutorial.dart';
// import '../views/person/person_detial_page.dart';
// import '../views/login/check_login_screen.dart';
// import '../views/on_boarding/on_boarding.dart';
import '../../views/app_home_page.dart';
import '../../views/demo_page.dart';
import '../../widgets/waiting_view.dart';

class AppRoutes {
  static const demoPage = '/demoPage';
  static const appHome = '/appHomepage';
  static const simpleWait = "/simpleWait";
  static const waitingView = "/waitingView";

  // static const onBoarding = '/onBoarding';
  // static const login = '/login';
  // static const personDetail = "/personDetail";
  // static const datespotDetail = "/placeDetail";
  // static const filter = "/filter";
  // static const settings = "/settings";
  // static const personEdit = "/personEdit";
  // static const chat = "/chat";
  // static const notification = "/notification";
  // static const addDating = "/addDating";
  // static const selectDateTime = "/selectDateTime";
  // static const tutorial = '/Tutorial';

  String getInitialRoute() => AppRoutes.appHome;

  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
    /*
      case AppRoutes.tutorial:
        return _buildRoute(const Tutorial(), settings: settings);
      case AppRoutes.login:
        return _buildRoute(const LoginScreen(), settings: settings);
      case AppRoutes.appMain:
        return _buildRoute(const AppMainPage(), settings: settings);
      case AppRoutes.filter:
        return _buildRoute(const FilterPage(), settings: settings);
      case AppRoutes.chat:
        final receiverId = settings.arguments as int?;
        return _buildRoute(
            ChatMessagingPage(
              receiverId: receiverId,
            ),
            settings: settings);
      case AppRoutes.notification:
        return _buildRoute(const NotificationPage(), settings: settings);
      case AppRoutes.addDating:
        final place = settings.arguments as Place?;
        return _buildRoute(AddDating(place: place), settings: settings);
      case AppRoutes.selectDateTime:
        final args = settings.arguments;
        return args == null
            ? throw Exception('Error: required Member Detail Route Arguments ')
            : _buildRoute(
                SelectDateTime(arguments: args as SelectDateTimeRouteArgs),
                settings: settings);
      case AppRoutes.settings:
        return _buildRoute(const SettingsPage(), settings: settings);
      case AppRoutes.personEdit:
        return _buildRoute(const PersonEditPage(), settings: settings);
      case AppRoutes.personDetail:
        final args = settings.arguments;
        return args == null
            ? throw Exception('Error: required Member Detail Route Arguments ')
            : _buildRoute(
            PersonDetailPage(arguments: args as PersonDetailRouteArgs),
            settings: settings);
      case AppRoutes.datespotDetail:
        final args = settings.arguments;
        return args == null
            ? throw Exception('Error: required Datespot Detail Route Arguments')
            : _buildRoute(
            DatespotDetailView(arguments: args as DatespotDetailRouteArgs),
            settings: settings);
      case AppRoutes.onBoarding:
        return _buildRoute(const OnBoarding(title: "Signed In "),
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
            ),
            settings: settings);

      case AppRoutes.demoPage:
        return _buildRoute(const DemoPage(title: 'Flutter Demo Page'),
            settings: settings);

      case AppRoutes.appHome:
        return _buildRoute(const AppHomePage(title: 'Flutter OpenWeather'),
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
