import 'dart:developer';
import 'package:dags_delivery_app/Common/Services/global.dart';
import 'package:dags_delivery_app/Common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../../ApiService/api_service.dart';
import '../model/order_model.dart';

class PastOrders extends StatefulWidget {
  const PastOrders({super.key, required this.lastOrderNumbers});

  final String lastOrderNumbers;

  @override
  State<PastOrders> createState() => _PastOrdersState();
}

class _PastOrdersState extends State<PastOrders> {
  final ApiService apiService = ApiService();
  List<Order> orders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPastOrders();
  }

  void fetchPastOrders() async {
    try {
      orders = await ApiService.pastOrders();
      log('Fetched orders: $orders');
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      log("Failed to fetch orders: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatDate(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return DateFormat("E, d'th' MMMM yyyy h:mm a").format(dateTime);
  }

  String setCorrectGrammer(String status) {
    String corrected = '';
    switch (status) {
      case 'pending':
        {
          corrected = "Pending";
        }
        break;
      case 'initiated':
        {
          corrected = "Initiated";
        }
        break;
      case 'readyToPickup':
        {
          corrected = "Ready To Pickup";
        }
        break;
      case 'pickedUp':
        {
          corrected = "Picked Up";
        }
        break;
      case 'readyForDelivery':
        {
          corrected = "Ready For Delivery";
        }
        break;
      case 'outOfDelivery':
        {
          corrected = "Out For Delivery";
        }
        break;
      case 'outOfDelivery':
        {
          corrected = "Out For Delivery";
        }
        break;
      case 'delivered':
        {
          corrected = "Delivered";
        }
        break;
      case 'cancelled':
        {
          corrected = "Cancelled";
        }
        break;
      case 'refunded':
        {
          corrected = "Refunded";
        }
        break;
      case 'cleaning':
        {
          corrected = "Laundry In Progress";
        }
      default:
        {
          corrected = " ";
        }
        break;
    }
    return corrected;
  }

  @override
  Widget build(BuildContext context) {
    List<Order> filteredOrders = widget.lastOrderNumbers.isEmpty
        ? orders
        : orders.where((order) {
            String orderIdStr = order.orderId.toString();
            return orderIdStr.endsWith(widget.lastOrderNumbers);
          }).toList();
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? const Center(
                  child: textcustomnormal(
                  text: "No past orders available",
                  fontSize: 20,
                  fontfamily: "Inter",
                  fontWeight: FontWeight.w600,
                ))
              : ListView.builder(
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    final displayedServiceNames = <String>{};
                    final orderId = order.orderId;
                    String lastOrderStatus = order.orderStatus.isNotEmpty
                        ? order.orderStatus.last.status
                        : "";
                    final logisticId = Global.storageServices
                        .getString(AppConstants.logisticId);
                    if (order.logisticId.first == logisticId &&
                        (lastOrderStatus == "pickedUp" ||
                            lastOrderStatus == "cleaning" ||
                            lastOrderStatus == "readyToDelivery" ||
                            lastOrderStatus == "outOfDelivery"))
                      lastOrderStatus = "pickedUp";
                    // print("--->${order.logisticId[0].toString()}");
                    return Container(
                      color: const Color(0xffbee3db),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //height: 80.h,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0xff89b0ae),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5.h,
                                  ),
                                  child: Container(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: textcustomnormal(
                                        text: 'Order Id :$orderId',
                                        fontWeight: FontWeight.w500,
                                        fontfamily: "Inter",
                                        fontSize: 18,
                                        color: Colors.black,
                                      )),
                                ),
                                if (lastOrderStatus != null)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 10.w),
                                    child: Text(
                                      setCorrectGrammer(lastOrderStatus),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(25.w, 10.h, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: order.items.map((item) {
                                return Text(
                                  '${item.quantity} x ${item.itemName}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          dashLine(
                            color: Colors.grey.shade300,
                          ),
                          if (lastOrderStatus != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8.0, left: 10),
                                  child: Text(
                                    formatDate(
                                        order.orderStatus.last.dateAndTime),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 10),
                                  child: Text(
                                    "₹ ${order.amount}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 12.h,
                          ),
                          dashLine(
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
