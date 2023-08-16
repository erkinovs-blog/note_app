import 'package:flutter/material.dart';
import 'package:note_app/src/common/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.labelText,
    required this.enable,
    this.autofocus = false,
    this.fontSize,
    this.minLines,
    this.maxLines,
    this.height,
    super.key,
  });

  final bool enable;
  final int? minLines;
  final int? maxLines;
  final double? height;
  final double? fontSize;
  final bool autofocus;
  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enable,
      style: TextStyle(
        color: AppColors.white,
        fontSize: fontSize,
        height: height,
      ),
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      autofocus: autofocus,
      decoration: InputDecoration.collapsed(
        hintText: labelText,
        hintStyle: TextStyle(
          fontSize: fontSize,
          color: AppColors.hintTextColor,
        ),
      ),
    );
  }
}
