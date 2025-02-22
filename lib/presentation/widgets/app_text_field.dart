import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../resources/resources.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focus;
  final bool autofocus;
  final bool isReadOnly;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final bool isSecure;
  final bool viewBorder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final Color? shadowColor;
  final double elevation;
  final int? maxLines;
  final double borderRadius;
  final Color? borderColor;
  final BoxConstraints? prefixIconConstraints;
  final EdgeInsetsGeometry? contentPadding;

  const AppTextField(
      {super.key,
      this.validator,
      this.controller,
      this.hintText,
      this.onChanged,
      this.inputFormatters,
      this.prefixIcon,
      this.keyboardType,
      this.suffixIcon,
      this.isSecure = false,
      this.focus,
      this.isReadOnly = false,
      this.onTap,
      this.onFieldSubmitted,
      this.textInputAction,
      this.autofocus = false,
      this.errorText,
      this.viewBorder = true,
      this.shadowColor,
      this.elevation = 0.0,
      this.labelText,
      this.maxLines,
      this.borderRadius = 10,
      this.borderColor,
      this.focusNode,
      this.prefixIconConstraints,
      this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      focusNode: focusNode,
      readOnly: isReadOnly,
      validator: validator,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      obscureText: isSecure,
      keyboardType: keyboardType,
      onChanged: onChanged,
      textInputAction: textInputAction ?? TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      autocorrect: false,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: contentPadding,
        hintStyle: getRegularStyle(
            color: ColorManager.white.withValues(alpha: 0.6), fontSize: 16),
        labelText: labelText,
        labelStyle: getRegularStyle(color: ColorManager.white, fontSize: 16),
        errorText: errorText,
        errorMaxLines: 2,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconConstraints: prefixIconConstraints,
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: borderColor ?? ColorManager.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: borderColor ?? ColorManager.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      ),
    );
  }
}
