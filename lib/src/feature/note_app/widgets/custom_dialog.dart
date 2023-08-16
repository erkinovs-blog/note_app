import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_colors.dart';
import 'alert_button.dart';

class CustomDialog {
  static Future<bool?> showCustomDialog({
    required BuildContext context,
    required String text,
    required String cancelText,
    required String acceptText,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(const Radius.circular(20).r),
          ),
          backgroundColor: AppColors.scaffoldBG,
          title: const Icon(
            Icons.info,
            color: Color(0xFF606060),
          ),
          content: Text(
            text,
            style: TextStyle(
              color: AppColors.clearButtonColor,
              fontSize: 23.sp,
            ),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          contentPadding: EdgeInsets.only(
            top: 30.h,
            left: 10.w,
            right: 10.w,
          ),
          actionsPadding: EdgeInsets.only(
            top: 30.h,
            bottom: 38.h,
            left: 38.w,
            right: 38.w,
          ),
          actions: [
            AlertButton(text: cancelText, result: false, color: Colors.red),
            AlertButton(text: acceptText, result: true, color: Colors.green),
          ],
        );
      },
    );
  }
}
