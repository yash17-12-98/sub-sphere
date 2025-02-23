import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_sphere/presentation/subscriptions/provider/select_subscription_category_provider.dart';
import '../../provider/subscription_provider.dart';
import '../../../resources/resources.dart';
import '../../../widgets/widgets.dart';
import '../components.dart';

/// A modal bottom sheet that allows users to add a new subscription category.
/// It includes a text field for the category name and a list of subscriptions
/// to associate with the category.
class AddCategoryModalBottomView extends StatefulWidget {
  const AddCategoryModalBottomView({super.key});

  @override
  State<AddCategoryModalBottomView> createState() =>
      _AddCategoryModalBottomViewState();
}

class _AddCategoryModalBottomViewState
    extends State<AddCategoryModalBottomView> {
  /// Controller for handling text input.
  final textController = TextEditingController();

  /// Notifier to track if the save button should be enabled.
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    // Listen to text changes and validate input.
    textController.addListener(checkValidation);
  }

  /// Checks if the text field is not empty and at least one subscription is selected.
  void checkValidation() {
    final selectSubscriptionProvider =
        context.read<SelectSubscriptionCategoryProvider>();
    isButtonEnabled.value = textController.text.trim().isNotEmpty &&
        selectSubscriptionProvider.selectedSubscriptions.isNotEmpty;
  }

  @override
  void dispose() {
    // Remove the listener and dispose of controllers when the widget is destroyed.
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
      height: screenHeight * 0.8, // Set modal height to 80% of screen height
      decoration: BoxDecoration(
        color: ColorManager.darkGrey, // Dark grey background
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.s20),
          topRight: Radius.circular(AppSize.s20),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        // Prevent keyboard from resizing the modal
        body: Column(
          children: [
            SizedBox(height: AppSize.s15),

            /// Drag handle for the bottom sheet
            Center(
              child: Container(
                width: AppSize.s50,
                height: AppSize.s5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ColorManager.white.withValues(alpha: 0.2),
                ),
              ),
            ),

            SizedBox(height: AppSize.s10),

            /// Main content area using CustomScrollView for better performance
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomPadding),
                child: CustomScrollView(
                  slivers: [
                    /// Header Section: Title, Input Field, and Instruction Text
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(AppPadding.p20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// "Add Category" title
                            Text(
                              AppStrings.addCategory,
                              style: getMediumStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s20,
                              ),
                            ),
                            SizedBox(height: AppSize.s20),

                            /// "Enter Category Name" label
                            Text(
                              AppStrings.enterName,
                              style: getRegularStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s15,
                              ),
                            ),
                            SizedBox(height: AppSize.s8),

                            /// Text field for category name input
                            AppTextField(controller: textController),
                            SizedBox(height: AppSize.s20),

                            /// "Select Subscriptions" label
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

                    /// Subscription List Section
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

                                /// List item for each subscription
                                return Padding(
                                  padding: EdgeInsets.only(bottom: AppSize.s20),
                                  child: SubscriptionItem(
                                    subscription: subscription,
                                    onCheckboxChanged: () {
                                      // Toggle selection state of subscription
                                      context
                                          .read<
                                              SelectSubscriptionCategoryProvider>()
                                          .toggleSubscriptionSelection(
                                              subscription);
                                      checkValidation(); // Revalidate input
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

            /// Save Button
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

                        /// Save button action
                        onPressed: enabled
                            ? () async {
                                final navigator = Navigator.of(context);

                                // Save selected subscriptions under the given category name
                                await subscriptionProvider
                                    .saveCategoryForSelectedSubscriptions(
                                  categoryName: textController.text,
                                  selectedSubscriptions:
                                      selectSubscriptionCategoryProvider
                                          .selectedSubscriptions,
                                );

                                navigator.pop(); // Close modal after saving
                              }
                            : () {}, // Disabled state does nothing
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
