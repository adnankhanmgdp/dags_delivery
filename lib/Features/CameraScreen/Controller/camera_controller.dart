import 'dart:developer';

import 'package:dags_delivery_app/Features/ApiService/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';
import '../../../main.dart';

class CameraController {
  late WidgetRef ref;

  CameraController({required this.ref});

  Future<void> uploadProfilePic(String profilePic) async {
    final phoneNumber =
        Global.storageServices.getString(AppConstants.userNumber);
    try {
      final response = await ApiService.uploadPic(phoneNumber, profilePic);
      if (response) {
        Global.storageServices.setBool(AppConstants.isImageDone, true);
        navKey.currentState
            ?.pushNamedAndRemoveUntil('/kyc_scr', (route) => false);
      }
    } catch (e) {
      log('Failed to upload profile picture:$e');
    }
  }
}
