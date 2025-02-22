import 'package:flutter/material.dart';
import '../resources/resources.dart';

class AppAnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const AppAnimatedButton(
      {super.key, required this.text, required this.onPressed});

  @override
  State<AppAnimatedButton> createState() => _AppAnimatedButtonState();
}

class _AppAnimatedButtonState extends State<AppAnimatedButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.s50,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => isPressed = true);
          widget.onPressed();
        },
        onTapUp: (_) {
          setState(() => isPressed = false);
        },
        onTapCancel: () {
          setState(() => isPressed = false);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()..scale(isPressed ? 0.8 : 1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(AppSize.s12),
              // borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: getMediumStyle(
                    color: ColorManager.white, fontSize: FontSize.s18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
