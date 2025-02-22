import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_sphere/app/extension.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/subscription_provider.dart';

import '../../resources/resources.dart';
import '../../widgets/widgets.dart';

class AddCategoryModalBottomView extends StatelessWidget {
  const AddCategoryModalBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      height: screenHeight * 0.8,
      decoration: BoxDecoration(
        color: ColorManager.darkGrey, // Dark background
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: AppPadding.p20,
        right: AppPadding.p20,
        top: AppPadding.p20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSize.s20),
                Text(AppStrings.addCategory,
                    style: getMediumStyle(
                        color: ColorManager.white, fontSize: FontSize.s20)),
                SizedBox(height: AppSize.s20),
                Text(
                  AppStrings.enterName,
                  style: getRegularStyle(
                      color: ColorManager.white, fontSize: FontSize.s15),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: AppSize.s20),
                Text(
                  AppStrings.selectSubscriptions,
                  style: getMediumStyle(
                      color: ColorManager.white, fontSize: FontSize.s20),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Consumer<SubscriptionProvider>(
                    builder: (BuildContext context, provider, Widget? child) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: provider.subscriptions.length,
                        itemBuilder: (context, index) {
                          final subscription = provider.subscriptions[index];

                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Image.asset(
                                subscription.iconPath,
                                scale: 4,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                            title: Text(
                              subscription.name.orEmpty(),
                              style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s16),
                            ),
                            trailing: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey[700]!),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: AppSize.s20,
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          AppAnimatedButton(
            text: AppStrings.save,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(height: kBottomNavigationBarHeight),
        ],
      ),
    );
  }
}
