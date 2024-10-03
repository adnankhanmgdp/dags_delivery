class SignInState {
  final String phoneNo;

  ///CONSTRUCTOR
  const SignInState({this.phoneNo = ""});

  ///Methode
  SignInState copyWith({String? phoneNo}) {
    return SignInState(phoneNo: phoneNo ?? this.phoneNo);
  }
}
