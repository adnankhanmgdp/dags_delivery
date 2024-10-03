import 'package:dags_delivery_app/Features/KycScreen/view/widgets/kyc_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Common/Services/global.dart';
import '../../../Common/utils/app_colors.dart';
import '../../../Common/utils/constants.dart';
import '../../../Common/utils/image_res.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../../Common/widgets/app_shadow.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../../../main.dart';

class KycScreen extends ConsumerStatefulWidget {
  const KycScreen({super.key});

  @override
  ConsumerState<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends ConsumerState<KycScreen> {
  late bool isImageDone;
  late bool isDocumentDone;

  @override
  void initState() {
    isImageDone = Global.storageServices.getImageDone();
    isDocumentDone = Global.storageServices.getDocumentDone();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isImageDone && isDocumentDone) {
      Future.delayed(const Duration(seconds: 2), () {
        Global.storageServices.setBool(AppConstants.kycDone, true);
        Global.storageServices.setBool(AppConstants.userNumberSet, true);
        navKey.currentState
            ?.pushNamedAndRemoveUntil("/verify_scr", (route) => false);
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool secondTime = Global.storageServices.getKycDoneEarlier();
    if (kDebugMode) {
      print(secondTime);
    }
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        logoNew(size),
                        SizedBox(
                          height: 5.h,
                        ),
                        kycText(),
                        SizedBox(
                          height: 3.h,
                        ),
                        kycText02(),
                        SizedBox(
                          height: 30.h,
                        ),
                        SizedBox(
                          height: 210.h,
                        ),
                        ListView.builder(
                          itemBuilder: (_, index) {
                            return kycButton(index);
                          },
                          itemCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            debugPrint('button is pressed');
                            showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(5.0)),
                              ),
                              builder: (BuildContext context) {
                                return Container(
                                  height: 300.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 10.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textcustomnormal(
                                        fontSize: 14,
                                        fontfamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade700,
                                        align: TextAlign.left,
                                        text:
                                            "1. To confirm that the person applying is who they claim to be, preventing fraud and ensuring that a genuine individual is being onboarded.",
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      textcustomnormal(
                                        fontSize: 14,
                                        fontfamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade700,
                                        align: TextAlign.left,
                                        text:
                                            "2. To perform background checks, which might include criminal history, driving records, and other verifications necessary to ensure the safety and reliability of the delivery service.",
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      textcustomnormal(
                                        fontSize: 14,
                                        fontfamily: "Inter",
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade700,
                                        align: TextAlign.left,
                                        text:
                                            "3. Ensuring that Vendors are verified builds trust with customers, who can feel safe knowing that the people delivering their goods have been properly vetted.",
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: textUnderline(text: "Why is this needed?"),
                        )
                      ],
                    ),
                  ),
                ))));
  }

  Widget kycButton(int index) {
    String buttonText = "";
    Color buttonColor = AppColors.documentButtonBg;
    if (index == 0) {
      buttonText = "Take a picture of your valid ID";
      if (isDocumentDone) {
        buttonColor = Colors.green;
      } else {
        buttonColor = AppColors.documentButtonBg;
      }
    } else if (index == 1) {
      buttonText = "Take a selfie of yourself";
      if (isImageDone) {
        buttonColor = Colors.green;
      } else {
        buttonColor = AppColors.documentButtonBg;
      }
    }
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          navKey.currentState?.pushNamed('/proof_scr');
        } else if (index == 1) {
          navKey.currentState?.pushNamed('/camera_scr');
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 20.h, left: 10.h, right: 10.h),
        height: 55,
        width: 350,
        decoration: appBoxDecoration(
            color: buttonColor,
            borderWidth: 1.h,
            radius: 10.w,
            borderColor: Colors.grey.shade400),
        child: Row(
          children: [
            Container(
                height: 40.h,
                width: 40.w,
                decoration: appBoxDecoration(
                    color: const Color(0xfffff0ce),
                    radius: 7.w,
                    borderWidth: 0.0,
                    borderColor: Colors.white),
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10.w),
                child: Image.asset(ImageRes.aadharIcon)),
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
}
