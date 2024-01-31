import 'package:flutter/material.dart';
import 'package:repo_scout/models/repo.dart';

import '../screens/screens.dart';

class RouteArguments<T> {
  final T? item;
  final VoidCallback? callback;
  RouteArguments({this.item, this.callback});
}

class Routes {
  static const String home = "/home";
  static const String details = "/details";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        );
      case details:
        return MaterialPageRoute(
          builder: (context) {
            return DetailsScreen(
              repo: args as Repo,
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return DefaultScreen(
              path: settings.name,
            );
          },
        );
    }
  }

  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
