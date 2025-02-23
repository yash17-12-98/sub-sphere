import 'package:flutter/material.dart';

import '../../resources/resources.dart';

/// A card widget that allows users to add a new subscription.
/// It displays a text label and an add icon inside a styled container.
class AddSubscriptionCard extends StatelessWidget {
  /// Constructor for `AddSubscriptionCard`.
  const AddSubscriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      /// Adds vertical spacing around the card.
      margin: EdgeInsets.symmetric(vertical: AppSize.s10),

      /// Adds padding inside the card to space out its content.
      padding: EdgeInsets.all(AppSize.s20),

      /// Styling for the card, including background color and rounded corners.
      decoration: BoxDecoration(
        color: Colors.blue, // Card background color
        borderRadius:
            BorderRadius.circular(16), // Rounded corners for a modern look
      ),

      /// A row layout that positions the text and icon at opposite ends.
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Aligns text on the left, icon on the right
        children: [
          /// Displays the "Add a Subscription" text with custom styling.
          Text(
            AppStrings.addASubscription, // Retrieves the localized string
            style: getRegularStyle(
                letterSpacing: 2.0, // Adds spacing between characters
                color: ColorManager.white, // Text color
                fontSize: FontSize.s20), // Font size
          ),

          /// A circular container that holds the "+" icon.
          Container(
            padding: const EdgeInsets.all(8), // Adds padding around the icon
            decoration: BoxDecoration(
              border: Border.all(
                  color: ColorManager.white, style: BorderStyle.solid),
              // White border around the circle
              shape: BoxShape.circle, // Makes the container circular
            ),
            child: Icon(Icons.add,
                color: ColorManager.white), // "+" icon in white color
          ),
        ],
      ),
    );
  }
}
