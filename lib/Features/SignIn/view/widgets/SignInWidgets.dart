import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Common/utils/app_colors.dart';
import '../../../../Common/widgets/app_shadow.dart';
import '../../../../Common/widgets/app_text_fields.dart';
import '../../../../Common/widgets/text_widgets.dart';
import '../../../../main.dart';


Widget signInText()
{
  return textcustomnormal(
    text: "Sign In",
    fontWeight: FontWeight.w500,
    fontSize: 36.w,
    color: const Color(0xff161416),
  );
}
Widget signInText02()
{
  return text16normal(
    color: Colors.grey.shade500,
    text: "By entering your Phone No.",
    fontWeight: FontWeight.w400,
  );
}

Widget signInDetailBox({String hint=" ",required TextEditingController controller})
{
  return Container(
    decoration: appBoxDecoration(color:Colors.grey.shade200,radius: 10.w,borderColor: AppColors.primaryFourElementText,borderWidth: 1.0.h),
    child: textLoginBoxWithDimensions(hintText:hint,height:45.h ,width: 325.w),
  );
}

Widget registerText03() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const text16normal(
        text: "Don't have an account?",
        fontWeight: FontWeight.w400,
      ),
      SizedBox(
        width: 4.w,
      ),
      GestureDetector(
        onTap: () {
          navKey.currentState?.pushNamedAndRemoveUntil("/delivery_prt_scr", (route) => false);
        },
        child: const text16normal(
          text: "Sign Up",
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
