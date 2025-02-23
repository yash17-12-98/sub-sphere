import 'package:flutter/material.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';

import '../../resources/resources.dart';

/// A custom widget that represents a single subscription tile.
/// It displays subscription details such as name, price, billing cycle, and an icon.
class SubscriptionTile extends StatelessWidget {
  /// Background color of the tile.
  final Color tileColor;

  /// Subscription data model containing details of the subscription.
  final Subscription subscription;

  /// Constructor for `SubscriptionTile`, requiring `tileColor` and `subscription` as parameters.
  const SubscriptionTile(
      {super.key, required this.tileColor, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Adds space below each tile
      padding: const EdgeInsets.all(16), // Adds padding inside the tile
      decoration: BoxDecoration(
        color: tileColor, // Background color of the tile
        borderRadius:
            BorderRadius.circular(16), // Rounded corners for a smooth UI
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // Space between text and icon
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Aligns text to the start (left)
            children: [
              /// Displays the subscription name with custom styling.
              Text(
                subscription.name,
                style: getMediumStyle(
                    letterSpacing: 1.5,
                    color: ColorManager.white,
                    fontSize: FontSize.s20),
              ),

              /// A styled container that shows the subscription price and billing cycle.
              Container(
                margin: const EdgeInsets.only(top: 20),
                // Spacing between name and price tag
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                // Padding inside the price tag
                decoration: BoxDecoration(
                  color: Colors.white, // White background for the price tag
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                child: Text(
                  '\$${subscription.price}/${subscription.billingCycle}',
                  // Displays price and billing cycle
                  style: getMediumStyle(
                      letterSpacing: 2,
                      color: ColorManager.black,
                      fontSize: FontSize.s13),
                ),
              ),
            ],
          ),

          /// A circular avatar that displays the subscription icon.
          CircleAvatar(
            backgroundColor: Colors.white, // Background color for the avatar
            radius: 30, // Sets the size of the avatar
            child: Image.asset(
              subscription.iconPath, // Loads the subscription icon from assets
              scale: AppSize.s3, // Adjusts the size of the image
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons
                    .error); // Displays an error icon if the image fails to load
              },
            ),
          ),
        ],
      ),
    );
  }
}
