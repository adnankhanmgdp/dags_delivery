import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Common/widgets/app_shadow.dart';
import '../../../../Common/widgets/text_widgets.dart';

Widget transactionOrderCardCommon(
    {String dateAndTime = "02/05/2024 11:40 am",
    String amount = "",
    String status = "",
    int orderNumber = 12324}) {
  return Center(
    child: Card(
        shadowColor: Colors.grey.shade400,
        elevation: 2.0,
        clipBehavior: Clip.hardEdge,
        child: Container(
          alignment: Alignment.center,
          width: 360.w,
          height: 74.h,
          decoration: appBoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              radius: 10,
              borderWidth: 0,
              borderColor: Colors.white),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: textcustomnormal(
                    align: TextAlign.start,
                    text: dateAndTime,
                    color: Colors.black,
                    fontSize: 16,
                    fontfamily: "Inter",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 3.h),
                    child: textcustomnormal(
                      align: TextAlign.start,
                      text: '₹ $amount',
                      color: Color.fromARGB(255, 0, 172, 9),
                      fontSize: 18,
                      fontfamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
  );
}

Widget settlementCardContainer(String earning, String dueAmount) {
  return Container(
      padding: EdgeInsets.only(right: 10),
      alignment: Alignment.centerLeft,
      color: Colors.grey.shade200,
      height: 195.h,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                settlementRow("Total Earnings ", "₹$earning",
                    Color.fromARGB(255, 166, 187, 255)),
                settlementRow("Payment Due", "₹$dueAmount",
                    Color.fromARGB(255, 255, 236, 151)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                textAlign: TextAlign.center,
                "Due payments will be settled in your account \nwithin 2 working days.",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ));
}

Widget settlementRow(String cardText, String amount, Color col) {
  return Container(
    margin: EdgeInsets.fromLTRB(10.h, 0, 0, 0),
    child: Card(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
        shadowColor: Colors.grey.shade400,
        elevation: 2.0,
        clipBehavior: Clip.hardEdge,
        child: Container(
          alignment: Alignment.center,
          width: 180.w,
          padding: EdgeInsets.only(top: 20, bottom: 25),
          decoration: appBoxDecoration(
              color: col, radius: 10, borderWidth: 0, borderColor: col),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100.h,
                child: textcustomnormal(
                  text: cardText,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontfamily: "Inter",
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 100.h,
                child: textcustomnormal(
                  text: amount,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontfamily: "Inter",
                  color: Colors.black,
                ),
              ),
            ],
          ),
        )),
  );
}

class listHeading extends StatefulWidget {
  const listHeading({super.key});

  @override
  State<listHeading> createState() => _listHeadingState();
}

class _listHeadingState extends State<listHeading> {
  final items = ["Amount", "Date"];
  String? value = "Date";
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 20.w,
        ),
        const textcustomnormal(
          text: "Settlement History :",
          fontfamily: "Inter",
          fontSize: 20,
          color: Color(0xff1C254E),
          fontWeight: FontWeight.w700,
        ),
        // SizedBox(
        //   width: 60.w,
        // ),
        // Container(
        //   margin: EdgeInsets.only(top: 2.h),
        //     child: DropdownButton<String>(
        //       value: value,
        //       items: items.map(buildMenuItem).toList(),
        //       onChanged: (value) {
        //         setState(() {
        //           this.value = value;
        //         });
        //       },
        //     )),
      ],
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: textcustomnormal(
      text: item,
      color: const Color(0xff1C254E),
      fontSize: 16,
      fontfamily: "Inter",
      fontWeight: FontWeight.w700,
    ));
