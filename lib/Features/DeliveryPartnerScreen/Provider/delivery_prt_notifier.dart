import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'DeliveryPrtState.dart';

class DeliveryPrtNotifier extends StateNotifier<DeliveryPrtState>
{
  // Constructor
  DeliveryPrtNotifier():super(const DeliveryPrtState());

  void onUserNameChange(String name)
  {
    state=state.copyWith(userName: name);
  }
  void onUserEmailChange(String email)
  {
    state=state.copyWith(email: email);
  }
  void onUserPhoneNoChange(String phoneNo)
  {
    state=state.copyWith(phoneNo: phoneNo);
  }
}

final deliveryPrtNotifierProvider= StateNotifierProvider<DeliveryPrtNotifier,DeliveryPrtState>((ref) {
  return DeliveryPrtNotifier();
});
