import 'package:dags_delivery_app/Common/widgets/text_widgets.dart';
import 'package:dags_delivery_app/Features/DeliveryPartnerScreen/Controller/DeliveryPartnerController.dart';
import 'package:dags_delivery_app/Features/DeliveryPartnerScreen/Provider/delivery_prt_notifier.dart';
import 'package:dags_delivery_app/Features/DeliveryPartnerScreen/view/widgets/delivery_prt_widgets.dart';
import 'package:dags_delivery_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common/utils/app_colors.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../../Common/widgets/app_text_fields.dart';

class DeliveryPartnerScreen extends ConsumerStatefulWidget {
  const DeliveryPartnerScreen({super.key});

  @override
  ConsumerState<DeliveryPartnerScreen> createState() =>
      _DeliveryPartnerScreenState();
}

class _DeliveryPartnerScreenState extends ConsumerState<DeliveryPartnerScreen> {
  late DeliveryPartnerController controller;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = DeliveryPartnerController();
    super.initState();
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
          body: Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.fromLTRB(0, 60.h, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    logoNew(size),
                    SizedBox(height: 5.h),
                    registerText(),
                    registerText02(),
                    SizedBox(height: 30.h),
                    textLoginBoxWithDimensions(
                        height: 45.h,
                        width: 325.w,
                        hintText: "Full Name",
                        keyboardType: TextInputType.name,
                        validateMode: AutovalidateMode.onUserInteraction,
                        capitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value!.startsWith(" ") || value.endsWith(" "))
                            return "Enter full name";
                          RegExp re = RegExp(r"^[A-Za-z ]{3,}$");
                          if (!re.hasMatch(value))
                            return "Enter your full name.";
                          return null;
                        },
                        func: (value) {
                          ref
                              .read(deliveryPrtNotifierProvider.notifier)
                              .onUserNameChange(value);
                        }),
                    SizedBox(height: 15.h),
                    textLoginBoxWithDimensions(
                        height: 45.h,
                        width: 325.w,
                        hintText: "Email Id",
                        keyboardType: TextInputType.emailAddress,
                        validateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.startsWith(" ") || value.endsWith(" "))
                            return "Enter a valid email";
                          if (value!.isEmpty)
                            return "Enter your email address.";
                          RegExp regex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!regex.hasMatch(value)) {
                            return 'Please enter correct email address';
                          }
                          return null;
                        },
                        func: (value) {
                          ref
                              .read(deliveryPrtNotifierProvider.notifier)
                              .onUserEmailChange(value);
                        }),
                    SizedBox(height: 15.h),
                    textLoginBoxWithDimensions(
                        height: 45.h,
                        width: 325.w,
                        hintText: "Phone No.",
                        prefixText: "+91 ",
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        validateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          RegExp re = RegExp(r"^\d{10}$");
                          if (!re.hasMatch(value!)) {
                            return 'Please enter correct 10-digit phone number.';
                          }
                          return null;
                        },
                        func: (value) {
                          ref
                              .read(deliveryPrtNotifierProvider.notifier)
                              .onUserPhoneNoChange(value);
                        }),
                    SizedBox(height: 15.h),
                    SizedBox(height: 100.h),
                    Container(
                        margin: EdgeInsets.only(left: 29.w, right: 25.w),
                        child: appButtons(
                            buttonText: "Next",
                            buttonColor: AppColors.primaryElement,
                            buttonTextColor: AppColors.primaryText,
                            buttonBorderWidth: 2.h,
                            anyWayDoor: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                controller.registerUser(ref);
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            })),
                    SizedBox(height: 5.h),
                    Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textcustomnormal(
                            text: "By clicking on Next you are agreeing to our",
                            align: TextAlign.center,
                            fontSize: 14,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500,
                          ),
                          GestureDetector(
                            onTap: () {
                              navKey.currentState?.pushNamed('/terms_scr');
                            },
                            child: textcustomnormal(
                              text: "Terms and conditions.",
                              align: TextAlign.center,
                              fontSize: 14,
                              fontfamily: "Inter",
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    registerText03(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
