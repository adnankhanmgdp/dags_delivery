class SettlementHistory {
  final String message;
  final List<History> history;


  SettlementHistory({
    required this.message,
    required this.history,
  });

  factory SettlementHistory.fromJson(Map<String, dynamic> json) {
    return SettlementHistory(
      message: json['message'],
      history: (json['history'] as List)
          .map((historyItem) => History.fromJson(historyItem))
          .toList(),
    );
  }
}

class History {
  final String id;
  final String orderId;
  final dynamic amount;
  final List<String> orderIds;
  final DateTime date;

  History({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.orderIds,
    required this.date,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['_id'],
      orderId: json['Id'],
      amount: json['amount'].toDouble(),
      orderIds: List<String>.from(json['orderIds']),
      date: DateTime.parse(json['date']),
    );
  }
}

