
import 'package:dags_delivery_app/Common/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../main.dart';
import '../utils/app_colors.dart';
import '../utils/image_res.dart';
import 'app_shadow.dart';

Widget logoNew(Size size) {
  return ScreenUtilInit(
      designSize: Size(size.width, size.height),
      builder: (context, child) =>
          SizedBox(child: Image.asset(ImageRes.logo)));
}
Widget appButtons(
    {String buttonText = "Next",
    Color buttonColor = AppColors.primaryElement,
    Color buttonTextColor = AppColors.primaryElementText,
    double buttonBorderWidth = 0.0,
    double height = 55,
    double width = 370,
    BuildContext? context,
    Color borderColor=Colors.black,
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  return GestureDetector(
    onTap: anyWayDoor!,
    /* we are calling any way door func when this button is pressed
    and this func will be executed in the file from where this button has been called.*/
    child: Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: appBoxDecoration(
          color: buttonColor,
          borderWidth: buttonBorderWidth,
          radius: 10,
          borderColor:borderColor),
      child: text20normal(
        text: buttonText,
        color: buttonTextColor,
        fontfamily: "Inter",
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget appButtonswithoutaction({
  String buttonText = "Next",
  Color buttonColor = AppColors.primaryElement,
  Color buttonTextColor = AppColors.primaryElementText,
  double buttonBorderWidth = 0.0,
}) {
  return Container(
    alignment: Alignment.center,
    height: 50.h,
    width: 345.w,
    decoration: appBoxDecoration(
        color: buttonColor, borderWidth: buttonBorderWidth, radius: 10),
    child: text20normal(
      text: buttonText,
      color: buttonTextColor,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget documentsButtons(
    {String buttonText = "Next",
    Color buttonColor = AppColors.documentButtonBg,
    Color buttonTextColor = AppColors.primaryElementText,
    IconData buttonIcon = Icons.error_outline_sharp,
    double buttonBorderWidth = 1.0,
    Color iconColor = const Color(0xfffff0ce),
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  return GestureDetector(
    onTap: anyWayDoor!,
    child: Container(
      alignment: Alignment.center,
      height: 55,
      width: 350,
      decoration: appBoxDecoration(
          color: buttonColor,
          borderWidth: buttonBorderWidth,
          radius: 10.w,
          borderColor: Colors.grey.shade400),
      child: Row(
        children: [
          Container(
              height: 40.h,
              width: 40.w,
              decoration: appBoxDecoration(
                  color: iconColor,
                  radius: 7.w,
                  borderWidth: 0.0,
                  borderColor: Colors.white),
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
              child: Icon(buttonIcon,size: 20.h,)),
          SizedBox(
            width: 5.w,
          ),
          Text(
            buttonText,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          SizedBox(
            width: 5.w,
          ),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            size: 3.h,
          )
        ],
      ),
    ),
  );
}

Widget customIconAppButton(
    {String buttonText = "Next",
    Color buttonColor = AppColors.primaryElement,
    Color buttonTextColor = AppColors.primaryElementText,
    double buttonTextSize = 16,
    double buttonRadius = 15,
    Color borderColor = Colors.black,
    double buttonBorderWidth = 0.0,
    IconData buttonIcon = Icons.edit_calendar_rounded,
    double height = 55,
    double width = 370,
    BuildContext? context,
    void Function()?
        anyWayDoor // a call back function  designed to make navigation....
    }) {
  return GestureDetector(
    onTap: anyWayDoor!,
    /* we are calling any way door func when this button is pressed
    and this func will be executed in the file from where this button has been called.*/
    child: Container(
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: appBoxDecoration(
          color: buttonColor,
          borderWidth: buttonBorderWidth,
          radius: buttonRadius,
          borderColor: borderColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(buttonIcon),
          SizedBox(
            width: 10.w,
          ),
          textcustomnormal(
            fontSize: buttonTextSize,
            fontWeight: FontWeight.w600,
            fontfamily: "Poppins",
            text: buttonText,
            color: buttonTextColor,
          )
        ],
      ),
    ),
  );
}

Widget orderCardCommon(
    {String customerName = "",
    String amount = "",
    String status = "",
    int orderNumber = 12324}) {
  Color color;
  if (status == "Cancelled") {
    color = const Color(0xffF14B4B);
  } else {
    color = const Color(0xff599691);
  }
  return GestureDetector(
    onTap: () => navKey.currentState?.pushNamed(
      '/order_det_scr',
    ),
    child: Container(
      margin: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
      child: Card(
          shadowColor: Colors.grey.shade400,
          elevation: 5.0,
          clipBehavior: Clip.hardEdge,
          child: Container(
            alignment: Alignment.center,
            width: 434.w,
            height: 125.h,
            decoration: appBoxDecoration(
                color: const Color(0xffFFF5DD),
                radius: 10,
                borderWidth: 0,
                borderColor: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(5.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          textcustomnormal(
                            text: customerName,
                            color: Colors.black,
                            fontSize: 16,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                          textcustomnormal(
                            text: "20 April, 11:40 AM",
                            color: Colors.grey.shade500,
                            fontSize: 14,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 150.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          textcustomnormal(
                            text: amount,
                            color: Colors.black,
                            fontSize: 16,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w600,
                          ),
                          textcustomnormal(
                            text: "UPI",
                            color: Colors.grey.shade500,
                            fontSize: 14,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                dashLine(
                  color: Colors.grey.shade400,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textcustomnormal(
                      text: "Order Number $orderNumber",
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      fontfamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                    textcustomnormal(
                      text: "3 Items",
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      fontfamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                    textcustomnormal(
                      text: status,
                      color: color,
                      fontSize: 14,
                      fontfamily: "Inter",
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                )
              ],
            ),
          )),
    ),
  );
}
