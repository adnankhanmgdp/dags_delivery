import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Common/widgets/text_widgets.dart';
import '../../../Common/utils/app_colors.dart';
import '../../../Common/utils/image_res.dart';
import '../../../Common/widgets/app_shadow.dart';
import '../Provider/proof_notifier.dart';

Widget proofText() {
  return textcustomnormal(
    text: "Upload Proof of Your Identity",
    fontWeight: FontWeight.w500,
    fontSize: 36.w,
    color: const Color(0xff161416),
  );
}

Widget proofText02() {
  return text14normal(
    color: Colors.grey.shade500,
    text: "Please submit the document below",
    fontWeight: FontWeight.w400,
  );
}

Widget proofText03() {
  return const textUnderline(text: "Need Help??");
}

Widget documentsButtons01(
    {String buttonText = "Aadhar Card",
    Color buttonTextColor = AppColors.primaryElementText,
    String buttonIcon = ImageRes.aadharIcon,
    double buttonBorderWidth = 1.0,
    Color iconColor = const Color(0xfffff0ce),
    required WidgetRef ref,
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  int index = ref.watch(proofNotifierProvider);
  Color buttonColor;
  if (index == 0) {
    buttonColor = AppColors.documentButtonBg;
  }
  else if (index == 1) {
    buttonColor = Colors.greenAccent;
  } else {
    buttonColor = Colors.grey.shade400;
  }
  return GestureDetector(
    onTap: anyWayDoor!,
    child: Container(
      alignment: Alignment.center,
      height: 55,
      width: 350,
      decoration: appBoxDecoration(
          color: buttonColor,
          borderWidth: buttonBorderWidth,
          radius: 10.w,
          borderColor: Colors.grey.shade400),
      child: Row(
        children: [
          Container(
              height: 40.h,
              width: 40.w,
              decoration: appBoxDecoration(
                  color: iconColor,
                  radius: 7.w,
                  borderWidth: 0.0,
                  borderColor: Colors.white),
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
              child: Image.asset(buttonIcon)),
          SizedBox(
            width: 5.w,
          ),
          Text(
            buttonText,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          SizedBox(
            width: 5.w,
          ),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            size: 3.h,
          )
        ],
      ),
    ),
  );
}

Widget documentsButtons02(
    {String buttonText = "Pan Card",
    Color buttonTextColor = AppColors.primaryElementText,
    String buttonIcon = ImageRes.panIcon,
    double buttonBorderWidth = 1.0,
    Color iconColor = const Color(0xfffff0ce),
    required WidgetRef ref,
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  int index = ref.watch(proofNotifierProvider);
  Color buttonColor;
  if (index == 0) {
    buttonColor = AppColors.documentButtonBg;
  }
  else if (index == 2) {
    buttonColor = Colors.greenAccent;
  } else {
    buttonColor = Colors.grey.shade400;
  }
  return GestureDetector(
    onTap: anyWayDoor!,
    child: Container(
      alignment: Alignment.center,
      height: 55,
      width: 350,
      decoration: appBoxDecoration(
          color: buttonColor,
          borderWidth: buttonBorderWidth,
          radius: 10.w,
          borderColor: Colors.grey.shade400),
      child: Row(
        children: [
          Container(
              height: 40.h,
              width: 40.w,
              decoration: appBoxDecoration(
                  color: iconColor,
                  radius: 7.w,
                  borderWidth: 0.0,
                  borderColor: Colors.white),
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
              child: Image.asset(buttonIcon)),
          SizedBox(
            width: 5.w,
          ),
          Text(
            buttonText,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          SizedBox(
            width: 5.w,
          ),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            size: 3.h,
          )
        ],
      ),
    ),
  );
}

Widget documentsButtons03(
    {String buttonText = "Driving Licence",
    Color buttonTextColor = AppColors.primaryElementText,
    String buttonIcon = ImageRes.licenceIcon,
    double buttonBorderWidth = 1.0,
    Color iconColor = const Color(0xfffff0ce),
    required WidgetRef ref,
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  int index = ref.watch(proofNotifierProvider);
  Color buttonColor;
  if (index == 0) {
    buttonColor = AppColors.documentButtonBg;
  }
  else if (index == 3) {
    buttonColor = Colors.greenAccent;
  } else {
    buttonColor = Colors.grey.shade400;
  }
  return GestureDetector(
    onTap: anyWayDoor!,
    child: Container(
      alignment: Alignment.center,
      height: 55,
      width: 350,
      decoration: appBoxDecoration(
          color: buttonColor,
          borderWidth: buttonBorderWidth,
          radius: 10.w,
          borderColor: Colors.grey.shade400),
      child: Row(
        children: [
          Container(
              height: 40.h,
              width: 40.w,
              decoration: appBoxDecoration(
                  color: iconColor,
                  radius: 7.w,
                  borderWidth: 0.0,
                  borderColor: Colors.white),
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
              child: Image.asset(buttonIcon)),
          SizedBox(
            width: 5.w,
          ),
          Text(
            buttonText,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          SizedBox(
            width: 5.w,
          ),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            size: 3.h,
          )
        ],
      ),
    ),
  );
}
