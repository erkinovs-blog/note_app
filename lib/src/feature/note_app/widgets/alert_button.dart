import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/app_colors.dart';

class AlertButton extends StatefulWidget {
  const AlertButton({
    super.key,
    required this.text,
    required this.result,
    required this.color,
  });
  final bool result;
  final String text;
  final Color color;

  @override
  State<AlertButton> createState() => _AlertButtonState();
}

class _AlertButtonState extends State<AlertButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(const Radius.circular(5).r),
        ),
      ),
      onPressed: () {
        Navigator.pop(context, widget.result);
      },
      child: Text(
        widget.text,
        style: const TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}
