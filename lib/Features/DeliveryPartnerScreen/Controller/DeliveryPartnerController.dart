import 'package:dags_delivery_app/Features/DeliveryPartnerScreen/Provider/delivery_prt_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Common/Services/global.dart';
import '../../../Common/utils/app_colors.dart';
import '../../../Common/utils/constants.dart';
import '../../../main.dart';
import '../../ApiService/api_service.dart';

class DeliveryPartnerController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  Future<void> registerUser(WidgetRef ref) async {
    final state = ref.watch(deliveryPrtNotifierProvider);
    final name = state.userName;
    final email = state.email;
    final mobileNumber = state.phoneNo;
    try {
      if (name.isNotEmpty && email.isNotEmpty && mobileNumber.isNotEmpty) {
        final response = await ApiService.sendOtp(name, email, mobileNumber);
        if (response.containsKey('success') && response['success'] == true) {
          if (kDebugMode) {
            print('Registration successful');
          }
          Global.storageServices.setString(AppConstants.userName, name);
          Global.storageServices.setString(AppConstants.userEmail, email);
          Global.storageServices
              .setString(AppConstants.userNumber, mobileNumber);
          navKey.currentState
              ?.pushNamed("/otp_scr", arguments: {"fromLogin": false});
        } else {
          if (kDebugMode) {
            print("Registration is unsuccessful.");
          }
        }
      }
    } catch (e) {
      // Handle error, e.g., show error message to the user
      if (kDebugMode) {
        print('Failed to send OTP: $e');
      }
      // Fluttertoast.showToast(
      //   msg: "User could not be Registered",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: AppColors.primaryElement,
      //   textColor: Colors.white,
      // );
    }
  }
}
