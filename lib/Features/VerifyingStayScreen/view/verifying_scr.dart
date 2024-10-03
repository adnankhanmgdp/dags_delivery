//
// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../Common/utils/image_res.dart';
// import '../../../Common/widgets/text_widgets.dart';
// import '../../../main.dart';
// import '../../SplashScreen/view/Widgets/splash_scree_widgets.dart';
//
// class VerifyingScreen extends StatefulWidget {
//   const VerifyingScreen({super.key});
//
//   @override
//   State<VerifyingScreen> createState() => _VerifyingScreenState();
// }
//
// class _VerifyingScreenState extends State<VerifyingScreen> {
//
//   @override
//   void initState() {
//     // Future.delayed(const Duration(seconds: 3), () {
//     //   navKey.currentState
//     //       ?.pushNamedAndRemoveUntil('/verify_scs_scr', (route) => false); });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final ScreenHeight = MediaQuery.of(context).size.height;
//     final ScreenWidth = MediaQuery.of(context).size.width;
//     return ScreenUtilInit(
//         designSize: Size(ScreenWidth, ScreenHeight),
//         builder: (context, child) => SafeArea(
//               child: Scaffold(
//                 backgroundColor: Colors.white,
//                 body: DoubleBackToCloseApp(
//                   snackBar: const SnackBar(
//                       content: Text(
//                         'Tap back again to leave',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ))
//                   ,child: Stack(
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         margin: EdgeInsets.only(top: 130.h),
//                           height: 400.h,
//                           width: 600.w,
//                           child: Image.asset(
//                             ImageRes.verifyingimage,
//                             fit: BoxFit.contain,
//                           )),
//                       logoContainer(size),
//                       SizedBox(
//                         height: 7.h,
//                       ),
//                       Column(
//                         children: [
//                           SizedBox(
//                             height: 530.h,
//                           ),
//                           Container(
//                               alignment: Alignment.center,
//                               child: const text24normal(
//                                 text: "Verifying Details",
//                                 fontWeight: FontWeight.w600,
//                                 fontfamily: "Inter",
//                               )),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           const textcustomnormal(
//                             fontSize: 18,
//                             text: "We are verifying your documents. "
//                                 "                          We will notify you when approved.",
//                             fontfamily: "Inter",
//                             fontWeight: FontWeight.w400,
//                           ),
//                           SizedBox(
//                             height: 50.h,
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ));
//   }
// }

import 'package:dags_delivery_app/Common/utils/constants.dart';
import 'package:dags_delivery_app/Features/ApiService/api_service.dart';
import 'package:dags_delivery_app/Features/DeliveryPartnerScreen/view/delivery_prt_scr.dart';
import 'package:dags_delivery_app/main.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/app_colors.dart';
import '../../../Common/utils/image_res.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../../SplashScreen/view/Widgets/splash_scree_widgets.dart';

class VerifyingScreen extends StatefulWidget {
  const VerifyingScreen({super.key});

  @override
  State<VerifyingScreen> createState() => _VerifyingScreenState();
}

class _VerifyingScreenState extends State<VerifyingScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
      designSize: Size(screenWidth, screenHeight),
      builder: (context, child) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text(
                'Tap back again to leave',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 130.h),
                    height: 400.h,
                    child: Image.asset(
                      ImageRes.verifyingimage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  logoContainer(size),
                  SizedBox(
                    height: 7.h,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 530.h,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const text24normal(
                          text: "Verifying Details",
                          fontWeight: FontWeight.w600,
                          fontfamily: "Inter",
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const textcustomnormal(
                        fontSize: 18,
                        text: "We are verifying your documents. "
                            "We will notify you when approved.",
                        fontfamily: "Inter",
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
