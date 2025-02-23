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
    provider = context.read<GetStartedProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAnimation();
    });
    super.initState();
  }

  initAnimation() async {
    await provider.alterCarouselViewStateAfterSomeDelay();
    await provider.alterTexViewStateAfterSomeDelay();
    provider.alterButtonViewStateAfterSomeDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                    Consumer<GetStartedProvider>(
                      builder: (BuildContext context, provider, Widget? child) {
                        return AnimatedOpacity(
                          duration: const Duration(milliseconds: 1000),
                          opacity: provider.showCarousel ? 1.0 : 0.0,
                          curve: Curves.easeIn,
                          child: AnimatedScale(
                            duration: const Duration(milliseconds: 1000),
                            scale: provider.showCarousel ? 1.0 : 0.8,
                            curve: Curves.easeOut,
                            child: RoundIconCarouselView(),
                          ),
                        );
                      },
                    ),
                    Consumer<GetStartedProvider>(
                      builder: (BuildContext context, provider, Widget? child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 20),
                            AnimatedOpacity(
                              duration: const Duration(milliseconds: 800),
                              opacity: provider.showText ? 1.0 : 0.0,
                              curve: Curves.easeIn,
                              child: Text(
                                AppStrings.manageAllYourSubscriptions,
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
                              curve: Curves.easeIn,
                              child: Text(
                                AppStrings.keepRegularExpensesOnHand,
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
              Consumer<GetStartedProvider>(
                builder: (BuildContext context, provider, Widget? child) {
                  return AnimatedSlide(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOut,
                    offset:
                        provider.viewButton ? Offset.zero : const Offset(0, 2),
                    child: AppAnimatedButton(
                      text: AppStrings.getStarted,
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.mySubRoute);
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: kBottomNavigationBarHeight),
            ],
          ),
        ),
      ),
    );
  }
}
