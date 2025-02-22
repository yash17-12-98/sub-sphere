import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/select_subscription_category_provider.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/subscription_provider.dart';

import '../resources/resources.dart';
import 'components/components.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  viewIconButton(Icons.menu, () {}),
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
                          AppStrings.mySabs,
                          style: getRegularStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s15),
                        ),
                      ],
                    ),
                  ),
                  viewIconButton(Icons.notifications, () {}),
                ],
              ),
              SizedBox(height: AppSize.s10),
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
                                  selected:
                                      provider.categoriesSelectedIndex == index,
                                  title: provider.categories[index],
                                  onPressed: () =>
                                      provider.categorySelected = index,
                                ),
                                const SizedBox(width: 12),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
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
              }),
              Expanded(
                child: Consumer<SubscriptionProvider>(
                  builder: (context, provider, child) {
                    final subscriptions = provider.filterListCategoryWise();

                    return ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      itemCount: subscriptions.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return AddSubscriptionCard();
                        }
                        final subscription = subscriptions[index - 1];

                        return SubscriptionTile(
                            tileColor: provider.assignRandomColor(),
                            subscription: subscription);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: AppSize.s5,
                        );
                      },
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

  Future<void> showAddCategorySheet(BuildContext context) async {
    final value = context.read<SelectSubscriptionCategoryProvider>();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddCategoryModalBottomView(),
    );

    value.clearSelectedSubscriptions();
  }

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
