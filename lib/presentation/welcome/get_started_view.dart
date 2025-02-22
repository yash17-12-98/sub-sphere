import 'package:flutter/material.dart';
import '../resources/resources.dart';
import '../widgets/widgets.dart';
import 'components/components.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.s15),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.1),
              RoundIconCarouselView(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: screenHeight * 0.04),
                    Text(
                      AppStrings.manageAllYourSubscriptions,
                      textAlign: TextAlign.center,
                      style: getBoldStyle(
                          color: ColorManager.white, fontSize: FontSize.s35),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Text(
                      AppStrings.keepRegularExpensesOnHand,
                      textAlign: TextAlign.center,
                      style: getRegularStyle(
                          color: Colors.grey[400]!, fontSize: FontSize.s21),
                    ),
                    Spacer(),
                    Flexible(
                      child: AppAnimatedButton(
                        text: AppStrings.getStarted,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.mySubRoute);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kBottomNavigationBarHeight),
            ],
          ),
        ),
      ),
    );
  }
}
