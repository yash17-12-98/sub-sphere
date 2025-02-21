import 'package:flutter/material.dart';
import 'package:sub_sphere/presentation/welcome/get_started_view.dart';
import 'resources.dart';

class Routes {
  static const String getStartedRoute = "/";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.getStartedRoute:
        return MaterialPageRoute(builder: (_) => GetStartedView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
