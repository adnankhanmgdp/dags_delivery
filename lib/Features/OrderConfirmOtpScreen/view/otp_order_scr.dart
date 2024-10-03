import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../../../Common/widgets/text_widgets.dart';

import '../../../Common/utils/image_res.dart';
import '../../ApiService/api_service.dart';
import '../Provider/order_otp_notifier.dart';
import '../controller/order_otp_controller.dart';
import 'Widget/otp_scr_wdt.dart';

class OtpOrderScreen extends ConsumerStatefulWidget {
  const OtpOrderScreen({super.key});

  @override
  ConsumerState<OtpOrderScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpOrderScreen> {
  late OrderOtpController _controller;
  static const maxTime = 30;
  var time = maxTime;
  Timer? timer;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    runTimer();
    _controller = OrderOtpController();
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
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final orderId = data['orderId'];
    final phone = data['phone'];
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
                        otpOrderText(),
                        SizedBox(
                          height: 3.h,
                        ),
                        otpOrderText02(phone),
                        SizedBox(
                          height: 30.h,
                        ),
                        Pinput(
                          length: 4,
                          onCompleted: (pin) {
                            ref
                                .read(otpOrderNotifierProvider.notifier)
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
                        verifyOrderButton(ref, _controller, orderId!),
                        SizedBox(
                          height: 5.h,
                        ),
                        otpOrderText03(),
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
                                  await ApiService.sendOrderOtp(orderId);
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
