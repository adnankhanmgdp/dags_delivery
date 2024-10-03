class TodaySummary {
  dynamic totalAmountToday;
  dynamic totalCompletedOrders;
  dynamic totalDistanceToday;
  dynamic ordersToPic;
  dynamic ordersToDeliver;
  dynamic totalOrdersPicked;
  dynamic totalOrdersDelivered;

  //     "totalOrders": 0,
  //     "ordersToPickup": 1,
  //     "totalTodayOrdersPicked": 0,
  //     "ordersToDelivered": 1,
  //     "totalTodayOrdersDelivered": 0,
  //     "todaysEarning": 0,
  //     "distance": 0
  TodaySummary({
    required this.totalAmountToday,
    required this.totalCompletedOrders,
    required this.totalDistanceToday,
    required this.ordersToPic,
    required this.ordersToDeliver,
    required this.totalOrdersDelivered,
    required this.totalOrdersPicked,
  });

  factory TodaySummary.fromJson(Map<String, dynamic> json) {
    return TodaySummary(
      totalAmountToday: json['todaysEarning'] ?? '',
      totalCompletedOrders: json['totalOrders'] ?? '',
      totalDistanceToday: json['distance'] ?? '',
      ordersToPic: json['ordersToPickup'] ?? '',
      ordersToDeliver: json['ordersToDelivered'] ?? '',
      totalOrdersPicked: json['totalTodayOrdersPicked']?? '',
      totalOrdersDelivered: json['totalTodayOrdersDelivered']?? '',
    );
  }
}
