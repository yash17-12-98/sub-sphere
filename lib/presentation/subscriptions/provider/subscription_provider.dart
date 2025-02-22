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
        category: AppStrings.design),
    Subscription(
        name: AppStrings.hboMax,
        price: 12,
        billingCycle: BillingCycle.month.name,
        iconPath: ImageAssets.hboImage,
        category: AppStrings.entertainment),
    Subscription(
        name: AppStrings.spotify,
        price: 12,
        billingCycle: BillingCycle.month.name,
        iconPath: ImageAssets.spotifyImage,
        category: AppStrings.entertainment),
    Subscription(
        name: AppStrings.playStationPlus,
        price: 67.57,
        billingCycle: BillingCycle.year.name,
        iconPath: ImageAssets.playStationImage,
        category: AppStrings.entertainment),
    Subscription(
        name: AppStrings.youtube,
        price: 8.97,
        billingCycle: BillingCycle.month.name,
        iconPath: ImageAssets.youtubeImage,
        category: AppStrings.entertainment),
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

  set categorySelected(int index) {
    categoriesSelectedIndex = index;
    notifyListeners();
  }

  List<String> get categories {
    final result = subscriptions
        .map((subscription) => subscription.category)
        .toSet() // Convert to Set to remove duplicates
        .toList(); // Convert back to List

    result.insert(0, AppStrings.allSabs);

    return result;
  }

  List<Subscription> filterListCategoryWise() {
    final selectedCategory = categories[categoriesSelectedIndex];

    return selectedCategory == AppStrings.allSabs
        ? subscriptions
        : subscriptions
            .where((sub) => sub.category == selectedCategory)
            .toList();
  }

  List<Subscription> get subscriptions => subscriptionBox.values.toList();

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

  Future<void> initializeDefaultData() async {
    if (subscriptionBox.isEmpty) {
      for (var subData in defaultSubscriptions) {
        await subscriptionBox.add(subData);
      }
      notifyListeners();
    }
  }
}
