import 'package:hive/hive.dart';
import 'package:sub_sphere/app/database/hive/box_names.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';

Future<void> openBoxes() async {
  await Hive.openBox<Subscription>(subscriptionBox);
}
