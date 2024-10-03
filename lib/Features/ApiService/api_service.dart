import 'dart:convert';
import 'dart:developer';
import 'package:dags_delivery_app/Common/Services/global.dart';
import 'package:dags_delivery_app/Common/utils/LogisticModel.dart';
import 'package:dags_delivery_app/Common/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../Common/utils/app_colors.dart';
import '../DashboardScreen/model/dashboard_model.dart';
import '../OrderDetailScreen/model/order_model.dart';
import 'misc_models.dart';

class ApiService {
  static const String baseUrl = "https://dagstechnology.in/logistic/api/";

  //useForRegisterScreen
  static Future<Map<String, dynamic>> sendOtp(
      String name, String email, String mobileNumber) async {
    // print(mobileNumber);
    const String url = "${baseUrl}signup";
    int retryCount = 0;
    const int maxRetries = 3;

    if (retryCount < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          },
          body:
              jsonEncode({'phone': mobileNumber, 'name': name, 'email': email}),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          if (responseData['success']) {
            return responseData;
          } else {
            throw Exception('Failed to send OTP: ${responseData['message']}');
            // throw NoInternetException("Some error occured");
          }
        } else if (response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: "User already exists.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.primaryElement,
              textColor: Colors.black,
              fontSize: 16.0);
          throw Exception('Failed to send OTP as user already exits.');
        } else {
          if (kDebugMode) {
            print("Error: ${response.statusCode} ${response.body}");
          }
          throw Exception('Failed to send OTP');
        }
      } catch (e) {
        if (kDebugMode) {
          print("Exception: $e");
        }
        retryCount++;
        if (retryCount == maxRetries) {
          throw Exception('Failed to send OTP after $maxRetries attempts');
        }
      }
    }
    throw Exception('Failed to send OTP');
  }

  //useForLoginScreen
  static Future<Map<String, dynamic>> login(String mobileNumber) async {
    const String url = "${baseUrl}login";
    int retryCount = 0;
    print("hello from login");
    const int maxRetries = 3;
    print(mobileNumber);
    if (retryCount < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          },
          body: jsonEncode({'phone': mobileNumber}),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          if (kDebugMode) {
            print(responseData);
          }
          if (responseData['success']) {
            return responseData;
          } else {
            throw Exception('Failed to send OTP: ${responseData['message']}');
          }
        } else if (response.statusCode == 404) {
          Fluttertoast.showToast(
              msg:
                  "Sorry we could not find any account with this number, Please register first.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.primaryElement,
              textColor: Colors.black,
              fontSize: 16.0);
        } else {
          if (kDebugMode) {
            print("Error: ${response.statusCode} ${response.body}");
          }
          throw Exception('Failed to send OTP');
        }
      } catch (e) {
        if (kDebugMode) {
          print("Exception: $e");
        }
        retryCount++;
        if (retryCount == maxRetries) {
          throw Exception('Failed to send OTP after $maxRetries attempts');
        }
      }
    }
    throw Exception('Failed to send OTP');
  }

