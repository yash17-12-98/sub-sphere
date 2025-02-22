import 'package:flutter/material.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';
import 'package:sub_sphere/presentation/resources/resources.dart';

class AppSubscriptionTile extends StatelessWidget {
  final Color tileColor;
  final Subscription subscription;

  const AppSubscriptionTile(
      {super.key, required this.tileColor, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subscription.name,
                style: getMediumStyle(
                    letterSpacing: 1.5,
                    color: ColorManager.white,
                    fontSize: FontSize.s20),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '\$${subscription.price}/${subscription.billingCycle}',
                  style: getMediumStyle(
                      letterSpacing: 2,
                      color: ColorManager.black,
                      fontSize: FontSize.s13),
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: Image.asset(
              subscription.iconPath,
              scale: AppSize.s3,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
        ],
      ),
    );
  }
}
