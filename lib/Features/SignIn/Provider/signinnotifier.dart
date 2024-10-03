import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'signinstate.dart';

class SignInNotifier extends StateNotifier<SignInState>
{
  // Constructor
  SignInNotifier():super(const SignInState());

  void onUserPhoneNoChange(String phoneNo)
  {
    state=state.copyWith(phoneNo: phoneNo);
  }
}

final SignInNotifierProvider= StateNotifierProvider<SignInNotifier,SignInState>((ref) {
  return SignInNotifier();
});
