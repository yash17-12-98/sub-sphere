import 'package:sub_sphere/presentation/base/base_provider.dart';

import '../../../models/subscription/subscription.dart';

/// **SelectSubscriptionCategoryProvider**

/// - Manages the selection of subscriptions for category assignment.
/// - Uses a `Set` to efficiently track selected subscriptions.
class SelectSubscriptionCategoryProvider extends BaseProvider {
  /// **Stores the currently selected subscriptions for category assignment.**
  final Set<Subscription> selectedSubscriptionsForCategory = {};

  /// **Checks if a subscription is selected.**
  /// - Returns `true` if the subscription is in the selected set.
  bool isSubscriptionSelectedForCategory(Subscription subscription) {
    return selectedSubscriptionsForCategory.contains(subscription);
  }

  /// **Toggles the selection state of a subscription.**
  /// - Adds the subscription if it's not selected.
  /// - Removes it if it's already selected.
  void toggleSubscriptionSelection(Subscription subscription) {
    if (!selectedSubscriptionsForCategory.remove(subscription)) {
      selectedSubscriptionsForCategory.add(subscription);
    }
    notifyListeners();
  }

  /// **Clears all selected subscriptions.**
  /// - Useful when dismissing a selection modal or resetting choices.
  void clearSelectedSubscriptions() {
    if (selectedSubscriptionsForCategory.isNotEmpty) {
      selectedSubscriptionsForCategory.clear();
      notifyListeners();
    }
  }

  /// **Retrieves the list of currently selected subscriptions.**
  List<Subscription> get selectedSubscriptions =>
      selectedSubscriptionsForCategory.toList();
}
