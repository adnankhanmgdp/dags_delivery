class DeliveryPrtState {
  final String userName;
  final String email;
  final String phoneNo;

  ///CONSTRUCTOR
  const DeliveryPrtState(
      {this.userName = "",
        this.email = "",
        this.phoneNo = ""});

  ///Methode
  DeliveryPrtState copyWith(
      {String? userName,
        String? email,
        String? phoneNo}) {
    return DeliveryPrtState(
        userName: userName ?? this.userName,
        email: email ?? this.email,
        phoneNo: phoneNo ?? this.phoneNo);
  }
}
