import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_notifier.g.dart';

@riverpod
class MapNotifier extends _$MapNotifier{
  @override
  bool build() {
    return true;
  }

  void changeBool(bool value)
  {
    state=value;
  }
}
