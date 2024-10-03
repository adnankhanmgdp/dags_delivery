import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_otp_state.dart';


class OtpOrderNotifier extends StateNotifier<OtpOrderState>
{
  // Constructor
  OtpOrderNotifier():super(const OtpOrderState());

  void onUserOtpInput(String otp)
  {
    state=state.copyWith(otp: otp);
  }
}

final otpOrderNotifierProvider= StateNotifierProvider<OtpOrderNotifier,OtpOrderState>((ref) {
  return OtpOrderNotifier();
});
