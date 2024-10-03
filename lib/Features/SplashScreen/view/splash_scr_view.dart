import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';
import '../../../main.dart';
import '../../ApiService/api_service.dart';
import 'Widgets/splash_scree_widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String verificationStatus = '';

  @override
  Future<void> didChangeDependencies() async {
    final bool isNumberSet = Global.storageServices.getUserNumberSet();
    // final phoneNumber =
    //     Global.storageServices.getString(AppConstants.userNumber);
    // print(phoneNumber);
    if (!isNumberSet) {
      /// user is coming first time to the app...
      if (kDebugMode) {
        print('user came to platform first time');
      }
      Future.delayed(const Duration(seconds: 3), () {
        navKey.currentState
            ?.pushNamedAndRemoveUntil('/delivery_prt_scr', (route) => false);
      });
    } else {
      /// user has opened app earlier also and a member of app...
      final phoneNumber =
          Global.storageServices.getString(AppConstants.userNumber);
      if (kDebugMode) {
        print(phoneNumber);
      }
      verificationStatus = await ApiService.fetchLogisticProfile(phoneNumber);
      if (verificationStatus == 'active') {
        /// everything is fine
        Global.storageServices.setBool(AppConstants.logisticVerified, true);
        navKey.currentState
            ?.pushNamedAndRemoveUntil('/application', (route) => false);
      } else {
        Global.storageServices.setBool(AppConstants.logisticVerified, false);
        navKey.currentState
            ?.pushNamedAndRemoveUntil('/verify_scr', (route) => false);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: Size(ScreenWidth, ScreenHeight),
        builder: (context, child) => SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    logoContainer(size),
                    SizedBox(
                      height: 20.h,
                    ),
                    imageStack(size)
                  ],
                ),
              ),
            ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'Widgets/splash_scree_widgets.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Check user authentication status or any necessary initialization
//     checkAuthenticationAndNavigate();
//   }
//
//   Future<void> checkAuthenticationAndNavigate() async {
//     // Simulate checking authentication status
//     bool isAuthenticated = await _checkAuthentication(); // Replace with your authentication logic
//
//     // Delay for splash screen illustration
//     await Future.delayed(const Duration(seconds: 3));
//
//     // Navigate based on authentication status
//     if (isAuthenticated) {
//       Navigator.pushReplacementNamed(context, '/application');
//     } else {
//       Navigator.pushReplacementNamed(context, '/register');
//       // Replace '/login_screen' with the route name for your login screen
//     }
//   }
//
//   Future<bool> _checkAuthentication() async {
//     // Replace with your authentication logic, e.g., checking stored tokens, session states, etc.
//     // Simulate authentication status here
//     await Future.delayed(const Duration(seconds: 1)); // Simulating a delay for checking auth
//     return true; // Replace with actual logic to check if user is authenticated
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final ScreenHeight = MediaQuery.of(context).size.height;
//     final ScreenWidth = MediaQuery.of(context).size.width;
//     return ScreenUtilInit(
//       designSize: Size(ScreenWidth, ScreenHeight),
//       builder: (context, child) => SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               logoContainer(size),
//               SizedBox(height: 20.h),
//               imageStack(size),
//             ],
//           ),
//         ),
//       ),
// //     );
//   }
// }
