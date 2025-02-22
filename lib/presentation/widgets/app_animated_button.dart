import 'package:flutter/material.dart';
import '../resources/resources.dart';

class AppAnimatedButton extends StatefulWidget {
  final String text;

  const AppAnimatedButton({super.key, required this.text});

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
          setState(() => isPressed = false);
        },
        onTapCancel: () {
          setState(() => isPressed = false);
        },
        child: Transform.scale(
          scale: isPressed ? 0.9 : 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: getRegularStyle(
                    color: ColorManager.white, fontSize: FontSize.s18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
