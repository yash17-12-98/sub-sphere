import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sub_sphere/app/di.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/subscription_provider.dart';

List<SingleChildWidget> providerList = [
  ChangeNotifierProvider<SubscriptionProvider>(
      create: (context) =>
          SubscriptionProvider(subscriptionBox: getItInstance.get())),

  ChangeNotifierProvider<SelectSubscriptionCategoryProvider>(
      create: (context) =>
          SelectSubscriptionCategoryProvider()),
];
