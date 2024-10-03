import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Common/widgets/text_widgets.dart';

Widget helpHeadingText() {
  return SizedBox(
    width: 370.w,
    child: const textcustomnormal(
      align: TextAlign.start,
      fontWeight: FontWeight.w700,
      fontSize: 19,
      fontfamily: "Inter",
      text: "We’re here to help you with anything and everything on Dags",
      color: Colors.black,
    ),
  );
}
Widget helpDescText()
{
  return Container(
    width: 340.w,
    alignment: Alignment.center,
    child: const textcustomnormal(
      align: TextAlign.start,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      fontfamily: "Inter",
      text:
      "At Dags everyday we expect at a day’s start is you, better and happier than yesterday. We have got you covered. Share your concern or check our frequently asked questions listed below.",
      color: Colors.black,
    ),
  );
}

Widget faqText()
{
  return const textcustomnormal(
    fontSize: 18,
    fontfamily: "Inter",
    fontWeight: FontWeight.w700,
    text: "FAQ’s",
    color: Colors.black,
  );
}

