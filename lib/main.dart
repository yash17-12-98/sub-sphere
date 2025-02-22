import 'package:flutter/material.dart';
import 'package:sub_sphere/app/app.dart';
import 'package:sub_sphere/app/database/hive/open_boxes.dart';
import 'package:sub_sphere/app/database/hive/register_adapters.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sub_sphere/app/di.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await registerAdapters();
  await openBoxes();
  await initBoxDI();
  runApp(const MyApp());
}
