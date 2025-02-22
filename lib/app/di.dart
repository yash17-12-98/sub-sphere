import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sub_sphere/app/database/hive/box_names.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';

final getItInstance = GetIt.instance;

Future<void> initBoxDI() async {
  getItInstance.registerSingleton(
    Hive.box<Subscription>(subscriptionBox),
  );
}
