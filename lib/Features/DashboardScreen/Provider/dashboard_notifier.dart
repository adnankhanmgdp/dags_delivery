import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_notifier.g.dart';

@riverpod
class DashBoardNotifier extends _$DashBoardNotifier{
  @override
  bool build() {
    return true;
  }

  void changeBool(bool value)
  {
    state=value;
  }
}
