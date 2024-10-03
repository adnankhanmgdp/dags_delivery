import 'dart:developer';

import 'package:dags_delivery_app/Common/widgets/app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../../ApiService/api_service.dart';
import '../model/dashboard_model.dart';
import 'Widgets/dashboard_widgets.dart';
import 'package:location/location.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  const DashBoardScreen({super.key});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  String leftDate = "12/05/2004";
  String rightDate = "31/06/2024";
  Location location = Location();

  late Future<TodaySummary> _summaryFuture;
  bool available = false;

  @override
  void initState() {
    super.initState();

    _summaryFuture = ApiService.dashboard();

    final isAvailable = Global.storageServices.getLogisticAvailable();
    if (isAvailable) {
      available = true;
    }
  }

  Future<LocationData> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location services  are not enabled');
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }
    _locationData = await location.getLocation();
    return _locationData;
  }

  Future<void> _refreshData() async {
    setState(() {
      _summaryFuture = ApiService.dashboard();
    });
  }

  @override
  void didChangeDependencies() async {
    String lat = '';
    String long = '';
    await _getLocation().then((value) async {
      lat = "${value.latitude}";
      long = "${value.longitude}";
      final String logisticId =
          Global.storageServices.getString(AppConstants.logisticId);
      if (kDebugMode) {
        print("latitude is $lat, longitude is $long");
      }
      bool isSuccess = await ApiService.trackLocation(lat, long, logisticId);
      if (isSuccess) {
        if (kDebugMode) {
          print('location is confirmed added from dashboard also.');
        }
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final String logisticId =
        Global.storageServices.getString(AppConstants.logisticId);
    // Future<void> selectLeftDate() async {
    //   DateTime? datePicked = await showDatePicker(
    //       context: context,
    //       firstDate: DateTime(2000),
    //       lastDate: DateTime(2100),
    //       initialDate: DateTime.now());
    //   if (datePicked != null) {
    //     setState(() {
    //       leftDate = datePicked.toString().split(" ")[0];
    //     });
    //   }
    // }
    //
    // Future<void> selectRightDate() async {
    //   DateTime? datePicked = await showDatePicker(
    //       context: context,
    //       firstDate: DateTime(2000),
    //       lastDate: DateTime(2100),
    //       initialDate: DateTime.now());
    //   if (datePicked != null) {
    //     setState(() {
    //       rightDate = datePicked.toString().split(" ")[0];
    //     });
    //   }
    // }

    return Scaffold(
      appBar: buildAppBarWithAction(context: context),
      body: SingleChildScrollView(
        child: Center(
            child: FutureBuilder<TodaySummary>(
                future: _summaryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text('Could not load data at this time')),
                    );
                  } else if (!snapshot.hasData) {
                    return const Text('No data available');
                  } else {
                    final summary = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const topTitle(),
                            Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(right: 20.w, top: 10.h),
                              child: IconButton(
                                  onPressed: () {
                                    _refreshData();
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    size: 30.h,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        dashLine(
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Change Availability",
                                style: TextStyle(fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  bool gotSuccess =
                                      await ApiService.switchAvailability(
                                          logisticId);
                                  if (gotSuccess) {
                                    log('switched availability success.');
                                  }
                                  available = !available;
                                  Global.storageServices.setBool(
                                      AppConstants.logisticAvailable,
                                      available);
                                  setState(() {
                                    available = available;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          available ? Colors.red : Colors.green,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Text(
                                    available ? "Go Offline" : "Go Online",
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        dashLine(
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        // calenderRow(
                        //     leftdate: leftDate,
                        //     rightdate: rightDate,
                        //     leftdatePick: () => selectLeftDate(),
                        //     rightdatePick: () => selectRightDate()),
                        SizedBox(
                          height: 8.h,
                        ),
                        available
                            ? Column(
                                children: [
                                  DashboardContainer(
                                    color: const Color.fromARGB(
                                        255, 158, 181, 255),
                                    titleText: "Total Order Completed",
                                    salesNumber:
                                        summary.totalCompletedOrders.toString(),
                                    iconPath: Icons.done_outline_outlined,
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  DashboardContainer(
                                    color:
                                        const Color.fromARGB(255, 95, 182, 98),
                                    titleText: "Total Earnings Today",
                                    salesNumber:
                                        "₹ ${summary.totalAmountToday}",
                                    iconPath: Icons.wallet,
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Card(
                                    elevation: 5.0,
                                    child: Container(
                                      // height: 180.h,
                                      width: 360.w,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 145, 162, 255),
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5.w,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.h,
                                            bottom: 20.h,
                                            left: 15.w,
                                            right: 15.w),
                                        child: Column(
                                          children: [
                                            Text('Today\'s orders for pickup',
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                )),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.black,
                                              height: 1.h,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'To Pickup',
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10.h),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                summary
                                                                    .ordersToPic
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      35.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                )))
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 100.h,
                                                    width: 1.w,
                                                    color: Colors.black,
                                                  ),
                                                  // SizedBox(
                                                  //   width:
                                                  //       MediaQuery.of(context).size.width *
                                                  //           0.2,
                                                  // ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 130.w,
                                                          child: Center(
                                                            child: Text(
                                                              "Picked Up",
                                                              style: TextStyle(
                                                                fontSize: 20.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10.h),
                                                          child: Center(
                                                            child: Text(
                                                              summary
                                                                  .totalOrdersPicked
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 35.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Card(
                                    elevation: 5.0,
                                    child: Container(
                                      // height: 180.h,
                                      width: 360.w,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 241, 173, 255),
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5.w,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.h,
                                            bottom: 20.h,
                                            left: 15.w,
                                            right: 15.w),
                                        child: Column(
                                          children: [
                                            Text('Today\'s orders for delivery',
                                                style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                )),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.black,
                                              height: 1.h,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'For Delivery',
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10.h),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                summary
                                                                    .ordersToDeliver
                                                                    .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      35.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                )))
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 100.h,
                                                    width: 1.w,
                                                    color: Colors.black,
                                                  ),
                                                  // SizedBox(
                                                  //   width:
                                                  //       MediaQuery.of(context).size.width *
                                                  //           0.2,
                                                  // ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 130.w,
                                                          child: Center(
                                                            child: Text(
                                                              "Delivery Done",
                                                              style: TextStyle(
                                                                fontSize: 20.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10.h),
                                                          child: Center(
                                                            child: Text(
                                                              summary
                                                                  .totalOrdersDelivered
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 35.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  DashboardContainer(
                                    color: const Color.fromARGB(
                                        255, 255, 220, 125),
                                    titleText: "Total Distance Travelled",
                                    salesNumber:
                                        "${summary.totalDistanceToday} Km",
                                    iconPath: Icons.directions_bike_outlined,
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                  )
                                ],
                              )
                            : Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 200.h),
                                  child: textcustomnormal(
                                    text: "You are offline",
                                    fontSize: 20,
                                    fontfamily: "Inter",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                      ],
                    );
                  }
                })),
      ),
    );
  }
// Define the global variable
}
