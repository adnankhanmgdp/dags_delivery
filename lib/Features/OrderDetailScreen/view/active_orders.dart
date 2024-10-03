import 'package:dags_delivery_app/Common/utils/LogisticModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'dart:developer';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/image_res.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../../ApiService/api_service.dart';
import '../../MapScreen/view/map_scr.dart';
import '../model/order_model.dart';

class ActiveOrders extends StatefulWidget {
  final String lastOrderNumbers;

  const ActiveOrders({super.key, required this.lastOrderNumbers});

  @override
  State<ActiveOrders> createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  List<Order> orders = [];
  bool isLoading = true;
  bool isAvailable = false;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    try {
      orders = await ApiService.activeOrders();
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
      case 'readyToDelivery':
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
          : filteredOrders.isEmpty
              ? const Center(
                  child: textcustomnormal(
                    text: "No active orders available",
                    fontSize: 20,
                    fontfamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                )
              : ListView.builder(
                  itemCount: filteredOrders.length,
                  itemBuilder: (context, index) {
                    final order = filteredOrders[index];
                    final displayedServiceNames = <String>{};
                    final orderId = order.orderId;
                    final deliveryType = order.deliveryType;
                    final String? lastOrderStatus = order.orderStatus.isNotEmpty
                        ? order.orderStatus.last.status
                        : null;
                    return GestureDetector(
                      onTap: () async {
                        LogisticModel.orderId = orderId;
                        log('Here is the Different Order ID: ${LogisticModel.orderId}');
                        // Fetch geo-coordinates
                        try {
                          List<dynamic>? coordinates =
                              await ApiService.fetchGeoCoordinates();
                          if (coordinates != null) {
                            final GeoCoordinates userCoordinates =
                                coordinates[0];
                            final GeoCoordinates vendorCoordinates =
                                coordinates[1];
                            log('UserGeoCoordinates: ${userCoordinates.latitude}, ${userCoordinates.longitude}');
                            log('VendorGeoCoordinates: ${vendorCoordinates.latitude}, ${vendorCoordinates.longitude}');
                            if (lastOrderStatus == 'readyToPickup') {
                              log('from ready to pickup');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return MapScreen(
                                    orderStatus: lastOrderStatus!,
                                    initialLocation: LatLng(
                                      double.parse(userCoordinates.latitude),
                                      double.parse(userCoordinates.longitude),
                                    ),
                                    showGeoAndPoly: true,
                                    user: coordinates[2],
                                    vendor: coordinates[3],
                                    orderLocation: coordinates[4]
                                        ['orderLocation'],
                                  );
                                }),
                              );
                            } else if (lastOrderStatus == 'pickedUp') {
                              log('from picked up');
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return MapScreen(
                                    orderStatus: lastOrderStatus!,
                                    initialLocation: LatLng(
                                      double.parse(vendorCoordinates.latitude),
                                      double.parse(vendorCoordinates.longitude),
                                    ),
                                    showGeoAndPoly: true,
                                    user: coordinates[2],
                                    vendor: coordinates[3],
                                    orderLocation: coordinates[4]
                                        ['orderLocation'],
                                  );
                                }),
                              );
                            } else if (lastOrderStatus == 'readyToDelivery') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return MapScreen(
                                    orderStatus: lastOrderStatus!,
                                    initialLocation: LatLng(
                                      double.parse(vendorCoordinates.latitude),
                                      double.parse(vendorCoordinates.longitude),
                                    ),
                                    showGeoAndPoly: true,
                                    user: coordinates[2],
                                    vendor: coordinates[3],
                                    orderLocation: coordinates[4]
                                        ['orderLocation'],
                                  );
                                }),
                              );
                            } else if (lastOrderStatus == 'outOfDelivery') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return MapScreen(
                                    orderStatus: lastOrderStatus!,
                                    initialLocation: LatLng(
                                      double.parse(userCoordinates.latitude),
                                      double.parse(userCoordinates.longitude),
                                    ),
                                    showGeoAndPoly: true,
                                    user: coordinates[2],
                                    vendor: coordinates[3],
                                    orderLocation: coordinates[4]
                                        ['orderLocation'],
                                  );
                                }),
                              );
                            }
                          }
                        } catch (e) {
                          log('Failed to fetch GeoCoordinates: $e');
                        }
                      },
                      child: Container(
                        color: const Color(0xffbee3db),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: const Color(0xff89b0ae),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: textcustomnormal(
                                        text: 'Order Id :$orderId',
                                        fontWeight: FontWeight.w500,
                                        fontfamily: "Inter",
                                        fontSize: 18,
                                        color: Colors.black,
                                      )
                                      // Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: order.items.where((item) {
                                      //     if (displayedServiceNames
                                      //         .contains(item.serviceName)) {
                                      //       return false;
                                      //     } else {
                                      //       displayedServiceNames
                                      //           .add(item.serviceName);
                                      //       return true;
                                      //     }
                                      //   }).map((item) {
                                      //     return Padding(
                                      //       padding: EdgeInsets.symmetric(
                                      //           vertical: 5.h),
                                      //       child: Text(
                                      //         item.serviceName,
                                      //         style: const TextStyle(
                                      //           fontSize: 18,
                                      //           fontFamily: "Inter",
                                      //           fontWeight: FontWeight.w600,
                                      //         ),
                                      //       ),
                                      //     );
                                      //   }).toList(),
                                      // ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                (deliveryType == 'express')
                                    ? Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Image.asset(ImageRes.expressicon,height: 30.h,width: 30.h,)
                                )
                                    : SizedBox()
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            dashLine(
                              color: Colors.grey.shade300,
                            ),
                            if (lastOrderStatus != null)
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
                            SizedBox(
                              height: 12.h,
                            ),
                            dashLine(
                              color: Colors.grey.shade300,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
