import 'package:flutter/material.dart';

class AppSelectCheckBox extends StatelessWidget {
  final bool
      value; // Holds the current state of the checkbox (checked or unchecked)
  final void Function(bool?)?
      onChanged; // Callback function triggered when the checkbox state changes

  const AppSelectCheckBox({super.key, this.value = false, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
        scale: 1.2, // Scales up the checkbox size by 20%
        child: Checkbox(
          value: value,
          // Determines if the checkbox is checked or not
          onChanged: onChanged,
          // Calls the callback function when checkbox state changes
          shape: CircleBorder(),
          // Makes the checkbox circular instead of the default square
          side: BorderSide(
            color: Colors.grey[700]!, // Sets the border color to dark grey
            width: 2, // Defines the thickness of the border
          ),
          activeColor: Colors.blue,
          // Changes the checkbox fill color when checked
          checkColor: Colors.white, // Sets the color of the checkmark
        ));
  }
}
