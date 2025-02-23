import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_sphere/presentation/providers/providers.dart';
import '../presentation/resources/resources.dart';

/// The main application widget that sets up providers and configures the app's routing and theme.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerList,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.getStartedRoute,
          theme: getApplicationTheme()),
    );
  }
}
