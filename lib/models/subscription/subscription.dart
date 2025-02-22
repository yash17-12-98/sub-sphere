import 'package:hive/hive.dart';

part 'subscription.g.dart';

@HiveType(typeId: 0)
class Subscription extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double price;

  @HiveField(2)
  final String billingCycle;

  @HiveField(3)
  final String iconPath;

  @HiveField(4)
  final String category;

  Subscription({
    required this.name,
    required this.price,
    required this.billingCycle,
    required this.iconPath,
    required this.category,
  });
}