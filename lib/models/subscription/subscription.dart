import 'package:hive/hive.dart';

part 'subscription.g.dart';

/// A Model class for storing subscription details using Hive local database.
@HiveType(typeId: 0)
class Subscription extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final dynamic price;

  @HiveField(2)
  final String billingCycle;

  @HiveField(3)
  final String iconPath;

  @HiveField(4)
  final List<String> category;

  Subscription({
    required this.name,
    required this.price,
    required this.billingCycle,
    required this.iconPath,
    required this.category,
  });
}
