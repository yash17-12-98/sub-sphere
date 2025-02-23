import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_sphere/app/extension.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/select_subscription_category_provider.dart';
import '../provider/subscription_provider.dart';
import '../../resources/resources.dart';
import '../../widgets/widgets.dart';
import 'components.dart';

class AddCategoryModalBottomView extends StatefulWidget {
  const AddCategoryModalBottomView({super.key});

  @override
  State<AddCategoryModalBottomView> createState() =>
      _AddCategoryModalBottomViewState();
}

class _AddCategoryModalBottomViewState
    extends State<AddCategoryModalBottomView> {
  final textController = TextEditingController();

  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    textController.addListener(checkValidation);
  }

  void checkValidation() {
    final selectSubscriptionProvider =
        context.read<SelectSubscriptionCategoryProvider>();
    isButtonEnabled.value = textController.text.trim().isNotEmpty &&
        selectSubscriptionProvider.selectedSubscriptions.isNotEmpty;
  }

  @override
  void dispose() {
    textController.removeListener(checkValidation);
    textController.dispose();
    isButtonEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: screenHeight * 0.8,
      decoration: BoxDecoration(
        color: ColorManager.darkGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s20),
          topRight: Radius.circular(AppSize.s20),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: CustomScrollView(
            slivers: [
              // Header Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.addCategory,
                        style: getMediumStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s20,
                        ),
                      ),
                      SizedBox(height: AppSize.s20),
                      Text(
                        AppStrings.enterName,
                        style: getRegularStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s15,
                        ),
                      ),
                      SizedBox(height: AppSize.s8),
                      AppTextField(controller: textController),
                      SizedBox(height: AppSize.s20),
                      Text(
                        AppStrings.selectSubscriptions,
                        style: getMediumStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Subscription List
              Consumer<SubscriptionProvider>(
                builder: (context, provider, _) {
                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final subscription = provider.subscriptions[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: AppSize.s20),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: AppSize.s20,
                                child: Image.asset(
                                  subscription.iconPath,
                                  scale: AppSize.s4,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                              title: Text(
                                subscription.name.orEmpty(),
                                style: getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                              trailing:
                                  Consumer<SelectSubscriptionCategoryProvider>(
                                builder: (context, provider, _) {
                                  return SelectCheckBox(
                                    value: provider
                                        .isSubscriptionSelectedForCategory(
                                      subscription,
                                    ),
                                    onChanged: (value) {
                                      provider.toggleSubscriptionSelection(
                                        subscription,
                                      );
                                      checkValidation();
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        childCount: provider.subscriptions.length,
                      ),
                    ),
                  );
                },
              ),

              // Save Button Section
              SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: true,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p20).copyWith(
                      bottom: MediaQuery.of(context).viewInsets.bottom +
                          AppPadding.p20,
                    ),
                    child: Consumer2<SubscriptionProvider,
                        SelectSubscriptionCategoryProvider>(
                      builder: (context, subscriptionProvider,
                          selectSubscriptionCategoryProvider, _) {
                        return ValueListenableBuilder(
                          valueListenable: isButtonEnabled,
                          builder: (context, enabled, _) {
                            return AppAnimatedButton(
                              text: AppStrings.save,
                              color: enabled
                                  ? ColorManager.blue
                                  : ColorManager.black,
                              onPressed: enabled
                                  ? () async {
                                      final navigator = Navigator.of(context);
                                      await subscriptionProvider
                                          .saveCategoryForSelectedSubscriptions(
                                        categoryName: textController.text,
                                        selectedSubscriptions:
                                            selectSubscriptionCategoryProvider
                                                .selectedSubscriptions,
                                      );
                                      navigator.pop();
                                    }
                                  : () {},
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   final screenHeight = MediaQuery.sizeOf(context).height;
//
//   return Container(
//     height: screenHeight * 0.8,
//     decoration: BoxDecoration(
//       color: ColorManager.darkGrey, // Dark background
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(20),
//         topRight: Radius.circular(20),
//       ),
//     ),
//     padding: EdgeInsets.only(
//       bottom: MediaQuery.of(context).viewInsets.bottom,
//       left: AppPadding.p20,
//       right: AppPadding.p20,
//       top: AppPadding.p20,
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: AppSize.s20),
//               Text(AppStrings.addCategory,
//                   style: getMediumStyle(
//                       color: ColorManager.white, fontSize: FontSize.s20)),
//               SizedBox(height: AppSize.s20),
//               Text(
//                 AppStrings.enterName,
//                 style: getRegularStyle(
//                     color: ColorManager.white, fontSize: FontSize.s15),
//               ),
//               SizedBox(height: 8),
//               AppTextField(controller: textController),
//               SizedBox(height: AppSize.s20),
//               Text(
//                 AppStrings.selectSubscriptions,
//                 style: getMediumStyle(
//                     color: ColorManager.white, fontSize: FontSize.s20),
//               ),
//               SizedBox(height: AppSize.s15),
//               Expanded(
//                 child: Consumer<SubscriptionProvider>(
//                   builder: (BuildContext context, provider, Widget? child) {
//                     return ListView.separated(
//                       shrinkWrap: true,
//                       itemCount: provider.subscriptions.length,
//                       itemBuilder: (context, index) {
//                         final subscription = provider.subscriptions[index];
//
//                         return ListTile(
//                           leading: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             radius: 20,
//                             child: Image.asset(
//                               subscription.iconPath,
//                               scale: 4,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Icon(Icons.error);
//                               },
//                             ),
//                           ),
//                           title: Text(
//                             subscription.name.orEmpty(),
//                             style: getRegularStyle(
//                                 color: ColorManager.white,
//                                 fontSize: FontSize.s16),
//                           ),
//                           trailing:
//                               Consumer<SelectSubscriptionCategoryProvider>(
//                             builder: (BuildContext context, provider,
//                                 Widget? child) {
//                               return SelectCheckBox(
//                                   value: provider
//                                       .isSubscriptionSelectedForCategory(
//                                           subscription),
//                                   onChanged: (value) {
//                                     provider.toggleSubscriptionSelection(
//                                         subscription);
//                                     checkValidation();
//                                   });
//                             },
//                           ),
//                         );
//                       },
//                       separatorBuilder: (BuildContext context, int index) {
//                         return SizedBox(
//                           height: AppSize.s20,
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//         Consumer2<SubscriptionProvider, SelectSubscriptionCategoryProvider>(
//           builder: (BuildContext context, subscriptionProvider,
//               selectSubscriptionCategoryProvider, Widget? child) {
//             return ValueListenableBuilder(
//               valueListenable: isButtonEnabled,
//               builder: (context, enabled, child) {
//                 return AppAnimatedButton(
//                   text: AppStrings.save,
//                   color: enabled ? ColorManager.blue : ColorManager.black,
//                   onPressed: isButtonEnabled.value ? () async {
//                     final navigator = Navigator.of(context);
//
//                     await subscriptionProvider
//                         .saveCategoryForSelectedSubscriptions(
//                             categoryName: textController.text,
//                             selectedSubscriptions:
//                                 selectSubscriptionCategoryProvider
//                                     .selectedSubscriptions);
//
//                     navigator.pop();
//                   } : (){},
//                 );
//               },
//             );
//           },
//         ),
//         SizedBox(height: kBottomNavigationBarHeight),
//       ],
//     ),
//   );
// }
}
