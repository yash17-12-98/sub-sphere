import 'package:flutter/material.dart';
import 'package:sub_sphere/app/extension.dart';

import '../../resources/resources.dart';

class PillShapeButton extends StatefulWidget {
  final bool selected;
  final String title;
  final VoidCallback onPressed;

  const PillShapeButton(
      {super.key,
      this.selected = false,
      required this.title,
      required this.onPressed});

  @override
  State<PillShapeButton> createState() => _PillShapeButtonState();
}

class _PillShapeButtonState extends State<PillShapeButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            isPressed = true;
          });
        },
        onTapUp: (_) {
          Future.delayed(Duration(milliseconds: 200), () {
            setState(() {
              isPressed = false;
            });
            widget.onPressed();
          });
        },
        onTapCancel: () {
          setState(() {
            isPressed = false;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()..scale(isPressed ? 0.8 : 1.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
            decoration: BoxDecoration(
              color: widget.selected.orFalse()
                  ? Colors.blue
                  : ColorManager.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              widget.title.orEmpty(),
              style: getMediumStyle(
                  color: ColorManager.white, fontSize: FontSize.s14),
            ),
          ),
        ),
      ),
    );
  }
}
