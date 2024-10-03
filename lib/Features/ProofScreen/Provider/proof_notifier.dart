import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'proof_notifier.g.dart';

@Riverpod(keepAlive: true)
class ProofNotifier extends _$ProofNotifier {

  @override
  int build() {
    return 0;
  }

  void changeState(int value)
  {
    state=value;
  }

}
