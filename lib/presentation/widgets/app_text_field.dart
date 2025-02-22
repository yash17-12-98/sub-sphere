import 'package:flutter/material.dart';
import '../resources/resources.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;

  const AppTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      cursorColor: ColorManager.white,
      style: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s18),
    );
  }
}
