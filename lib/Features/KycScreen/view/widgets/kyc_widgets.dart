import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Common/widgets/text_widgets.dart';

Widget kycText() {
  return textcustomnormal(
    text: "KYC Verification",
    fontWeight: FontWeight.w500,
    fontSize: 36.w,
    color: const Color(0xff161416),
  );
}

Widget kycText02() {
  return Padding(padding: EdgeInsets.symmetric(horizontal: 10.h),
    child: text14normal(
      color: Colors.grey.shade500,
      text: "Please submit the following documents to verify your profile",
      fontWeight: FontWeight.w400,
    ),
  );
}

