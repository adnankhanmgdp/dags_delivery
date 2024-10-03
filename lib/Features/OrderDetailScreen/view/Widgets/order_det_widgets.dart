import 'package:dags_delivery_app/Common/widgets/app_button_widgets.dart';
import 'package:dags_delivery_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Common/utils/image_res.dart';
import '../../../../Common/widgets/text_widgets.dart';
import '../../Provider/order_det_notifier.dart';

class orderTopTitle extends StatefulWidget {
  const orderTopTitle({super.key});

  @override
  State<orderTopTitle> createState() => _orderTopTitleState();
}

class _orderTopTitleState extends State<orderTopTitle> {
  final items = ["New Orders", "Previous Orders", "Last Month"];
  String? value = "New Orders";

  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
      designSize: Size(ScreenWidth, ScreenHeight),
      builder: (context, child) => Container(
        margin: EdgeInsets.fromLTRB(25.w, 15.h, 0.h, 0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const textcustomnormal(
            text: "Orders",
            fontfamily: "Inter",
            fontSize: 22,
            color: Color(0xff1C254E),
            fontWeight: FontWeight.w700,
          ),
          Row(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 6.h, 0, 0),
                    child: const textcustomnormal(
                        text: "Sort by  ",
                        color: Color(0xff1C254E),
                        fontSize: 18,
                        fontfamily: "Inter",
                        fontWeight: FontWeight.w700,
                    ),
                ),

                Container(
                    width: 145.w,
                    margin: EdgeInsets.fromLTRB(0, 7.h, 0, 0),
                    child: DropdownButton<String>(
                      value: value,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) {

                        setState(() {
                          this.value = value;
                        });
                      },
                    ),
                ),
              ]
          ),
        ]),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: textcustomnormal(
      text: item,
      color: const Color(0xff1C254E),
      fontSize: 15,
      fontfamily: "Inter",
      fontWeight: FontWeight.w700,
    ));

Widget radioSwipeableButton(
    {void Function()? selectRadio01,
      void Function()? selectRadio02,
      required WidgetRef ref}) {
  bool active = ref.watch(orderRadioNotifierProvider);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: selectRadio01!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(40.w, 0, 0, 0),
                child: const textcustomnormal(
                  text: "Active Orders",
                  fontSize: 16,
                  fontfamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 205.w,
                height: 2.h,
                color: active ? const Color(0xff1C254E) : Colors.grey.shade400,
              )
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: selectRadio02!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(30.w, 0, 0, 0),
                child: const textcustomnormal(
                  text: "Past Order",
                  fontSize: 16,
                  fontfamily: "Inter",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 206.w,
                height: 2.h,
                color: active ? Colors.grey.shade400 : const Color(0xff1C254E),
              )
            ],
          ),
        ),
      )
    ],
  );
}

Widget orderDetailCard(BuildContext context) {
  return Container(
    height: 250.h,
    width: MediaQuery.of(context).size.width,
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70.h,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xffFFCC57),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 12,
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textcustomnormal(
                        text: "",
                        fontSize: 24,
                        fontfamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                      textcustomnormal(
                        text: "",
                        fontSize: 18,
                        fontfamily: "Inter",
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(
              //   width: 50.w,
              // ),
              Expanded(
                flex: 4,
                child: GestureDetector(
                    onTap: () {
                      navKey.currentState?.pushNamed("/scan_scr");
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20.h,
                      child: Image.asset(
                        ImageRes.ordercardicon,
                        color: const Color(0xffFFCC57),
                      ),
                    )),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(30.w, 10.h, 0, 0),
          height: 90.h,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const text16normal(
                text: "4  X  Dry Cleaning",
                fontWeight: FontWeight.w700,
                fontfamily: "Inter",
              ),
              SizedBox(
                height: 5.h,
              ),
              const text16normal(
                text: "2  X  Ironing",
                fontWeight: FontWeight.w700,
                fontfamily: "Inter",
              ),
              SizedBox(
                height: 5.h,
              ),
              const text16normal(
                text: "2  X Machine Wash",
                fontWeight: FontWeight.w700,
                fontfamily: "Inter",
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
        dashLine(
          color: Colors.grey.shade300,
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            appButtons(
                height: 50.h,
                width: 140.w,
                buttonColor: Colors.white,
                buttonBorderWidth: 2.h,
                buttonText: "Processing",
                buttonTextColor: const Color(0xffF14B4B),
                anyWayDoor: () {},
                borderColor: const Color(0xffF14B4B)),
            appButtons(
                height: 50.h,
                width: 140.w,
                buttonColor: const Color(0xff38DAA6),
                buttonBorderWidth: 2.h,
                buttonText: "Completed",
                buttonTextColor: Colors.black,
                anyWayDoor: () {}),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        dashLine(
          color: Colors.grey.shade300,
        )
      ],
    ),
  );
}

Widget orderPastDetailCard(BuildContext context) {
  return Container(
      height: 250.h,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              height: 70.h,
              width: double.maxFinite,
              color: const Color(0xffFFCC57),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    flex:10,
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textcustomnormal(
                          text: "SIF744",
                          fontSize: 24,
                          fontfamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                        textcustomnormal(
                          text: "Wash M.G. Pickup",
                          fontSize: 18,
                          fontfamily: "Inter",
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20.h,
                      child: Image.asset(
                        ImageRes.ordercardicon,
                        color: const Color(0xffFFCC57),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30.w, 10.h, 0, 0),
              height: 90.h,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const text16normal(
                    text: "4  X  Dry Cleaning",
                    fontWeight: FontWeight.w700,
                    fontfamily: "Inter",
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  const text16normal(
                    text: "2  X  Ironing",
                    fontWeight: FontWeight.w700,
                    fontfamily: "Inter",
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  const text16normal(
                    text: "2  X Machine Wash",
                    fontWeight: FontWeight.w700,
                    fontfamily: "Inter",
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
            dashLine(
              color: Colors.grey.shade300,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                text16normal(
                  text: "22 Aug 2023 at 5:50 PM",
                  fontWeight: FontWeight.w700,
                  fontfamily: "Inter",
                  color: Colors.grey.shade600,
                ),
                const textcustomnormal(
                  text: "₹2025.6",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontfamily: "Inter",
                  color: Colors.black,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            dashLine(
              color: Colors.grey.shade300,
            )
          ]));
}