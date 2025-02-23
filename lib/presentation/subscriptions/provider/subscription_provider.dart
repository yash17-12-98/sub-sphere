import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sub_sphere/app/enums.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';
import 'package:sub_sphere/presentation/base/base_provider.dart';

import '../../resources/resources.dart';

/// **SubscriptionProvider**

/// Manages subscriptions using Hive for persistent storage and provides methods
/// for filtering, category management, and assigning colors.
class SubscriptionProvider extends BaseProvider {
  final Box<Subscription> subscriptionBox;

  SubscriptionProvider({required this.subscriptionBox}) {
    initializeDefaultData();
  }

  /// **Default Subscription Data**
  /// Preloaded list of subscriptions added to Hive storage if it's empty.
  static final List<Subscription> defaultSubscriptions = [
    Subscription(
      name: AppStrings.figma,
      price: 12,
      billingCycle: BillingCycle.month.name,
      iconPath: ImageAssets.figmaImage,
      category: [AppStrings.design],
    ),
    Subscription(
      name: AppStrings.hboMax,
      price: 12,
      billingCycle: BillingCycle.month.name,
      iconPath: ImageAssets.hboImage,
      category: [AppStrings.entertainment],
    ),
    Subscription(
      name: AppStrings.spotify,
      price: 12,
      billingCycle: BillingCycle.month.name,
      iconPath: ImageAssets.spotifyImage,
      category: [AppStrings.entertainment],
    ),
    Subscription(
      name: AppStrings.playStationPlus,
      price: 67.57,
      billingCycle: BillingCycle.year.name,
      iconPath: ImageAssets.playStationImage,
      category: [AppStrings.entertainment],
    ),
    Subscription(
      name: AppStrings.youtube,
      price: 8.97,
      billingCycle: BillingCycle.month.name,
      iconPath: ImageAssets.youtubeImage,
      category: [AppStrings.entertainment],
    ),
  ];

  /// **Color Palette for Subscription Tiles**
  static final List<Color> colorPalette = [
    ColorManager.red,
    ColorManager.teal,
    ColorManager.yellow,
    ColorManager.purple,
    ColorManager.green,
    ColorManager.orange,
    ColorManager.blue,
    ColorManager.pink,
  ];

  final Random random = Random();
  List<int> shuffledColorIndices = [];

  /// Index of the currently selected category in the UI.
  int categoriesSelectedIndex = 0;

  /// Retrieves the list of all subscriptions from Hive storage.
  List<Subscription> get subscriptions => subscriptionBox.values.toList();

  /// **Setter for Selected Category**
  /// Updates the selected category and notifies listeners to rebuild the UI.
  set categorySelected(int index) {
    categoriesSelectedIndex = index;
    notifyListeners();
  }

  /// **Retrieves All Categories**
  /// - Starts with 'All Subscriptions' as the default category.
  /// - Extracts unique categories from stored subscriptions.
  List<String> get categories {
    final list = [AppStrings.allSabs]; // 'All Subscriptions' category
    final categorySet = subscriptions
        .expand((subscription) => subscription.category)
        .where((category) => category.isNotEmpty)
        .toSet();

    list.addAll(categorySet);
    return list;
  }

  /// **Initialize Default Data**
  /// - If the Hive box is empty, inserts the default subscriptions.
  /// - Ensures that subscriptions are available upon first launch.
  Future<void> initializeDefaultData() async {
    if (subscriptionBox.isEmpty) {
      await subscriptionBox.addAll(defaultSubscriptions);
      notifyListeners();
    }
  }

  /// **Assigns a Random Color to a Subscription Tile**
  /// Uses a **shuffle algorithm** to ensure color variation across subscriptions.
  Color assignRandomColor() {
    if (shuffledColorIndices.isEmpty) {
      shuffledColorIndices = List<int>.generate(colorPalette.length, (i) => i);
      shuffledColorIndices.shuffle(random);
    }

    return colorPalette[shuffledColorIndices.removeLast()];
  }

  /// **Filters Subscriptions Based on Selected Category**
  /// - Returns all subscriptions if 'All Subscriptions' is selected.
  /// - Otherwise, filters subscriptions that belong to the selected category.
  List<Subscription> filterListCategoryWise() {
    final selectedCategory = categories[categoriesSelectedIndex];

    if (selectedCategory == AppStrings.allSabs) {
      return subscriptions;
    }

    return subscriptions
        .where((subscription) => subscription.category.any((category) =>
            category.trim().toLowerCase() ==
            selectedCategory.trim().toLowerCase()))
        .toList();
  }

  /// **Assigns a Category to Selected Subscriptions**
  /// - Updates Hive storage to persist the category assignment.
  /// - Avoids duplicate categories in a subscription.
  Future<void> saveCategoryForSelectedSubscriptions({
    required String categoryName,
    required List<Subscription> selectedSubscriptions,
  }) async {
    try {
      for (var subscription in selectedSubscriptions) {
        if (!subscription.category.contains(categoryName)) {
          subscription.category.add(categoryName);
          await subscriptionBox.put(subscription.key, subscription);
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving categories: $e');
      throw Exception('Failed to save categories for subscriptions');
    }
  }
}
