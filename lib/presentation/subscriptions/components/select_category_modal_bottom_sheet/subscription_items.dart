import 'package:flutter/material.dart';
import 'package:sub_sphere/app/extension.dart';
import 'package:sub_sphere/models/subscription/subscription.dart';
import '../../../resources/resources.dart';
import '../components.dart';

/// A widget that represents a single subscription item with an animated effect when selected.
class SubscriptionItem extends StatefulWidget {
  final Subscription subscription;
  final VoidCallback onCheckboxChanged;

  /// Creates a subscription item with a checkbox for selection.
  const SubscriptionItem({
    required this.subscription,
    required this.onCheckboxChanged,
    super.key,
  });

  @override
  State<SubscriptionItem> createState() => _SubscriptionItemState();
}

class _SubscriptionItemState extends State<SubscriptionItem>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initializes the animation controller with a duration of 300ms.
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Defines an opacity animation that fades text to 30% transparency.
    opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.3,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    // Disposes the animation controller when the widget is removed.
    controller.dispose();
    super.dispose();
  }

  /// Triggers the fade animation when the checkbox is toggled.
  void playAnimation() {
    controller.forward().then((_) => controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: Image.asset(
            widget.subscription.iconPath,
            scale: 4,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
        ),
        title: FadeTransition(
          opacity: opacityAnimation,
          child: Text(
            widget.subscription.name.orEmpty(),
            style: getRegularStyle(
              color: ColorManager.white,
              fontSize: FontSize.s16,
            ),
          ),
        ),
        trailing: SubscriptionCheckbox(
          subscription: widget.subscription,
          onChanged: () {
            playAnimation(); // Play animation on checkbox change.
            widget.onCheckboxChanged();
          },
        ),
      ),
    );
  }
}
