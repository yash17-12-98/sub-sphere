import 'package:flutter/material.dart';
import '../resources/resources.dart';

class AppAnimatedButton extends StatefulWidget {
  final String text;
  final Color? color;
  final VoidCallback onPressed;

  const AppAnimatedButton(
      {super.key, required this.text, required this.onPressed, this.color});

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
        },
        onTapUp: (_) {
          Future.delayed(Duration(milliseconds: 200), () {
            setState(() => isPressed = false);
            widget.onPressed();
          });
        },
        onTapCancel: () {
          setState(() => isPressed = false);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()..scale(isPressed ? 0.9 : 1.0),
          child: Container(
            decoration: BoxDecoration(
              color: widget.color ?? Colors.blue,
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