// for verifying the OTP
  static Future<Map<String, dynamic>> verifyOtp(
      String mobileNumber, String otp) async {
    const String url = "${baseUrl}verifyOTP";
    int retryCount = 0;
    const int maxRetries = 3;

    if (retryCount < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          },
          body: jsonEncode({'phone': mobileNumber, 'otp': otp}),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          if (responseData['success'] == true) {
            if (kDebugMode) {
              print(responseData);
            }
            return responseData;
          } else {
            throw Exception('Failed to verify OTP: ${responseData['message']}');
          }
        } else {
          if (response.statusCode == 401) {
            Fluttertoast.showToast(
                msg: "Incorrect OTP! Try again.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: AppColors.primaryElement,
                textColor: Colors.black,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: "Could not verify OTP! Try again.",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: AppColors.primaryElement,
                textColor: Colors.black,
                fontSize: 16.0);
          }
          if (kDebugMode) {
            print("Error: ${response.statusCode} ${response.body}");
          }
          throw Exception('Failed to verify OTP');
        }
      } catch (e) {
        if (kDebugMode) {
          print("Exception: $e");
        }
        retryCount++;
        if (retryCount == maxRetries) {
          throw Exception('Failed to verify OTP after $maxRetries attempts');
        }
      }
    }
    throw Exception('Failed to verify OTP');
  }

  static Future<bool> sendOrderOtp(String orderId) async {
    const String url = "${baseUrl}deliveryOTP";
    try {
      final logisticId =
          Global.storageServices.getString(AppConstants.logisticId);
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
        },
        body: jsonEncode({'orderId': orderId, 'logisticId': logisticId}),
      );
      if (response.statusCode == 200) {
        print("Say hiii");
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['message'] == 'OTP send successfully') {
          final serverOtp = responseData['phoneOTP'];
          LogisticModel.serverOtp = serverOtp;
          Fluttertoast.showToast(
              msg: "A 4-digit delivery code has been sent to customer.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.primaryElement,
              textColor: Colors.black,
              fontSize: 16.0);
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception: $e");
      }
    }
    return false;
  }

  static Future<bool> confirmDelivery(String orderId, String userOtp) async {
    const String url = "${baseUrl}delivered";
    try {
      if (kDebugMode) {
        print('api has been hit.');
      }

      final otpStored = LogisticModel.serverOtp;
      if (kDebugMode) {
        print(otpStored);
      }
      final logisticId =
          Global.storageServices.getString(AppConstants.logisticId);
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
        },
        body: jsonEncode({
          'orderId': orderId,
          'logisticId': logisticId,
          'otp': userOtp,
          'otpStored': otpStored
        }),
      );
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['message'] == 'Order is Delivered Successfully') {
          Fluttertoast.showToast(
              msg: "Order has been delivered successfully.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.primaryElement,
              textColor: Colors.black,
              fontSize: 16.0);
          if (kDebugMode) {
            print(responseData);
          }
          return true;
        } else if (response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: "Entered OTP is invalid.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.primaryElement,
              textColor: Colors.black,
              fontSize: 16.0);
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception: $e");
      }
    }
    return false;
  }

  static Future<String> fetchLogisticProfile(String phoneNumber) async {
    try {
      Map<String, String> data = {'phone': phoneNumber};
      final response = await http.post(Uri.parse('${baseUrl}fetchProfile'),
          headers: {'Content-Type': 'application/json; charset=utf-8'},
          body: jsonEncode(data));
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (kDebugMode) {
          print("fetch vendor profile has been successfully  hit");
        }
        if (jsonResponse['logistic']['verificationStatus'] == 'active') {
          Global.storageServices.setString(
              AppConstants.logisticId, jsonResponse['logistic']['logisticId']);
          if (jsonResponse['logistic']['availability'] == true) {
            Global.storageServices
                .setBool(AppConstants.logisticAvailable, true);
          } else {
            Global.storageServices
                .setBool(AppConstants.logisticAvailable, false);
          }
        }
        return jsonResponse['logistic']['verificationStatus'];
      } else if (response.statusCode == 403) {
        return "notVerified";
      } else if (response.statusCode == 500) {
        throw Exception('Internal server error');
      } else {
        Fluttertoast.showToast(
            msg: "Account does not exists!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return "not exists";
      }
    } catch (e) {
      throw Exception('Failed to get verification Status: $e');
    }
  }

  //use for fetchProfile
  // static Future<Map<String, dynamic>> fetchProfile(String mobileNumber) async {
  //   const String url = "${baseUrl}fetchProfile";
  //   int retryCount = 0;
  //   const int maxRetries = 3;
  //
  //   while (retryCount < maxRetries) {
  //     try {
  //       final response = await http.post(
  //         Uri.parse(url),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Accept-Encoding': 'gzip, deflate, br',
  //           'Connection': 'keep-alive',
  //         },
  //         body: jsonEncode({'phone': mobileNumber}),
  //       );
  //
  //       if (response.statusCode == 200) {
  //         final Map<String, dynamic> responseData = jsonDecode(response.body);
  //         if (responseData['message'] == "Profile fetched successfully") {
  //           if (kDebugMode) {
  //             print(
  //               'Fetch Profile API Response: $responseData');
  //           }
  //           Global.storageServices.setString(AppConstants.userStatus, responseData['logistic']['verificationStatus']);
  //           LogisticModel.logisticId = responseData['logistic']['logisticId'];
  //           return responseData['logistic'];
  //         } else {
  //           throw Exception(
  //               'Failed to fetch profile: ${responseData['message']}');
  //         }
  //       } else {
  //         if (kDebugMode) {
  //           print("Error: ${response.statusCode} ${response.body}");
  //         }
  //         throw Exception('Failed to fetch profile');
  //       }
  //     } catch (e) {
  //       // Log or handle the exception
  //       if (kDebugMode) {
  //         print("Exception: $e");
  //       }
  //       retryCount++;
  //       if (retryCount == maxRetries) {
  //         throw Exception('Failed to fetch profile after $maxRetries attempts');
  //       }
  //       // You may add a delay here if needed before retrying
  //     }
  //   }
  //   throw Exception('Failed to fetch profile');
  // }

  // Profile Pic Upload
  static Future<bool> uploadPic(String mobileNumber, String profilePic) async {
    const String url = "${baseUrl}updateProfile";
    int retryCount = 0;
    const int maxRetries = 3;

    if (retryCount < maxRetries) {
      try {
        final response = await http.put(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          },
          body: jsonEncode({
            'phone': mobileNumber,
            'docs': profilePic,
          }),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          if (responseData['message'] == "Logistic Updated successfully") {
            return true;
          } else {
            return false;
          }
        } else {
          log("Error: ${response.statusCode} ${response.body}");
          return false;
        }
      } catch (e) {
        log("Exception: $e");
        return false;
      }
    }
    throw Exception('Failed to upload document');
  }

