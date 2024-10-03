import 'package:dags_delivery_app/Features/ApiService/api_service.dart';
import 'package:dags_delivery_app/Features/HelpSupportScreen/view/widgets/help_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Common/widgets/app_bar.dart';

import '../../../Common/widgets/text_widgets.dart';
import '../../ApiService/misc_models.dart';
import '../../TermsScreen/widgets/terms_scr_widgets.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List<Faq> faqList = [];
  bool isExpanded = false;
  int selectedIndex = -1;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      final charges = await ApiService.fetchCharges();
      setState(() {
        faqList = charges.faq;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching charges: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context: context),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              termsHeading("Help & Support"),
              SizedBox(
                height: 5.h,
              ),
              const dashLine(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    helpHeadingText(),
                    SizedBox(
                      height: 10.h,
                    ),
                    helpDescText(),
                    SizedBox(
                      height: 30.h,
                    ),
                    // customIconAppButton(
                    //   buttonText: "Search help",
                    //   buttonColor: const Color(0xfffff5dd),
                    //   buttonTextColor: Colors.grey.shade400,
                    //   height: 37.h,
                    //   width: 340.w,
                    //   buttonIcon: Icons.search,
                    //   anyWayDoor: () {},
                    //   buttonBorderWidth: 1.h,
                    // ),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    faqText(),
                    SizedBox(
                      height: 20.h,
                    ),
                    ListView.builder(
                      itemBuilder: (_, index) {
                        final newVar = faqList[index].answer.trim();
                        bool isSelected = false;
                        return faqList.isNotEmpty
                            ? questionRow(faqList[index].question, newVar,
                                index, isSelected)
                            : const Center(child: CircularProgressIndicator());
                      },
                      itemCount: faqList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Text(
                          textAlign: TextAlign.center,
                          "For any further enquiry or help contact"),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          await launchUrl(
                              Uri.parse('mailto:admin@dagstechnology.in'));
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
                      height: 50.h,
                    ),
                  ],
                ),
              )
            ]))));
  }

  Widget questionRow(
      String question, String answer, int index, bool isSelected) {
    bool isExpanded = (selectedIndex == index) ? true : false;
    return (isExpanded)
        ? GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = -1;
              });
            },
            child: Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.help,
                        color: Colors.blueGrey,
                        size: 25.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Container(
                          child: textcustomnormal(
                            text: question,
                            align: TextAlign.start,
                            fontSize: 15,
                            fontfamily: "Inter",
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: textcustomnormal(
                      align: TextAlign.start,
                      text: answer,
                      fontWeight: FontWeight.w400,
                      fontfamily: "Inter",
                      color: Colors.grey.shade500,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
          )
        : Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(bottom: 10.h),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.help,
                    color: Colors.blueGrey,
                    size: 25.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: textcustomnormal(
                      text: question,
                      align: TextAlign.start,
                      fontSize: 15,
                      fontfamily: "Inter",
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
