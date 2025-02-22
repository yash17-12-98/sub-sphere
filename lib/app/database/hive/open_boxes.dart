import 'package:hive/hive.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';
import 'box_key.dart';

Future<void> openBoxes() async {
  await Hive.openBox<Subscription>(subscriptionKey);
}
