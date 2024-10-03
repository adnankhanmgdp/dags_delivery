import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'applicationprovider.g.dart';

@riverpod
class ApplicationNotifier extends _$ApplicationNotifier{
  @override
  int build() {
    return 0;
  }

  void changeIndex(int value)
  {
    state=value;
  }
}
