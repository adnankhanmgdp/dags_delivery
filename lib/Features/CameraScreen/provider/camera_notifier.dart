import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera_notifier.g.dart';


@Riverpod(keepAlive: true)
class CameraNotifier extends _$CameraNotifier {

  @override
  bool build() {
    return false;
  }

  void changeState(bool value)
  {
    state=value;
  }
}
