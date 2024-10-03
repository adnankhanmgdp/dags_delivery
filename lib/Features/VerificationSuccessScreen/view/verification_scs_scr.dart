import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Common/utils/app_colors.dart';
import '../../../Common/utils/image_res.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../../SplashScreen/view/Widgets/splash_scree_widgets.dart';

class VerifyingSuccessScreen extends StatefulWidget {
  const VerifyingSuccessScreen({super.key});

  @override
  State<VerifyingSuccessScreen> createState() => _VerifyingSuccessScreenState();
}

class _VerifyingSuccessScreenState extends State<VerifyingSuccessScreen> {
  @override
  void initState() {
    super.initState();
    _checkVerificationStatus();
  }

  Future<void> _checkVerificationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTime = prefs.getBool('isFirstTime');
    bool? isVerified = prefs.getBool('isVerified');

    if (isFirstTime == null || isFirstTime == true) {
      // Show this screen and set isFirstTime to false
      await prefs.setBool('isFirstTime', false);
    } else if (isVerified == true) {
      // Navigate to the verification success screen if verified
      Navigator.pushReplacementNamed(context, '/verificationSuccess');
    } else {
      // Navigate directly to the application screen
      Navigator.pushReplacementNamed(context, '/application');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
        designSize: Size(screenWidth, screenHeight),
        builder: (context, child) =>
            SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    SizedBox(
                        height: 500.h,
                        width: 600.w,
                        child: Image.asset(
                          ImageRes.verifiedimage,
                          fit: BoxFit.contain,
                        )),
                    logoContainer(size),
                    SizedBox(
                      height: 7.h,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 500.h,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: const text24normal(
                              text: "Your KYC has been Verified",
                              fontWeight: FontWeight.w700,
                              fontfamily: "Inter",
                            )),
                        SizedBox(
                          height: 50.h,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 29.w, right: 25.w),
                            child: appButtons(
                                buttonText: "Home",
                                buttonColor: AppColors.primaryElement,
                                buttonTextColor: AppColors.primaryText,
                                buttonBorderWidth: 2.h,
                                anyWayDoor: () {
                                  Navigator.pushNamed(context, '/application');
                                }))
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
