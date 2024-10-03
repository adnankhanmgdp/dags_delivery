import 'package:dags_delivery_app/Features/ApiService/api_service.dart';
import 'package:dags_delivery_app/Features/DeliveryPartnerScreen/view/delivery_prt_scr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';
import '../../../main.dart';

class ProofController {
  late WidgetRef ref;

  ProofController({required this.ref});

  Future<void> uploadDocuments(String documentImage,String docType) async {
    final phoneNumber = Global.storageServices.getString(AppConstants.userNumber);
    var response = await ApiService.uploadDocs(phoneNumber,documentImage,docType);
    if(response) {
      Global.storageServices.setBool(AppConstants.isDocumentDone, true);
      ///going back to the kyc screen
      navKey.currentState?.pushNamedAndRemoveUntil('/kyc_scr',(route) => false);
    } else {
      if (kDebugMode) {
        print("some error occurred while adding pictures to the backend");
      }
    }
  }

}