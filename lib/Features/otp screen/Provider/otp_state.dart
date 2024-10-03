class OtpState {
  final String otp;

  ///CONSTRUCTOR
  const OtpState({this.otp = ""});

  ///Methode
  OtpState copyWith({String? otp}) {
    return OtpState(otp: otp ?? this.otp);
  }
}
