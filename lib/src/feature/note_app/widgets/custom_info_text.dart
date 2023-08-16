import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';

class CustomInfoText extends StatelessWidget {
  const CustomInfoText({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: AppColors.white,
        height: 1.5,
      ),
    );
  }
}
