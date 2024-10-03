import 'dart:math';

import 'package:dags_delivery_app/Features/TransactionScreen/Provider/settlement_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';

class SettlementHistoryNotifier extends StateNotifier<SettlementHistory?> {
  SettlementHistoryNotifier() : super(null);

  Future<void> fetchSettlementHistory() async {
    try {
      final logisticId =
          Global.storageServices.getString(AppConstants.logisticId);
      final response = await http.post(
          Uri.parse('https://dagstechnology.in/logistic/api/settlement'),
          body: jsonEncode({'logisticId': logisticId}),
          headers: {'Content-Type': 'application/json; charset=utf-8'});
      // print(response.statusCode);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        state = SettlementHistory.fromJson(data);
      } else {
        state = null;
        throw Exception('Failed to load settlement history');
      }
    } catch (e) {
      if (kDebugMode) {
        print('error occurred while getting settlement history -> $e');
      }
    }
  }
}

final settlementHistoryProvider =
    StateNotifierProvider<SettlementHistoryNotifier, SettlementHistory?>((ref) {
  return SettlementHistoryNotifier();
});
