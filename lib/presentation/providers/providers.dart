import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sub_sphere/app/di.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/select_subscription_category_provider.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/subscription_provider.dart';
import 'package:sub_sphere/presentation/welcome/get_started_provider.dart';

/// List of providers used for state management across the application.
/// Each provider is registered using `ChangeNotifierProvider` to enable
/// reactive UI updates when data changes.
List<SingleChildWidget> providerList = [
  /// Provides `GetStartedProvider` to manage state related to the "Get Started" screen.
  ChangeNotifierProvider<GetStartedProvider>(
      create: (context) => GetStartedProvider()),

  /// Provides `SubscriptionProvider` to handle subscription-related logic.
  /// Uses dependency injection (`getItInstance.get()`) to retrieve `subscriptionBox`.
  ChangeNotifierProvider<SubscriptionProvider>(
      create: (context) =>
          SubscriptionProvider(subscriptionBox: getItInstance.get())),

  /// Provides `SelectSubscriptionCategoryProvider` to manage subscription category selection.
  ChangeNotifierProvider<SelectSubscriptionCategoryProvider>(
      create: (context) => SelectSubscriptionCategoryProvider()),
];
