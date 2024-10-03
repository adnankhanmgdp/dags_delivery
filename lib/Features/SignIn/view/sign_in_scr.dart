import 'package:dags_delivery_app/Common/widgets/text_widgets.dart';
import 'package:dags_delivery_app/Features/SignIn/view/widgets/SignInWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Common/utils/app_colors.dart';
import '../../../Common/utils/image_res.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../../Common/widgets/app_text_fields.dart';
import '../Controller/signincontroller.dart';
import '../Provider/signinnotifier.dart';

class SignINScreen extends ConsumerStatefulWidget {
  const SignINScreen({super.key});

  @override
  ConsumerState<SignINScreen> createState() => _SignINScreenState();
}

class _SignINScreenState extends ConsumerState<SignINScreen> {
  late DeliveryPartnerController02 _controller;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    _controller = DeliveryPartnerController02();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: Size(ScreenWidth, ScreenHeight),
        builder: (context, child) => SafeArea(
            child: Scaffold(
                backgroundColor: Colors.white,
                body: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        alignment: Alignment.topCenter,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50.h,
                                ),
                                Image.asset(
                                  ImageRes.logo,
                                  height: 40.h,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                signInText(),
                                signInText02(),
                                SizedBox(
                                  height: 30.h,
                                ),
                                textLoginBoxWithDimensions(
                                    height: 45.h,
                                    width: 325.w,
                                    hintText: "Phone No.",
                                    prefixText: "+91 ",
                                    maxLength: 10,
                                    validateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      RegExp re = RegExp(r"^\d{10}$");
                                      if (!re.hasMatch(value!)) {
                                        return 'Please enter correct 10-digit phone number.';
                                      }
                                      return null;
                                    },
                                    controller: _controller.phoneNoController,
                                    keyboardType: TextInputType.number,
                                    func: (value) => ref
                                        .read(SignInNotifierProvider.notifier)
                                        .onUserPhoneNoChange(value)),
                                SizedBox(
                                  height: 300.h,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 29.w, right: 25.w),
                                    child: appButtons(
                                        buttonText: "Next",
                                        buttonColor: AppColors.primaryElement,
                                        buttonTextColor: AppColors.primaryText,
                                        buttonBorderWidth: 2.h,
                                        anyWayDoor: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            _controller.handleSignIn(ref);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        })),
                                SizedBox(
                                  height: 5.h,
                                ),
                                registerText03()
                              ],
                            ),
                          ),
                        ),
                      ))));
  }
}
