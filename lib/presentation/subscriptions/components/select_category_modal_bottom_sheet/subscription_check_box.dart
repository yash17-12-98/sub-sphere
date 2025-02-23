import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/select_subscription_category_provider.dart';
import 'package:sub_sphere/presentation/widgets/app_select_check_box.dart';

class SubscriptionCheckbox extends StatelessWidget {
  final Subscription subscription;
  final VoidCallback onChanged;

  const SubscriptionCheckbox({
    required this.subscription,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectSubscriptionCategoryProvider>(
      builder: (context, provider, _) {
        return AppSelectCheckBox(
          value: provider.isSubscriptionSelectedForCategory(subscription),
          onChanged: (_) => onChanged(),
        );
      },
    );
  }
}