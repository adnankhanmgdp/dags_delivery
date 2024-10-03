import 'package:dags_delivery_app/Features/ProfileScreen/provider/logistic_profile_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common/Services/global.dart';
import '../../../Common/utils/constants.dart';
import '../../../Common/widgets/app_bar.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../../Common/widgets/image_widgets.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../../../main.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final bool fromNavigationBar;

  const ProfileScreen({super.key, required this.fromNavigationBar});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String name = '';
  String email = '';
  String profileUrl = '';

  @override
  void initState() {
    ref.read(logisticProvider.notifier).fetchLogisticProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool fromNavigation = widget.fromNavigationBar;
    if (kDebugMode) {
      print(fromNavigation);
    }
    final logisticResponse = ref.watch(logisticProvider);
    final logisticProfile = logisticResponse?.logistic;
    if (logisticProfile != null) {
      profileUrl = logisticProfile.profilePic;
      if (logisticProfile.name.isEmpty) {
        name = Global.storageServices.getString(AppConstants.userName);
      } else {
        name = logisticProfile.name;
      }
      if (logisticProfile.email.isEmpty) {
        email = Global.storageServices.getString(AppConstants.userEmail);
      } else {
        email = logisticProfile.email;
      }
    }
    final String phoneNumber =
        Global.storageServices.getString(AppConstants.userNumber);
    return WillPopScope(
      onWillPop: () async {
        if (!fromNavigation) {
          navKey.currentState
              ?.pushNamedAndRemoveUntil("/application_scr", (routes) => false);
        }
        return false;
      },
      child: Scaffold(
        appBar: fromNavigation
            ? buildAppBarWithoutActionAndLeading()
            : buildAppBarWithCustomLeadingNavigation(
                context: context,
                goToApplication: () {
                  navKey.currentState?.pushNamedAndRemoveUntil(
                      '/application', (route) => false);
                },
              ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              (logisticProfile == null)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15.w,
                        ),
                        circularProfileImage(
                            radius: 50.h, profilePicUrl: profileUrl),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            textcustomnormal(
                              text: name,
                              fontWeight: FontWeight.w600,
                              fontfamily: "Poppins",
                              color: Colors.black,
                              fontSize: 22,
                            ),
                            textcustomnormal(
                              text: phoneNumber,
                              fontWeight: FontWeight.w400,
                              fontfamily: "Poppins",
                              color: const Color(0xff6E6F79),
                              fontSize: 16,
                            ),
                            SizedBox(
                              width: 240.w,
                              child: Text(email,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Color(0xff6E6F79),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: "Inter")),
                            ),
                          ],
                        )
                      ],
                    ),
              SizedBox(
                height: 30.h,
              ),
              dashLine(width: 200.w, height: 1.h, color: Colors.grey.shade300),
              SizedBox(
                height: 15.h,
              ),
              documentsButtons(
                  buttonText: "Profile",
                  buttonIcon: Icons.perm_identity_outlined,
                  anyWayDoor: () {
                    navKey.currentState?.pushNamed("/account_scr");
                  }),
              SizedBox(
                height: 15.h,
              ),
              documentsButtons(
                  buttonText: "Terms and Conditions",
                  buttonIcon: Icons.rule_sharp,
                  anyWayDoor: () {
                    navKey.currentState?.pushNamed("/terms_scr");
                  }),
              SizedBox(
                height: 15.h,
              ),
              documentsButtons(
                  buttonText: "Help & Support",
                  buttonIcon: Icons.help_outline,
                  anyWayDoor: () {
                    navKey.currentState?.pushNamed("/help_scr");
                  }),
              SizedBox(
                height: 15.h,
              ),
              documentsButtons(
                  buttonText: "Sign Out",
                  buttonIcon: Icons.logout,
                  anyWayDoor: () {
                    Global.storageServices
                        .setBool(AppConstants.userLoggedInEarlier, false);
                    Global.storageServices
                        .setBool(AppConstants.userRegisteredEarlier, false);
                    Global.storageServices
                        .setBool(AppConstants.logisticVerified, false);
                    Global.storageServices.setBool(AppConstants.kycDone, false);
                    Global.storageServices
                        .setBool(AppConstants.isImageDone, false);
                    Global.storageServices
                        .setBool(AppConstants.isDocumentDone, false);
                    Global.storageServices
                        .setBool(AppConstants.userNumberSet, false);
                    Global.storageServices
                        .setString(AppConstants.logisticId, '');
                    Global.storageServices
                        .setString(AppConstants.userNumber, '');
                    Global.storageServices.setString(AppConstants.userName, '');
                    Global.storageServices
                        .setString(AppConstants.userEmail, '');
                    Global.storageServices.setBool(AppConstants.kycDone, false);
                    Global.storageServices
                        .setBool(AppConstants.logisticAvailable, false);
                    navKey.currentState
                        ?.pushNamedAndRemoveUntil("/login", (route) => false);
                  }),
              SizedBox(
                height: 40.h,
              ),
              Text("© DAGS Technology V1.0.1"),
              SizedBox(
                height: 50.h,
              ),
              // GestureDetector(
              //   onTap: () {
              //     navKey.currentState?.pushNamedAndRemoveUntil(
              //         "/application", (route) => false);
              //   },
              //   child: Container(
              //       height: 60.h,
              //       width: 60.w,
              //       alignment: Alignment.center,
              //       decoration: appBoxDecoration(
              //           radius: 20.h,
              //           color: AppColors.documentButtonBg,
              //           borderColor: AppColors.primaryElement),
              //       child: Image.asset(ImageRes.crossIcon)),
              // ),
              SizedBox(
                height: 60.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
