import 'package:dags_delivery_app/Features/DashboardScreen/Provider/dashboard_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Common/utils/image_res.dart';
import '../../../../Common/widgets/text_widgets.dart';

class topTitle extends StatefulWidget {
  const topTitle({super.key});

  @override
  State<topTitle> createState() => _topTitleState();
}

class _topTitleState extends State<topTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(25.w, 15.h, 0, 0),
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textcustomnormal(
              text: "Dashboard",
              fontfamily: "Inter",
              fontSize: 22,
              color: Color(0xff1C254E),
              fontWeight: FontWeight.w700,
            ),
          ]),
    );
  }
}

Widget mapOnlineTitleRow2({void Function()? onlineButton}) {
  return Container(
    color: Colors.white.withOpacity(0.3),
    margin: EdgeInsets.fromLTRB(10.w, 0.h, 0, 0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Image.asset(
            ImageRes.notificationimage,
            height: 35.h,
          ),
        ),
        SizedBox(
          width: 15.h,
        ),
        const textcustomnormal(
          text: "You’re Online",
          fontWeight: FontWeight.w700,
          fontfamily: "Inter",
          fontSize: 21,
          color: Color(0xff1C254E),
        ),
        SizedBox(
          width: 80.h,
        ),
        GestureDetector(
            onTap: onlineButton!,
            child: Image.asset(
              ImageRes.onlinebuttonimage,
              height: 35.h,
            ))
      ],
    ),
  );
}

Widget calenderRow(
    {String leftdate = "April 8, 2024",
    String rightdate = "April 8, 2024",
    void Function()? leftdatePick,
    void Function()? rightdatePick}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SizedBox(
        width: 5.w,
      ),
      GestureDetector(
          onTap: leftdatePick!, child: Image.asset(ImageRes.calenderimage)),
      SizedBox(
        width: 7.w,
      ),
      textcustomnormal(
        text: leftdate,
        color: const Color(0xff1C254E),
        fontSize: 13,
        fontfamily: "Inter",
        fontWeight: FontWeight.w600,
      ),
      SizedBox(
        width: 7.w,
      ),
      Image.asset(ImageRes.arrowimage),
      SizedBox(
        width: 7.w,
      ),
      GestureDetector(
          onTap: rightdatePick, child: Image.asset(ImageRes.calenderimage)),
      SizedBox(
        width: 7.w,
      ),
      textcustomnormal(
        text: rightdate,
        color: const Color(0xff1C254E),
        fontSize: 13,
        fontfamily: "Inter",
        fontWeight: FontWeight.w600,
      ),
      SizedBox(
        width: 10.w,
      ),
    ],
  );
}

Widget radioSwipeableButton(
    {void Function()? selectRadio01,
    void Function()? selectRadio02,
    required WidgetRef ref}) {
  bool active = ref.watch(dashBoardNotifierProvider);
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      GestureDetector(
        onTap: selectRadio01!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(40.w, 0, 0, 0),
              child: const textcustomnormal(
                text: "Revenue",
                fontSize: 16,
                fontfamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: 195.w,
              height: 2.h,
              color: active ? const Color(0xff1C254E) : Colors.grey.shade400,
            )
          ],
        ),
      ),
      GestureDetector(
        onTap: selectRadio02!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(60.w, 0, 0, 0),
              child: const textcustomnormal(
                text: "Payouts",
                fontSize: 16,
                fontfamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              width: 195.w,
              height: 2.h,
              color: active ? Colors.grey.shade400 : const Color(0xff1C254E),
            )
          ],
        ),
      )
    ],
  );
}

class DashboardContainer extends StatelessWidget {
  final String titleText;
  final String salesNumber;
  final IconData iconPath;
  final Color color;

  const DashboardContainer(
      {super.key,
      required this.titleText,
      required this.salesNumber,
      required this.iconPath,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: ()=> dashboard(context),
      child: Card(
        elevation: 5.0,
        child: Container(
          alignment: Alignment.center,
          // height: 180.h,
          width: 360.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: Colors.black,
              width: 0.5.w,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleText,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80.w,
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFCC57),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                              child: Icon(
                            iconPath,
                            size: 30.h,
                            color: Colors.black,
                          )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Center(
                        child: Text(
                          salesNumber,
                          style: TextStyle(
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
// static void dashboard(BuildContext context) async {
//   bool isRegistration = false;
//   try {
//     // Pass the globalLogisticId to the API service call
//     Map<String, dynamic> response = await ApiService.dashboardDataFetch(globalLogisticId!);
//
//     // Debug prints to see the response
//     if (kDebugMode) {
//       print('Response from login: $response');
//     }
//
//     // Check if response is not null and is a Map
//     if (response == null || response.isEmpty) {
//       throw Exception("Response is null or empty");
//     }
//
//     // Check if the logistic key exists and is a Map
//     if (!response.containsKey('logistic') || response['logistic'] == null) {
//       throw Exception("Response does not contain logistic information");
//     }
//
//     Map<String, dynamic> logistic = response['logistic'];
//
//     log('$response');
//
//   } catch (e) {
//     // Handle error, e.g., show error message to the user
//     if (kDebugMode) {
//       print('Failed to send OTP: $e');
//     }
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Failed to send OTP: $e')),
//     );
//   }
// }
}
