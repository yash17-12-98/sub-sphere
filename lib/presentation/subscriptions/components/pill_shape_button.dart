import 'package:flutter/material.dart';
import 'package:sub_sphere/app/extension.dart';

import '../../resources/resources.dart';

/// A pill-shaped button with a press effect.
/// It supports a selected state and executes a callback function when pressed.
class PillShapeButton extends StatefulWidget {
  /// Indicates whether the button is selected.
  final bool selected;

  /// The text label displayed on the button.
  final String title;

  /// Callback function triggered when the button is pressed.
  final VoidCallback onPressed;

  /// Constructor for `PillShapeButton`, with an optional `selected` state (defaults to `false`).
  const PillShapeButton(
      {super.key,
        this.selected = false,
        required this.title,
        required this.onPressed});

  @override
  State<PillShapeButton> createState() => _PillShapeButtonState();
}

class _PillShapeButtonState extends State<PillShapeButton> {
  /// Tracks whether the button is currently pressed.
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        /// Detects when the button is pressed down and updates the `isPressed` state.
        onTapDown: (_) {
          setState(() {
            isPressed = true;
          });
        },

        /// Detects when the button is released, resets the state after a delay, and triggers the callback.
        onTapUp: (_) {
          Future.delayed(Duration(milliseconds: 200), () {
            setState(() {
              isPressed = false;
            });
            widget.onPressed(); // Calls the provided function when button is tapped
          });
        },

        /// Handles cases where the press is canceled (e.g., user moves finger away).
        onTapCancel: () {
          setState(() {
            isPressed = false;
          });
        },

        /// Animated container to provide a scaling effect when pressed.
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()..scale(isPressed ? 0.8 : 1.0), // Shrinks button when pressed

          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              /// Changes color based on the selected state.
              color: widget.selected.orFalse()
                  ? Colors.blue
                  : ColorManager.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20), // Rounded button shape
            ),
            child: Text(
              widget.title.orEmpty(), // Displays the button text
              style: getMediumStyle(
                  color: ColorManager.white, fontSize: FontSize.s14),
            ),
          ),
        ),
      ),
    );
  }
}
