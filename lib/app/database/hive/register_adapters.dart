import 'package:hive/hive.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';

Future<void> registerAdapters() async {
  ///TypeId 1
  Hive.registerAdapter(SubscriptionAdapter());
}
