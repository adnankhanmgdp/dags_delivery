import 'package:dags_delivery_app/Features/ScanScreen/view/scanscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Common/utils/app_colors.dart';
import '../../../../Common/utils/image_res.dart';
import '../../../../Common/widgets/app_shadow.dart';
import '../../../../Common/widgets/image_widgets.dart';
import '../../../DashboardScreen/View/dashboard_scr.dart';
import '../../../OrderDetailScreen/view/order_detail_scr.dart';
import '../../../ProfileScreen/view/profile.dart';
import '../../../TransactionScreen/view/transaction_screen.dart';

var bottomTabs = <BottomNavigationBarItem>[
  BottomNavigationBarItem(
      icon: SizedBox(
          width: 25.w,
          height: 25.h,
          child: const Icon(
            Icons.dashboard,
            color: Color(0xfff3c367),
          )),
      activeIcon: Container(
          alignment: Alignment.center,
          height: 35.h,
          width: 80.w,
          decoration:
              appBoxDecoration(radius: 30.h, borderColor: Colors.grey.shade300),
          child: const Icon(
            Icons.dashboard,
            color: Color(0xfff3c367),
          )),
      backgroundColor: AppColors.primaryBackground,
      label: "DashBoard"),
  BottomNavigationBarItem(
      icon: SizedBox(
          width: 25.w,
          height: 25.h,
          child: const Icon(
            Icons.add_shopping_cart,
            color: Color(0xfff3c367),
          )),
      activeIcon: Container(
          alignment: Alignment.center,
          height: 35.h,
          width: 80.w,
          decoration:
              appBoxDecoration(radius: 30.h, borderColor: Colors.grey.shade300),
          child: const Icon(
            Icons.add_shopping_cart,
            color: Color(0xfff3c367),
          )),
      backgroundColor: AppColors.primaryBackground,
      label: "Orders"),
  BottomNavigationBarItem(
      icon: SizedBox(
          width: 25.w,
          height: 25.h,
          child: const Icon(
            Icons.currency_rupee_outlined,
            color: Color(0xfff3c367),
          )),
      activeIcon: Container(
          alignment: Alignment.center,
          height: 35.h,
          width: 80.w,
          decoration:
              appBoxDecoration(radius: 30.h, borderColor: Colors.grey.shade300),
          child: const Icon(
            Icons.currency_rupee_outlined,
            color: Color(0xfff3c367),
          )),
      backgroundColor: AppColors.primaryBackground,
      label: "Settlement History"),
  BottomNavigationBarItem(
      icon: SizedBox(
          width: 25.w,
          height: 25.h,
          child: const Icon(
            Icons.perm_identity,
            color: Color(0xfff3c367),
          )),
      activeIcon: Container(
          alignment: Alignment.center,
          height: 35.h,
          width: 80.w,
          decoration:
              appBoxDecoration(radius: 30.h, borderColor: Colors.grey.shade300),
          child: const Icon(
            Icons.perm_identity,
            color: Color(0xfff3c367),
          )),
      backgroundColor: AppColors.primaryBackground,
      label: "Profile "),
];

Widget appScreens(
    {int index = 0, double latitude = 0.0, double longitude = 0.0}) {
  List<Widget> screens = [
    const DashBoardScreen(),
    const OrderDetails(),
    const TransactionHistoryScreen(),
    const ProfileScreen(fromNavigationBar: true,)
  ];
  return screens[index];
}
