class OtpOrderState {
  final String otp;

  ///CONSTRUCTOR
  const OtpOrderState({this.otp = ""});

  ///Methode
  OtpOrderState copyWith({String? otp}) {
    return OtpOrderState(otp: otp ?? this.otp);
  }
}
