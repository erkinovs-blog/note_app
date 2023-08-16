import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.icon,
    this.onPressed,
    super.key,
  });

  final IconData? icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      style: IconButton.styleFrom(
        backgroundColor: AppColors.actionButtonBG,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            const Radius.circular(15).r,
          ),
        ),
        fixedSize: Size.square(50.w),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: AppColors.white,
        size: 24.w,
      ),
    );
  }
}
