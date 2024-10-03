import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common/utils/app_colors.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../../../main.dart';

Widget termsHeading(String text) {
  return Container(
      margin: EdgeInsets.fromLTRB(20.w, 20.w, 0, 0),
      child: textcustomnormal(
        text: text,
        fontWeight: FontWeight.w700,
        fontfamily: "Inter",
        fontSize: 22,
      ));
}

Widget termsRows() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon(
        Icons.check_circle,
        color: const Color(0xff38deb3),
        size: 30.h,
      ),
      SizedBox(
        width: 15.w,
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
        width: 300.w,
        child: const text14normal(
          text:
          "Lorem ipsum dolor sit amet consectetur Tristique a pharetra lacus sit.",
          color: Colors.black,
          align: TextAlign.start,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}

Widget termsButton() {
  return Container(
      margin: EdgeInsets.only(left: 29.w, right: 25.w),
      child: appButtons(
          buttonText: "Agree",
          buttonColor: AppColors.primaryElement,
          buttonTextColor: AppColors.primaryText,
          buttonBorderWidth: 2.h,
          anyWayDoor: () {
            navKey.currentState
                ?.pushNamedAndRemoveUntil('/delivery_prt_scr', (route) => false);
          }));
}

Widget termsContainer() {
  return Container(
    margin: EdgeInsets.fromLTRB(30.w, 10, 0, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: const text14normal(
            text:
            "Lorem ipsum dolor sit amet consectetur.         Tristique a pharetra lacus sit.",
            color: Color(0xff989799),
            align: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        termsRows(),
        SizedBox(
          height: 10.h,
        ),
        termsRows(),
        SizedBox(
          height: 10.h,
        ),
        termsRows(),
        SizedBox(
          height: 10.h,
        ),
        termsRows(),
        SizedBox(
          height: 10.h,
        ),
        termsRows(),
        SizedBox(
          height: 10.h,
        ),
      ],
    ),
  );
}
