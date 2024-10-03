import 'dart:async';
import 'package:dags_delivery_app/Common/utils/constants.dart';
import 'package:dags_delivery_app/Features/ApiService/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import '../../../../Common/widgets/text_widgets.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/app_colors.dart';
import '../../../Common/utils/image_res.dart';
import '../Controller/otp_controller.dart';
import '../Provider/otp_notifier.dart';
import 'Widget/otp_scr_wdt.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  late OtpController _controller;
  static const maxTime = 30;
  var time = maxTime;
  Timer? timer;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    runTimer();
    _controller = OtpController();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void runTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (time != 0) {
          time--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, bool>;
    final fromLogin = data['fromLogin'];
    final String phoneNumber =
        Global.storageServices.getString(AppConstants.userNumber);
    final String name = Global.storageServices.getString(AppConstants.userName);
    final String email =
        Global.storageServices.getString(AppConstants.userEmail);
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
    );
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: Size(ScreenWidth, ScreenHeight),
        builder: (context, child) => SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: Container(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        Image.asset(
                          ImageRes.logo,
                          height: 45.h,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        otpText(),
                        SizedBox(
                          height: 3.h,
                        ),
                        otpText02(),
                        SizedBox(
                          height: 30.h,
                        ),
                        Pinput(
                          length: 6,
                          onCompleted: (pin) {
                            ref
                                .read(otpNotifierProvider.notifier)
                                .onUserOtpInput(pin);
                          },
                          defaultPinTheme: defaultPinTheme,
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                        ),
                        SizedBox(
                          height: 310.h,
                        ),
                        verifyButton(ref, _controller, fromLogin!),
                        SizedBox(
                          height: 5.h,
                        ),
                        otpText03(),
                        SizedBox(
                          height: 2.h,
                        ),
                        (time != 0)
                            ? text14normal(
                                text: "Request new code in ${time}s",
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w400,
                              )
                            : GestureDetector(
                                onTap: () async {
                                  if (fromLogin) {
                                    final response =
                                        await ApiService.login(phoneNumber);
                                    if (response.containsKey('success') &&
                                        response['success'] == true) {
                                      await Fluttertoast.showToast(
                                          msg:
                                              "An OTP has been send to +91$phoneNumber",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              AppColors.primaryElement,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                    }
                                  } else {
                                    final response02 = await ApiService.sendOtp(
                                        name, email, phoneNumber);
                                    if (response02.containsKey('success') &&
                                        response02['success'] == true) {
                                      await Fluttertoast.showToast(
                                          msg:
                                              "An OTP has been send to +91$phoneNumber",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              AppColors.primaryElement,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                    }
                                  }
                                  time = maxTime;
                                },
                                child: const text16normal(
                                  text: "Resend Otp",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                      ],
                    ),
                  ),
                ))));
  }
}
