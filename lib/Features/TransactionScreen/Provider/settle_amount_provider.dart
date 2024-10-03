import 'package:dags_delivery_app/Common/utils/constants.dart';
import 'package:dags_delivery_app/Features/TransactionScreen/Provider/settle_amount_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Common/Services/global.dart';

class SettlementNotifier extends StateNotifier<SettlementData?> {
  SettlementNotifier() : super(null);

  Future<void> fetchSettlementData() async {
    try {
      final logisticId =
          Global.storageServices.getString(AppConstants.logisticId);
      final response = await http.post(
          Uri.parse('https://dagstechnology.in/logistic/api/calculateAmount'),
          body: jsonEncode({'logisticId': logisticId}),
          headers: {'Content-Type': 'application/json; charset=utf-8'});
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        state = SettlementData.fromJson(data);
        // print(response.body);
      } else {
        throw Exception('Failed to load settlement data');
      }
    } catch (e) {
      // Handle the error appropriately here
      if (kDebugMode) {
        print(e);
      }
    }
  }
}

final settlementProvider =
    StateNotifierProvider<SettlementNotifier, SettlementData?>((ref) {
  return SettlementNotifier();
});
