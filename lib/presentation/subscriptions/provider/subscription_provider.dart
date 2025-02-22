import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sub_sphere/app/enums.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';
import 'package:sub_sphere/presentation/base/base.dart';

import '../../resources/resources.dart';

class SubscriptionProvider extends BaseProvider {
  final Box<Subscription> subscriptionBox;

  SubscriptionProvider({required this.subscriptionBox}) {
    initializeDefaultData();
  }

  static final List<Subscription> defaultSubscriptions = [
    Subscription(
        name: AppStrings.figma,
        price: 12,
        billingCycle: BillingCycle.month.name,
        iconPath: ImageAssets.figmaImage,
        category: [AppStrings.design]),
    Subscription(
        name: AppStrings.hboMax,
        price: 12,
        billingCycle: BillingCycle.month.name,
        iconPath: ImageAssets.hboImage,
        category: [AppStrings.entertainment]),
    Subscription(
        name: AppStrings.spotify,
        price: 12,
        billingCycle: BillingCycle.month.name,
        iconPath: ImageAssets.spotifyImage,
        category: [AppStrings.entertainment]),
    Subscription(
        name: AppStrings.playStationPlus,
        price: 67.57,
        billingCycle: BillingCycle.year.name,
        iconPath: ImageAssets.playStationImage,
        category: [AppStrings.entertainment]),
    Subscription(
        name: AppStrings.youtube,
        price: 8.97,
        billingCycle: BillingCycle.month.name,
        iconPath: ImageAssets.youtubeImage,
        category: [AppStrings.entertainment]),
  ];

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

  int categoriesSelectedIndex = 0;

  List<Subscription> get subscriptions => subscriptionBox.values.toList();

  set categorySelected(int index) {
    categoriesSelectedIndex = index;
    notifyListeners();
  }

  List<String> get categories {
    final list = [AppStrings.allSabs]; // Start with 'All'

    final categorySet = subscriptions
        .expand((subscription) => subscription.category)
        .where((category) => category.isNotEmpty)
        .toSet();

    list.addAll(categorySet);

    return list;
  }

  Future<void> initializeDefaultData() async {
    if (subscriptionBox.isEmpty) {
      for (var subData in defaultSubscriptions) {
        await subscriptionBox.add(subData);
      }
      notifyListeners();
    }
  }

  Color assignRandomColor() {
    if (shuffledColorIndices.isEmpty) {
      shuffledColorIndices = List<int>.generate(colorPalette.length, (i) => i);

      for (var i = shuffledColorIndices.length - 1; i > 0; i--) {
        var j = random.nextInt(i + 1);
        var temp = shuffledColorIndices[i];
        shuffledColorIndices[i] = shuffledColorIndices[j];
        shuffledColorIndices[j] = temp;
      }
    }

    final colorIndex = shuffledColorIndices.removeLast();
    return colorPalette[colorIndex];
  }

  List<Subscription> filterListCategoryWise() {
    final selectedCategory = categories[categoriesSelectedIndex];

    if (selectedCategory == AppStrings.allSabs) {
      return subscriptions;
    }

    return subscriptions.where((subscription) {
      return subscription.category
          .any((category) => category.trim() == selectedCategory.trim());
    }).toList();
  }

  Future<void> saveCategoryForSelectedSubscriptions({
    required String categoryName,
    required List<Subscription> selectedSubscriptions,
  }) async {
    try {
      for (var subscription in selectedSubscriptions) {
        final index = subscriptions.indexOf(subscription);
        if (index != -1) {
          if (!subscription.category.contains(categoryName)) {
            subscription.category.add(categoryName);

            await subscriptionBox.putAt(index, subscription);
          }
        }
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error saving categories: $e');
      throw Exception('Failed to save categories for subscriptions');
    }
  }
}
