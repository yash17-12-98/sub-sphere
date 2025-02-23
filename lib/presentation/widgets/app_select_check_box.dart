import 'package:flutter/material.dart';

class AppSelectCheckBox extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;

  const AppSelectCheckBox({super.key, this.value = false, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 1.2, // Adjust size as needed
        child: Checkbox(
          value: value,
          onChanged: onChanged,
          shape: CircleBorder(),
          side: BorderSide(
            color: Colors.grey[700]!,
            width: 2,
          ),
          activeColor: Colors.blue,
          checkColor: Colors.white,
        ));
  }
}
