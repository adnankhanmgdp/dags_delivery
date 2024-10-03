
import 'package:dags_delivery_app/Features/ProfileScreen/provider/logistic_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';

// Define the Notifier
class LogisticNotifier extends StateNotifier<LogisticResponse?> {
  LogisticNotifier() : super(null) {
    fetchLogisticProfile();
  }

  final url = AppConstants.serverApiUrl;

  Future<void> fetchLogisticProfile() async {
    try {
      final vendorId = Global.storageServices.getString(AppConstants.logisticId);
      final phoneNumber =
      Global.storageServices.getString(AppConstants.userNumber);
      Map<String, dynamic> data = {'phone': phoneNumber, 'vendorId': vendorId};
      final response = await http.post(
          Uri.parse('https://dagstechnology.in/logistic/api/fetchProfile'),
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(data));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final logistic = LogisticResponse.fromJson(responseData);
        state = logistic;
      } else {
        if (kDebugMode) {
          print("Error occurred while fetching vendor profile");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("error while fetching profile is-> $e");
      }
    }
  }
}

// Define the provider
final logisticProvider = StateNotifierProvider<LogisticNotifier, LogisticResponse?>((ref) {
  return LogisticNotifier();
});
