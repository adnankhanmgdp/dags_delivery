import 'package:dags_delivery_app/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Common/utils/app_colors.dart';

import '../../../../Common/widgets/app_shadow.dart';
import '../../../../Common/widgets/app_text_fields.dart';
import '../../../../Common/widgets/text_widgets.dart';


Widget deliveryPartnerDetailBox(
    {String hint = " ", required TextEditingController controller}) {
  return Container(
    decoration: appBoxDecoration(
        color: Colors.grey.shade200,
        radius: 10.w,
        borderColor: AppColors.primaryFourElementText,
        borderWidth: 1.0.h),
    child:
    textLoginBoxWithDimensions(hintText: hint, height: 45.h, width: 325.w),
  );
}


Widget registerText() {
  return textcustomnormal(
    text: "Register",
    fontWeight: FontWeight.w500,
    fontSize: 36.w,
    color: const Color(0xff161416),
  );
}

Widget registerText02() {
  return text16normal(
    color: Colors.grey.shade500,
    text: "By entering your Details",
    fontWeight: FontWeight.w400,
  );
}

Widget registerText03(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const text16normal(
        text: "Already a member?",
        fontWeight: FontWeight.w400,
      ),
      SizedBox(
        width: 4.w,
      ),
      GestureDetector(
        onTap: () {
          navKey.currentState
              ?.pushNamedAndRemoveUntil('/login', (route) => false);
        },
        child: const text16normal(
          text: "Sign In",
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}

// void _sendOtp(WidgetRef ref, BuildContext context) async {
//   final state = ref.watch(deliveryPrtNotifierProvider);
//
//
//   try {
//     final response = await ApiService.sendOtp(name, email, mobileNumber);
//     if (response.containsKey('success') && response['success'] == true) {
//       if (kDebugMode) {
//         print('Registration successful');
//       }
//       Global.storageServices.setString(AppConstants.userName, name);
//       Global.storageServices.setString(AppConstants.userEmail, email);
//       Global.storageServices.setString(AppConstants.userNumber, mobileNumber);
//       Global.storageServices.setBool(AppConstants.userRegisteredEarlier, true);
//
//       // Ensure navigation occurs after the build phase
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         if (mounted) {
//           navKey.currentState
//               ?.pushNamed("/otp_scr", arguments: {"fromLogin": false});
//         }
//       });
//     } else {
//       if (kDebugMode) {
//         print("Registration is unsuccessful.");
//       }
//     }
//   } catch (e) {
//     // Handle error, e.g., show error message to the user
//     if (kDebugMode) {
//       print('Failed to send OTP: $e');
//     }
//     Fluttertoast.showToast(
//       msg: "User could not be Registered",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: AppColors.primaryElement,
//       textColor: Colors.white,
//     );
//   }
// }
