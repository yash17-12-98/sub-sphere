import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class AddSubscriptionCard extends StatelessWidget {
  const AddSubscriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppSize.s10),
      padding: EdgeInsets.all(AppSize.s20),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.addASubscription,
            style: getRegularStyle(
                letterSpacing: 2.0,
                color: ColorManager.white,
                fontSize: FontSize.s20),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                  color: ColorManager.white, style: BorderStyle.solid),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: ColorManager.white),
          ),
        ],
      ),
    );
  }
}
