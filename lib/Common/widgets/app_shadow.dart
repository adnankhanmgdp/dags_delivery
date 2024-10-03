import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

BoxDecoration appBoxDecoration(
    {Color color = AppColors.primaryBackground,
    double radius = 15,
    double borderWidth = 1.5,
    Color borderColor = AppColors.primaryText}) {
  return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: borderWidth));
}

BoxDecoration appBoxShadowWithUnidirectionalRadius(
    {Color color = AppColors.primaryElement,
    double radius = 20,
    double sR = 1,
    double bR = 2}) {
  return BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(25),
      ),
      border: Border.all(color: Colors.grey.shade300, width: 1.h),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          spreadRadius: sR,
          blurRadius: bR,
        )
      ]);
}
