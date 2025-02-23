import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/select_subscription_category_provider.dart';

import '../../../widgets/widgets.dart';

/// A checkbox widget for selecting subscriptions within a category.
class SubscriptionCheckbox extends StatelessWidget {
  final Subscription subscription;
  final VoidCallback onChanged;

  /// Creates a subscription checkbox with selection handling.
  const SubscriptionCheckbox({
    required this.subscription,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectSubscriptionCategoryProvider>(
      /// Listens to provider and updates checkbox state.
      builder: (context, provider, _) {
        return AppSelectCheckBox(
          value: provider.isSubscriptionSelectedForCategory(subscription),

          /// Calls the callback when checkbox is toggled.
          onChanged: (_) => onChanged(),
        );
      },
    );
  }
}