// Document Upload
  static Future<bool> uploadDocs(
      String mobileNumber, String document, String docType) async {
    const String url = "${baseUrl}updateDocs";
    int retryCount = 0;
    const int maxRetries = 3;

    if (retryCount < maxRetries) {
      try {
        final response = await http.put(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          },
          body: jsonEncode(
              {'phone': mobileNumber, 'docs': document, 'docType': docType}),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          if (responseData['message'] == "Logistic Updated successfully") {
            return true;
          } else {
            return false;
          }
        } else {
          log("Error: ${response.statusCode} ${response.body}");
          return false;
        }
      } catch (e) {
        log("Exception: $e");
        return false;
      }
    }
    throw Exception('Failed to upload document');
  }

//getOrderAPI for location
  static Future<Map<String, dynamic>> getOrder(
      String logisticId, String orderId) async {
    const String url = "${baseUrl}getOrder";

    try {
      final response = await http.post(Uri.parse(url), body: {
        'logisticId': logisticId,
        'orderId': orderId,
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch order: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch order: $e');
    }
  }

  //dashboard Api
  static Future<Map<String, dynamic>> dashboardDataFetch(
      String logisticId) async {
    const String url = "${baseUrl}dashboardDataFetch";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'logisticId': logisticId}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        log("$data");
        return data;
      } else {
        throw Exception(
            'Failed to fetch dashboard data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch dashboard data: $e');
    }
  }

  static Future<Charges> fetchCharges() async {
    try {
      final response = await http
          .get(Uri.parse('https://dagstechnology.in/admin/api/fetchMisc'));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("fetch charges has been successfully hit");
        }
        return Charges.fromJson(jsonDecode(response.body)['charges']);
      } else if (response.statusCode == 404) {
        throw Exception('Resource not found');
      } else if (response.statusCode == 500) {
        throw Exception('Internal server error');
      } else {
        throw Exception(
            'Failed to load charges with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load charges: $e');
    }
  }

  // Fetch All Active Orders
  static Future<List<Order>> activeOrders() async {
    const String url = "${baseUrl}fetchActiveOrders";
    try {
      if (kDebugMode) {
        print(Global.storageServices.getString(AppConstants.logisticId));
      }
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
        },
        body: jsonEncode({
          'logisticId':
              Global.storageServices.getString(AppConstants.logisticId),
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<Order> activeOrders = (responseData['activeOrders'] as List)
            .map((order) => Order.fromJson(order))
            .toList();
        return activeOrders;
      } else {
        log("Error: ${response.statusCode} ${response.body}");
        throw Exception('Failed to Fetch Active Orders');
      }
    } catch (e) {
      log("Exception: $e");
    }
    throw Exception('Failed to Fetch Active Orders');
  }

  // Fetch All Past Orders
  static Future<List<Order>> pastOrders() async {
    const String url = "${baseUrl}pastOrders";
    int retryCount = 0;
    const int maxRetries = 3;

    if (retryCount < maxRetries) {
      try {
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          },
          body: jsonEncode({
            'logisticId':
                Global.storageServices.getString(AppConstants.logisticId),
          }),
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final List<Order> pastOrders = (responseData['pastOrders'] as List)
              .map((order) => Order.fromJson(order))
              .toList();
          return pastOrders;
        } else {
          log("Error: ${response.statusCode} ${response.body}");
          throw Exception('Failed to Fetch Past Orders');
        }
      } catch (e) {
        log("Exception: $e");
        retryCount++;
        if (retryCount == maxRetries) {
          throw Exception(
              'Failed to Fetch Past Orders after $maxRetries attempts');
        }
      }
    }
    throw Exception('Failed to Fetch Past Orders');
  }

  // Fetch to Get GeoCoordinates of an Order
  static Future<List<dynamic>?> fetchGeoCoordinates() async {
    const String url = "${baseUrl}getOrder";
    int retryCount = 0;
    const int maxRetries = 3;

    try {
      final logisticId =
          Global.storageServices.getString(AppConstants.logisticId);
      final String orderId = LogisticModel.orderId;
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
        },
        body: jsonEncode({
          'logisticId': logisticId,
          'orderId': orderId,
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        Map<String, dynamic> user = responseData['user'];
        Map<String, dynamic> order = responseData['order'];
        Map<String, dynamic> vendor = responseData['vendor'];
        final userGeoCoordinatesJson = user['geoCoordinates'];
        final vendorGeoCoordinatesJson = vendor['geoCoordinates'];
        final GeoCoordinates userLocation =
            GeoCoordinates.fromJson(userGeoCoordinatesJson);
        final GeoCoordinates vendorLocation =
            GeoCoordinates.fromJson(vendorGeoCoordinatesJson);
        final List<dynamic> resultList = [];
        resultList.add(userLocation);
        resultList.add(vendorLocation);
        resultList.add(user);
        resultList.add(vendor);
        resultList.add(order);
        return resultList;
      } else {
        log("Error: ${response.statusCode} ${response.body}");
        return null;
      }
    } catch (e) {
      log("Exception: $e");
      return null;
    }
  }

  // Fetch DashBoard
  static Future<TodaySummary> dashboard() async {
    const String url = "${baseUrl}dashboard";
    int retryCount = 0;
    const int maxRetries = 3;
    if (retryCount < maxRetries) {
      try {
        final logisticId =
            Global.storageServices.getString(AppConstants.logisticId);
        final response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
          },
          body: jsonEncode({
            'logisticId': logisticId,
          }),
        );

        if (response.statusCode == 200) {
          Map<String, dynamic> responseData = jsonDecode(response.body);
          if (kDebugMode) print(responseData);
          return TodaySummary.fromJson(responseData);
        } else {
          log("Error: ${response.statusCode} ${response.body}");
          throw Exception('Failed to Fetch Dashboard Location');
        }
      } catch (e) {
        log("Exception: $e");
        retryCount++;
        if (retryCount == maxRetries) {
          // throw Exception(
          // 'Failed to Fetch Dashboard after $maxRetries attempts');
        }
      }
    }
    throw Exception('Failed to Fetch Dashboard');
  }

  static Future<bool> pickingUpFromUser(
      String orderId, String secretKey) async {
    const String url = "${baseUrl}pickedUp";
    try {
      final logisticId =
          Global.storageServices.getString(AppConstants.logisticId);
      if (kDebugMode) {
        print(logisticId);
      }
      if (kDebugMode) {
        print(orderId);
      }
      if (kDebugMode) {
        print(secretKey);
      }
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
        },
        body: jsonEncode({
          'logisticId': logisticId,
          'orderId': orderId,
          'secretKey': secretKey
        }),
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Order picked up successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return true;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
            msg: "Order has been picked earlier.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return false;
      } else {
        Fluttertoast.showToast(
            msg: "Order could not be picked, please try again.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return false;
      }
    } catch (e) {
      log("Exception: $e");
      return false;
    }
  }

  static Future<bool> pickingUpFromVendor(
      String orderId, String secretKey) async {
    const String url = "${baseUrl}outOfDelivery";
    try {
      final logisticId =
          Global.storageServices.getString(AppConstants.logisticId);
      if (kDebugMode) {
        print(logisticId);
      }
      if (kDebugMode) {
        print(orderId);
      }
      if (kDebugMode) {
        print(secretKey);
      }
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
        },
        body: jsonEncode({
          'logisticId': logisticId,
          'orderId': orderId,
          'secretKey': secretKey
        }),
      );
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Order picked up successfully.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return true;
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
            msg: "Order has been picked earlier.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return false;
      } else {
        Fluttertoast.showToast(
            msg: "Order could not be picked, please try again.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.primaryElement,
            textColor: Colors.black,
            fontSize: 16.0);
        return false;
      }
    } catch (e) {
      log("Exception: $e");
      return false;
    }
  }

  static Future<bool> trackLocation(
      String latitude, String longitude, String logisticId) async {
    const String url = "${baseUrl}trackLocation";
    try {
      final logisticId =
          Global.storageServices.getString(AppConstants.logisticId);
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
        },
        body: jsonEncode({
          'logisticId': logisticId,
          'latitude': latitude,
          'longitude': longitude
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Exception: $e");
      return false;
    }
  }

  static Future<bool> switchAvailability(String logisticId) async {
    const String url = "${baseUrl}switchAvailability";
    try {
      final logisticId =
          Global.storageServices.getString(AppConstants.logisticId);
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'Connection': 'keep-alive',
        },
        body: jsonEncode({
          'logisticId': logisticId,
        }),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Exception: $e");
      return false;
    }
  }
}
