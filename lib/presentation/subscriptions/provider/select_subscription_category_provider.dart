import 'package:sub_sphere/presentation/base/base.dart';

import '../../../models/subscription/subscription.dart';

class SelectSubscriptionCategoryProvider extends BaseProvider {
  final Set<Subscription> selectedSubscriptionsForCategory = {};

  bool isSubscriptionSelectedForCategory(Subscription subscription) {
    return selectedSubscriptionsForCategory.contains(subscription);
  }

  void toggleSubscriptionSelection(Subscription subscription) {
    if (selectedSubscriptionsForCategory.contains(subscription)) {
      selectedSubscriptionsForCategory.remove(subscription);
    } else {
      selectedSubscriptionsForCategory.add(subscription);
    }
    notifyListeners();
  }

  void clearSelectedSubscriptions() {
    selectedSubscriptionsForCategory.clear();
    notifyListeners();
  }

  List<Subscription> get selectedSubscriptions =>
      selectedSubscriptionsForCategory.toList();
}