import 'package:dags_delivery_app/Common/utils/constants.dart';
import 'package:dags_delivery_app/Features/ProfileScreen/provider/logistic_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Common/Services/global.dart';
import '../../../Common/widgets/app_bar.dart';
import '../../../Common/widgets/app_shadow.dart';
import '../../../Common/widgets/image_widgets.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../../ProfileScreen/provider/logistic_data_model.dart';
import '../Controller/vendor_profile_controllers.dart';

class AccountsScreen extends ConsumerStatefulWidget {
  const AccountsScreen({super.key});

  @override
  ConsumerState<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends ConsumerState<AccountsScreen> {
  String logisticId = '';
  late LogisticProfileControllers controllers;
  String profilePicPath = '';
  final String phoneNumber =
      Global.storageServices.getString(AppConstants.userNumber);

  BankDetails? bankDetails;

  @override
  void initState() {
    ref.read(logisticProvider.notifier).fetchLogisticProfile();
    controllers = LogisticProfileControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logisticResponse = ref.watch(logisticProvider);
    final logisticProfile = logisticResponse?.logistic;
    final logisticBankDetails = logisticResponse?.bankDetails;
    if (logisticProfile != null) {
      controllers.logisticEmailController.text = logisticProfile.email;
      profilePicPath = logisticProfile.profilePic;
      logisticId = logisticProfile.logisticId;
    }
    if (logisticBankDetails != null) {
      bankDetails = logisticBankDetails;
    }
    debugPrint('${bankDetails?.accountHolderName}');
    return Scaffold(
        appBar: buildAppBar(context: context),
        body: (logisticProfile == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20.w, 15.h, 0, 0),
                      child: const textcustomnormal(
                        text: "Profile",
                        fontfamily: "Inter",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    dashLine(
                      color: Colors.grey.shade300,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 40.h, 0, 0),
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          circularProfileImage(
                              radius: 40.h, profilePicUrl: profilePicPath),
                          SizedBox(
                            height: 10.h,
                          ),
                          textcustomnormal(
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.black,
                            text: "Logistic: #$logisticId",
                          ),
                          // customIconAppButton(
                          //     width: 220.w,
                          //     height: 50.h,
                          //     buttonRadius: 20,
                          //     buttonColor: Colors.grey.shade200,
                          //     buttonText: "Edit Profile Picture",
                          //     buttonTextColor: const Color(0xffF14B4B),
                          //     borderColor: AppColors.primaryElement,
                          //     anyWayDoor: () {
                          //
                          //     }),
                          SizedBox(
                            height: 10.h,
                          ),
                          dashLine(
                            width: 200.w,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const textcustomnormal(
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.black,
                            text: "Delivery Partner Info",
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 0.h, left: 15.w),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 45.h,
                            decoration: appBoxDecoration(
                                color: Colors.grey.shade200,
                                radius: 10.h,
                                borderColor: Colors.grey.shade400),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                textcustomnormal(
                                  text: "UserName:",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontfamily: "Inter",
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                textcustomnormal(
                                  text: logisticProfile.name,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontfamily: "Inter",
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 0.h, left: 15.w),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 45.h,
                            decoration: appBoxDecoration(
                                color: Colors.grey.shade200,
                                radius: 10.h,
                                borderColor: Colors.grey.shade400),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                textcustomnormal(
                                  text: "Email:",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontfamily: "Inter",
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                SizedBox(
                                  width: 270.w,
                                  height: 45.h,
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller:
                                        controllers.logisticEmailController,
                                    // this is for decorating the text field
                                    decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(5.h, 3.h, 0, 3),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),

                                        ///this is the default border active when not focused
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),

                                        /// this is the focused border
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.transparent)),

                                        ///this will be used when a text field in disabled
                                        disabledBorder:
                                            const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.transparent))),
                                    maxLines: 1,
                                    autocorrect: false,
                                    readOnly: true,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Inter",
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 0.h, left: 15.w),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 45.h,
                            decoration: appBoxDecoration(
                                color: Colors.grey.shade200,
                                radius: 10.h,
                                borderColor: Colors.grey.shade400),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                textcustomnormal(
                                  text: "Phone No:",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontfamily: "Inter",
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                textcustomnormal(
                                  text: phoneNumber,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontfamily: "Inter",
                                  color: Colors.grey.shade600,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          const textcustomnormal(
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.black,
                            text: "Bank Details:",
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const textcustomnormal(
                                    fontfamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.black,
                                    text: "Account holder name:",
                                  ),
                                  Expanded(
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.black,
                                      ),
                                      "${bankDetails?.accountHolderName}",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const textcustomnormal(
                                    fontfamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    align: TextAlign.start,
                                    color: Colors.black,
                                    text: "Account number:",
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: textcustomnormal(
                                      fontfamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black,
                                      text: bankDetails?.accountNumber,
                                      align: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const textcustomnormal(
                                    fontfamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                    align: TextAlign.start,
                                    fontSize: 17,
                                    color: Colors.black,
                                    text: "Bank name:",
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: textcustomnormal(
                                      align: TextAlign.start,
                                      fontfamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black,
                                      text: bankDetails?.bankName,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const textcustomnormal(
                                    fontfamily: "Inter",
                                    align: TextAlign.start,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.black,
                                    text: "Branch:",
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: textcustomnormal(
                                        align: TextAlign.start,
                                        fontfamily: "Inter",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.black,
                                        text: "${bankDetails?.branch}"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const textcustomnormal(
                                    fontfamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    align: TextAlign.start,
                                    color: Colors.black,
                                    text: "IFSC code:",
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    child: textcustomnormal(
                                      align: TextAlign.start,
                                      fontfamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black,
                                      text: bankDetails?.ifsc,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          dashLine(
                            width: MediaQuery.of(context).size.width * 0.9,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Center(
                            child: Text(
                                textAlign: TextAlign.center,
                                "Your payments will be settled in the above bank account."),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Center(
                            child: Text(
                                textAlign: TextAlign.center,
                                "To update bank details kindly contact"),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                await launchUrl(Uri.parse(
                                    'mailto:admin@dagstechnology.in'));
                              },
                              child: Text(
                                textAlign: TextAlign.center,
                                "admin@dagstechnology.in",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}
