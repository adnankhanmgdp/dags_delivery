import 'package:flutter/foundation.dart';

class LogisticResponse {
  String message;
  Logistic logistic;
  BankDetails bankDetails;

  LogisticResponse({required this.message, required this.logistic,required this.bankDetails});

  factory LogisticResponse.fromJson(Map<String, dynamic> json) {
    return LogisticResponse(
      message: json['message'],
      logistic: Logistic.fromJson(json['logistic']),
      bankDetails:  BankDetails.fromJson(json['bankDetails'])
    );
  }
}
class Logistic {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic profilePic;
  dynamic otp;
  dynamic verificationStatus;
  dynamic currentActiveOrder;
  dynamic capacity;
  dynamic availability;
  dynamic status;
  List<dynamic> orders;
  List<dynamic> locationLog;
  List<dynamic> ip;
  List<dynamic> activeLog;
  dynamic logisticId;
  dynamic lastLogin;
  dynamic document;


  Logistic({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profilePic,
    this.otp,
    this.verificationStatus,
    this.currentActiveOrder,
    this.capacity,
    this.availability,
    this.status,
    required this.orders,
    required this.locationLog,
    required this.ip,
    required this.activeLog,
    this.logisticId,
    this.lastLogin,
    this.document,

  });

  factory Logistic.fromJson(Map<String, dynamic> json) {
    return Logistic(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profilePic: json['profilePic'],
      otp: json['OTP'],
      verificationStatus: json['verificationStatus'],
      currentActiveOrder: json['currentActiveOrder'],
      capacity: json['capacity'],
      availability: json['availability'],
      status: json['status'],
      orders: json['orders'] ?? [],
      locationLog: json['locationLog'] ?? [],
      ip: json['ip'] ?? [],
      activeLog: json['activeLog'] ?? [],
      logisticId: json['logisticId'],
      lastLogin: json['lastLogin'],
      document: json['document'],
    );
  }
}

class BankDetails {
  dynamic accountHolderName;
  dynamic bankName;
  dynamic accountNumber;
  dynamic ifsc;
  dynamic branch;

  BankDetails(
      {required this.accountHolderName,
        required this.bankName,
        required this.branch,
        required this.ifsc,
        required this.accountNumber});

  factory BankDetails.fromJson(dynamic json) {
    if (kDebugMode) {
      print(json);
    }
    if (json != null) {
      return BankDetails(
        accountHolderName: json['accountHolderName'] ?? '',
        bankName: json['bankName'] ?? '',
        accountNumber: json['accountNumber'] ?? '',
        ifsc: json['IFSC'] ?? '',
        branch: json['branch'] ?? '',
      );
    } else {
      return BankDetails(
        accountHolderName: '',
        bankName: '',
        accountNumber: '',
        ifsc: '',
        branch: '',
      );
    }
  }
}