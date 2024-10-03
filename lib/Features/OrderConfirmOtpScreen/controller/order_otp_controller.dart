import 'package:dags_delivery_app/Common/utils/app_colors.dart';
import 'package:dags_delivery_app/Features/ApiService/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../main.dart';
import '../Provider/order_otp_notifier.dart';

class OrderOtpController {
  Future<void> handleOtp(WidgetRef ref, String orderId) async {
    var state = ref.watch(otpOrderNotifierProvider);
    var otp = state.otp;
    final response = await ApiService.confirmDelivery(orderId, otp);
    if (response) {
      if (kDebugMode) {
        print('order delivered successfully.');
      }
      navKey.currentState
          ?.pushNamedAndRemoveUntil('/order_det_scr', (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: "Incorrect OTP! Try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.primaryElement,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }
}
