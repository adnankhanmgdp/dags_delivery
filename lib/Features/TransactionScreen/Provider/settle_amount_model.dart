class SettlementData {
  final int dueSettlementOnPickup;
  final int totalSettlementOnPickup;
  final int amountEarnedOnPickup;
  final int dueSettlementOnDelivery;
  final int totalSettlementOnDelivery;
  final int amountEarnedOnDelivery;

  SettlementData({
    required this.dueSettlementOnPickup,
    required this.totalSettlementOnPickup,
    required this.amountEarnedOnPickup,
    required this.dueSettlementOnDelivery,
    required this.totalSettlementOnDelivery,
    required this.amountEarnedOnDelivery,
  });

  factory SettlementData.fromJson(Map<String, dynamic> json) {
    return SettlementData(
      dueSettlementOnPickup: json['dueSettlementOnPickup'],
      totalSettlementOnPickup: json['totalSettlementOnPickup'],
      amountEarnedOnPickup: json['amountEarnedOnPickup'],
      dueSettlementOnDelivery: json['dueSettlementOnDelivery'],
      totalSettlementOnDelivery: json['totalSettlementOnDelivery'],
      amountEarnedOnDelivery: json['amountEarnedOnDelivery'],
    );
  }
}
