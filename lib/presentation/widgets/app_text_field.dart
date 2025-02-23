import 'package:flutter/material.dart';
import '../resources/resources.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller; // Controller to manage text input

  const AppTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      // Connects the TextField to the provided controller for input management
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          // Rounds the corners of the input field
          borderSide: BorderSide.none, // Removes the default border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          // Keeps the rounded corners when focused
          borderSide: BorderSide(
              color: Colors.blue), // Changes border color to blue when focused
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 14), // Adds padding inside the text field
      ),
      cursorColor: ColorManager.white,
      // Sets the cursor color to white
      style: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s18), // Defines text style (color and size)
    );
  }
}
