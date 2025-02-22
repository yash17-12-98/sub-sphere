import 'package:hive/hive.dart';

part 'subscription.g.dart';

@HiveType(typeId: 0)
class Subscription extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String category;
  @HiveField(2)
  String image;
  @HiveField(3)
  double amountPerMonth;

  Subscription(this.name, this.category, this.image, this.amountPerMonth);
}
