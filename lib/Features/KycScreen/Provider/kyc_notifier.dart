import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyc_notifier.g.dart';

@Riverpod(keepAlive: true)
class kycNotifier extends _$kycNotifier {

  @override
  int build() {
    return 0;
  }

  void changeState(int value)
  {
    state=value;
  }

}
