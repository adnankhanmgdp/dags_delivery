import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'otp_state.dart';


class OtpNotifier extends StateNotifier<OtpState>
{
  // Constructor
  OtpNotifier():super(const OtpState());

  void onUserOtpInput(String otp)
  {
    state=state.copyWith(otp: otp);
  }
}

final otpNotifierProvider= StateNotifierProvider<OtpNotifier,OtpState>((ref) {
  return OtpNotifier();
});
