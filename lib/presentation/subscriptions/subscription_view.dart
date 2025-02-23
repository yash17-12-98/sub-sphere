import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/select_subscription_category_provider.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/subscription_provider.dart';

import '../resources/resources.dart';
import 'components/components.dart';

/// **SubscriptionsView**

/// This screen displays the user's subscriptions categorized with a horizontal
/// scrollable list of categories and a list of subscription items. It also
/// allows adding new categories for certain subscriptions.

class SubscriptionsView extends StatefulWidget {
  const SubscriptionsView({super.key});

  @override
  State<SubscriptionsView> createState() => _SubscriptionsViewState();
}

class _SubscriptionsViewState extends State<SubscriptionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              /// **Top Navigation Row** - Contains:
              /// - Menu button (left)
              /// - "My Subscriptions" label with an icon (center)
              /// - Notifications button (right)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  viewIconButton(Icons.menu, () {}), // Menu icon button
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.subscriptions, color: Colors.white),
                        SizedBox(width: AppSize.s8),
                        Text(
                          AppStrings.mySabs, // Subscription heading
                          style: getRegularStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s15),
                        ),
                      ],
                    ),
                  ),
                  viewIconButton(Icons.notifications, () {}), // Notifications button
                ],
              ),

              SizedBox(height: AppSize.s10),

              /// **Category Selection Bar**
              /// Displays a horizontally scrollable list of subscription categories.
              /// Users can select a category, and the subscriptions list updates accordingly.
              Consumer<SubscriptionProvider>(
                builder: (context, provider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(provider.categories.length,
                                    (index) {
                                  return Row(
                                    children: [
                                      PillShapeButton(
                                        selected: provider.categoriesSelectedIndex == index,
                                        title: provider.categories[index], // Category name
                                        onPressed: () {
                                          provider.categorySelected = index; // Update selected category
                                        },
                                      ),
                                      const SizedBox(width: AppSize.s8),
                                    ],
                                  );
                                }),
                          ),
                        ),
                      ),

                      /// **Add Category Button**
                      /// Opens a bottom sheet to add a new category.
                      IconButton(
                        icon: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                        onPressed: () => showAddCategorySheet(context),
                      ),
                    ],
                  );
                },
              ),

              /// **Subscription List View**
              /// Displays a list of subscriptions filtered by the selected category.
              Expanded(
                child: Consumer<SubscriptionProvider>(
                  builder: (context, provider, child) {
                    final subscriptions = provider.filterListCategoryWise();

                    return AnimationLimiter(
                      key: ValueKey(provider.categoriesSelectedIndex), // Ensures animation updates correctly
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: AppSize.s5),
                        itemCount: subscriptions.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return AddSubscriptionCard(); // First item allows adding a new subscription
                          }
                          final subscription = subscriptions[index - 1];

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 675),
                            child: SlideAnimation(
                              horizontalOffset: 100.0,
                              child: FadeInAnimation(
                                child: SubscriptionTile(
                                  tileColor: provider.assignRandomColor(), // Assigns a random background color
                                  subscription: subscription, // Subscription data
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: AppSize.s5);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Show Add Category Modal Sheet**
  ///
  /// Displays a modal bottom sheet for adding a new subscription category.
  Future<void> showAddCategorySheet(BuildContext context) async {
    final value = context.read<SelectSubscriptionCategoryProvider>();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCategoryModalBottomView(),
    );

    value.clearSelectedSubscriptions(); // Clears selections after modal closes
  }

  /// **Reusable Icon Button**
  /// Creates a circular button with a custom icon.
  Widget viewIconButton(IconData? icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
        border: Border.all(width: 1),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: AppSize.s20, color: ColorManager.white),
        onPressed: onPressed,
      ),
    );
  }
}
