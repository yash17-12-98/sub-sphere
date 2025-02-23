import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub_sphere/presentation/welcome/get_started_provider.dart';
import '../resources/resources.dart';
import '../widgets/widgets.dart';
import 'components/components.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  late GetStartedProvider provider;

  @override
  void initState() {
    // Initialize provider instance for managing UI state.
    provider = context.read<GetStartedProvider>();

    // Trigger animations after the first frame is rendered.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.triggerAnimations();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black.
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.s15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Consumer to listen for changes in provider and trigger carousel animation.
                    Consumer<GetStartedProvider>(
                      builder: (BuildContext context, provider, Widget? child) {
                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 1000),
                          opacity: provider.showCarousel ? 1.0 : 0.0,
                          // Fade-in effect.
                          curve: Curves.easeIn,
                          child: AnimatedScale(
                            duration: const Duration(milliseconds: 1000),
                            scale: provider.showCarousel ? 1.0 : 0.8,
                            // Scaling effect.
                            curve: Curves.easeOut,
                            child:
                                RoundIconCarouselView(), // Custom widget for displaying carousel.
                          ),
                        );
                      },
                    ),

                    // Consumer to listen for changes and display animated text.
                    Consumer<GetStartedProvider>(
                      builder: (BuildContext context, provider, Widget? child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: AppSize.s40),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 800),
                              opacity: provider.showText ? 1.0 : 0.0,
                              // Fade-in effect.
                              curve: Curves.easeIn,
                              child: Text(
                                AppStrings.manageAllYourSubscriptions,
                                // Main heading text.
                                textAlign: TextAlign.center,
                                style: getBoldStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s35),
                              ),
                            ),
                            SizedBox(height: AppSize.s20),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 800),
                              opacity: provider.showText ? 1.0 : 0.0,
                              // Fade-in effect.
                              curve: Curves.easeIn,
                              child: Text(
                                AppStrings.keepRegularExpensesOnHand,
                                // Supporting text.
                                textAlign: TextAlign.center,
                                style: getRegularStyle(
                                    color: Colors.grey[400]!,
                                    fontSize: FontSize.s21),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Consumer to listen for button animation state changes.
              Consumer<GetStartedProvider>(
                builder: (BuildContext context, provider, Widget? child) {
                  return AnimatedSlide(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOut,
                    offset: provider.viewButton
                        ? Offset.zero
                        : const Offset(0, 5), // Slide animation.
                    child: AppAnimatedButton(
                      text: AppStrings.getStarted, // Button label.
                      onPressed: () {
                        Navigator.pushNamed(context,
                            Routes.mySubRoute); // Navigate to next screen.
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: kBottomNavigationBarHeight - AppSize.s20),
              // Adjust bottom spacing.
            ],
          ),
        ),
      ),
    );
  }
}
