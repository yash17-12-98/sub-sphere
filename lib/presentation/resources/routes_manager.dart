import 'package:flutter/material.dart';
import 'package:sub_sphere/presentation/welcome/get_started_view.dart';
import '../subscriptions/subscription_view.dart';
import 'resources.dart';

/// This class defines the named routes used in the application.
/// Keeping route names centralized helps in managing navigation easily.
class Routes {
  static const String getStartedRoute = "/"; // Initial screen route
  static const String mySubRoute = "/mySub"; // Route for the subscriptions view
}

/// A helper class responsible for generating routes based on the given settings.
/// This ensures centralized navigation management and makes route handling more scalable.
class RouteGenerator {
  /// Returns a [Route] object based on the provided route settings.
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.getStartedRoute:
        return MaterialPageRoute(builder: (_) => GetStartedView()); // Load GetStartedView
      case Routes.mySubRoute:
        return MaterialPageRoute(builder: (_) => SubscriptionsView()); // Load SubscriptionsView
      default:
        return unDefinedRoute(); // Handle undefined routes
    }
  }

  /// Returns a default error route when an undefined route is accessed.
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
