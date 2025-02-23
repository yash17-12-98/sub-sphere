import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/select_subscription_category_provider.dart';
import '../../provider/subscription_provider.dart';
import '../../../resources/resources.dart';
import '../../../widgets/widgets.dart';
import '../components.dart';

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
        body: Column(
          children: [
            SizedBox(height: AppSize.s15),
            Center(
              child: Container(
                width: AppSize.s50,
                height: AppSize.s5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: ColorManager.white.withValues(alpha: 0.2)),
              ),
            ),
            SizedBox(height: AppSize.s10),
            Expanded(
              child: Padding(
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
                          padding:
                              EdgeInsets.symmetric(horizontal: AppPadding.p20),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final subscription =
                                    provider.subscriptions[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: AppSize.s20),
                                  child: SubscriptionItem(
                                    subscription: subscription,
                                    onCheckboxChanged: () {
                                      context
                                          .read<
                                              SelectSubscriptionCategoryProvider>()
                                          .toggleSubscriptionSelection(
                                              subscription);
                                      checkValidation();
                                    },
                                  ),
                                );
                              },
                              childCount: provider.subscriptions.length,
                            ),
                          ),
                        );
                      },
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppPadding.p20),
              child: Consumer2<SubscriptionProvider,
                  SelectSubscriptionCategoryProvider>(
                builder: (context, subscriptionProvider,
                    selectSubscriptionCategoryProvider, _) {
                  return ValueListenableBuilder(
                    valueListenable: isButtonEnabled,
                    builder: (context, enabled, _) {
                      return AppAnimatedButton(
                        text: AppStrings.save,
                        color: enabled ? ColorManager.blue : ColorManager.black,
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
          ],
        ),
      ),
    );
  }
}
