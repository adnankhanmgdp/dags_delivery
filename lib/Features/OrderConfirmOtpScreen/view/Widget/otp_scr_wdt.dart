import 'package:dags_delivery_app/Common/Services/global.dart';
import 'package:dags_delivery_app/Common/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Common/utils/app_colors.dart';
import '../../../../../Common/widgets/app_button_widgets.dart';
import '../../../../../Common/widgets/app_shadow.dart';
import '../../../../../Common/widgets/app_text_fields.dart';
import '../../../../../Common/widgets/text_widgets.dart';
import '../../controller/order_otp_controller.dart';

Widget otpOrderText() {
  return textcustomnormal(
    text: "OTP Verification",
    fontWeight: FontWeight.w500,
    fontSize: 36.w,
    color: const Color(0xff161416),
  );
}

Widget otpOrderText02(String? phone) {
  // String? phone = Global.storageServices.getString(AppConstants.userNumber);

  return text14normal(
    color: Colors.grey.shade500,
    text: "Please enter the 4-digit delivery code sent to +91$phone",
    fontWeight: FontWeight.w400,
  );
}

Widget otpOrderBoxes() {
  return Container(
    decoration: appBoxDecoration(
        color: Colors.grey.shade200,
        radius: 4.w,
        borderColor: AppColors.primaryFourElementText,
        borderWidth: 1.0.h),
    child: textLoginBoxWithDimensions(hintText: "3", height: 40.h, width: 40.w),
  );
}

Widget verifyOrderButton(
    WidgetRef ref, OrderOtpController controller, String orderId) {
  return Container(
      margin: EdgeInsets.only(left: 29.w, right: 25.w),
      child: appButtons(
          buttonText: "Verify",
          buttonColor: AppColors.primaryElement,
          buttonTextColor: AppColors.primaryText,
          buttonBorderWidth: 2.h,
          anyWayDoor: () async {
            if (kDebugMode) {
              print('button has been pressed');
            }
            await controller.handleOtp(ref, orderId);
          }));
}

Widget otpOrderText03() {
  return const text16normal(
    text: "Didn’t receive any code?",
    fontWeight: FontWeight.w600,
  );
}
