import 'dart:developer';

import 'package:dags_delivery_app/Common/utils/app_colors.dart';
import 'package:dags_delivery_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ApiService/api_service.dart';

Widget bottomCard(
    BuildContext context,
    bool reachedPickupLocation,
    Function() onPressed,
    LatLng? coordinates,
    Map<String, dynamic> user,
    Map<String, dynamic> vendor,
    String orderId,
    String orderStatus,
    String orderLocation) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.all(16),
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  (orderStatus == "readyToPickup" ||
                          orderStatus == "outOfDelivery")
                      ? user['name']
                      : (orderStatus == "pickedUp" ||
                              orderStatus == "readyToDelivery")
                          ? vendor['name']
                          : user['name'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse("tel: 0" +
                            ((orderStatus == "readyToPickup" ||
                                    orderStatus == "outOfDelivery")
                                ? user['phone']
                                : (orderStatus == "pickedUp" ||
                                        orderStatus == "readyToDelivery")
                                    ? vendor['phone']
                                    : user['phone'])));
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey.shade300,
                        child: const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.phone,
                            color: Color(0xffFFCC57),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () async {
                        final url = Uri.parse(
                            'google.navigation:q=${coordinates!.latitude},${coordinates.longitude}');
                        await launch(url.toString());
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey.shade300,
                        child: const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              "https://dagstechnology.in/uploads/important/google-map.jpg",
                              scale: 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            (orderStatus == "readyToPickup" || orderStatus == "outOfDelivery")
                ? "laundry: ${vendor['name']}"
                : (orderStatus == "pickedUp" ||
                        orderStatus == "readyToDelivery")
                    ? "laundry: ${user['name']}"
                    : "laundry: ${vendor['name']}",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(height: 20, thickness: 1, color: Colors.grey),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_pin, color: Colors.red),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  (orderStatus == "readyToPickup" ||
                          orderStatus == "outOfDelivery")
                      ? "${orderLocation}"
                      : (orderStatus == "pickedUp" ||
                              orderStatus == "readyToDelivery")
                          ? "${vendor['address']}"
                          : "${orderLocation}",
                  style: TextStyle(
                    color: Color(0xff1C254E),
                    fontSize: 16,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          (orderStatus == 'readyToDelivery' ||
                  orderStatus == "readyToPickup" ||
                  orderStatus == "outOfDelivery")
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: const Color(0xffFFCC57),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        log(orderStatus);
                        if (orderStatus == 'outOfDelivery') {
                          var response = await ApiService.sendOrderOtp(orderId);
                          if (response) {
                            navKey.currentState?.pushNamed('/order_otp_scr',
                                arguments: {
                                  'orderId': orderId,
                                  'phone': user['phone']
                                });
                          }
                        } else {
                          navKey.currentState?.pushNamed('/scan_scr',
                              arguments: {
                                'orderId': orderId,
                                'orderStatus': orderStatus
                              });
                        }
                        // if (reachedPickupLocation) {
                        //
                        // }
                        // } else {
                        //   if (kDebugMode) {
                        //     print('delivery partner is not at the user location');
                        //   }
                        //   Fluttertoast.showToast(
                        //       msg: "Please enter valid phone number.",
                        //       toastLength: Toast.LENGTH_SHORT,
                        //       gravity: ToastGravity.BOTTOM,
                        //       timeInSecForIosWeb: 1,
                        //       backgroundColor: AppColors.primaryElement,
                        //       textColor: Colors.white,
                        //       fontSize: 16.0);
                        //   onPressed();
                        // }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.black,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            (orderStatus == 'outOfDelivery')
                                ? "Confirm Delivery"
                                : "Reached Pickup Location",
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    ),
  );
}
