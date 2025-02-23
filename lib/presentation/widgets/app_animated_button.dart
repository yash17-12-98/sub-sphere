import 'package:flutter/material.dart';
import '../resources/resources.dart';

class AppAnimatedButton extends StatefulWidget {
  final String text; // Button label text
  final Color? color; // Optional button background color
  final VoidCallback onPressed; // Callback function when button is pressed

  const AppAnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  State<AppAnimatedButton> createState() => _AppAnimatedButtonState();
}

class _AppAnimatedButtonState extends State<AppAnimatedButton> {
  bool isPressed = false; // Tracks button press state for animation

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Button stretches to full width
      height: AppSize.s50, // Fixed button height
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => isPressed = true); // Shrinks button on press
        },
        onTapUp: (_) {
          Future.delayed(Duration(milliseconds: 200), () {
            setState(
                () => isPressed = false); // Restores button size after delay
            widget.onPressed(); // Calls the provided callback function
          });
        },
        onTapCancel: () {
          setState(() =>
              isPressed = false); // Ensures button resets if press is canceled
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200), // Smooth animation duration
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(isPressed ? 0.9 : 1.0), // Scale effect for button press
          child: Container(
            decoration: BoxDecoration(
              color: widget.color ?? Colors.blue,
              // Default color is blue if none is provided
              borderRadius:
                  BorderRadius.circular(AppSize.s12), // Rounded corners
            ),
            child: Center(
              child: Text(
                widget.text,
                style: getMediumStyle(
                    color: ColorManager.white,
                    fontSize: FontSize.s18), // Button text styling
              ),
            ),
          ),
        ),
      ),
    );
  }
}
