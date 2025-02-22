import 'package:hive/hive.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';
import 'package:sub_sphere/presentation/base/base.dart';

class SubscriptionProvider extends BaseProvider {
  final Box<Subscription> subscriptionBox;

  SubscriptionProvider({required this.subscriptionBox});
}
