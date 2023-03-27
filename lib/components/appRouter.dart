import 'package:flutter/material.dart';
import '../pages/index.dart';

class AppRouter {
  static late Map<String, dynamic> pageMap;
  static var methodChannelsPage = MethodChannelsPage();
  static var httpActionsPage = HttpActionsPage();
  static var watchPage = WatchPage();

  AppRouter() {
    pageMap = {
      "/": methodChannelsPage,
      "/record": httpActionsPage,
      "/watch": watchPage
    };
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    return MaterialPageRoute(
      builder: (BuildContext context) => pageMap[settings.name],
    );
  }
}
