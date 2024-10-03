// order.dart
import 'package:flutter/cupertino.dart';

class Order {
  final String orderId;
  final double amount;
  final List<OrderStatus> orderStatus;
  final List<Item> items;
  final String? deliveryType;
  final List<dynamic> logisticId;

  Order(
      {required this.orderId,
      required this.amount,
      required this.orderStatus,
      required this.items,
      required this.deliveryType,
      required this.logisticId});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        amount: double.parse("${json['finalAmount']}" ?? '0'),
        orderId: json['orderId'] ?? '',
        orderStatus: (json['orderStatus'] as List? ?? [])
            .map((status) => OrderStatus.fromJson(status))
            .toList(),
        items: (json['items'] as List? ?? [])
            .map((item) => Item.fromJson(item))
            .toList(),
        deliveryType: json['deliveryType'] ?? '',
        logisticId: json['logisticId']);
  }
}

class OrderStatus {
  final String status;
  final String dateAndTime;

  OrderStatus({
    required this.status,
    required this.dateAndTime,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      status: json['status'] ?? '',
      dateAndTime: json['time'] ?? '',
    );
  }
}

class Item {
  final String serviceName;
  final String serviceId;
  final String itemName;
  final int quantity;

  Item({
    required this.serviceName,
    required this.serviceId,
    required this.itemName,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      serviceName: json['serviceNAME'] ?? '',
      serviceId: json['serviceId'] ?? '',
      itemName: json['itemNAME'] ?? '',
      quantity: json['qty'] ?? 0,
    );
  }
}

class GeoCoordinates {
  final String latitude;
  final String longitude;

  GeoCoordinates({
    required this.latitude,
    required this.longitude,
  });

  factory GeoCoordinates.fromJson(Map<String, dynamic> json) {
    return GeoCoordinates(
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  @override
  String toString() {
    return 'GeoCoordinates(latitude: $latitude, longitude: $longitude)';
  }
}

class Address {
  final List<String> addresses;

  Address({
    required this.addresses,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addresses: List<String>.from(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': addresses,
    };
  }
}
