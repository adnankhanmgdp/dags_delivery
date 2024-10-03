import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../Provider/proof_notifier.dart';
import '../Widgets/proof_widgets.dart';
import '../controller/proof_controller.dart';

class ProofScreen extends ConsumerStatefulWidget {
  const ProofScreen({super.key});

  @override
  ConsumerState<ProofScreen> createState() => _ProofScreenState();
}

class _ProofScreenState extends ConsumerState<ProofScreen> {
  File? image;
  bool isClicked = false;
  String documentImage = "";
  late ProofController controller;
  String docType = '';

  Future pickImage(int index) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
      if (image == null) return;
      final imageTemp = File(image.path);
      Uint8List _bytes = await imageTemp.readAsBytes();
      documentImage = base64.encode(_bytes);
      if (index == 0) {
        docType = 'Aadhar Card';
      } else if (index == 1) {
        docType = 'Pan Card';
      } else {
        docType = 'Driving License';
      }
      setState(() {
        this.image = imageTemp;
        ref.read(proofNotifierProvider.notifier).changeState(index);
        isClicked = true;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to pick image due to $e error");
      }
    }
  }

  @override
  void initState() {
    controller = ProofController(ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ScreenHeight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;
    final index = ref.watch(proofNotifierProvider);
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
                        proofText(),
                        SizedBox(
                          height: 3.h,
                        ),
                        proofText02(),
                        SizedBox(
                          height: 30.h,
                        ),
                        !isClicked
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 210.h,
                                  ),
                                  documentsButtons01(
                                      anyWayDoor: () {
                                        pickImage(1);
                                      },
                                      ref: ref),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  documentsButtons02(
                                      anyWayDoor: () {
                                        pickImage(2);
                                      },
                                      ref: ref),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  documentsButtons03(
                                      anyWayDoor: () {
                                        pickImage(3);
                                      },
                                      ref: ref),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      debugPrint('button is pressed');
                                      showModalBottomSheet(
                                        context: context,
                                        useSafeArea: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10.0)),
                                        ),
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 150.h,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 20.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                textcustomnormal(
                                                    fontSize: 15,
                                                    fontfamily: "Inter",
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey.shade700,
                                                    align: TextAlign.left,
                                                    text:
                                                        "For any technical support or any query contact"),
                                                GestureDetector(
                                                  onTap: () async {
                                                    await launchUrl(Uri.parse(
                                                        'mailto:admin@dagstechnology.in'));
                                                  },
                                                  child: textcustomnormal(
                                                      fontSize: 16,
                                                      fontfamily: "Inter",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black,
                                                      align: TextAlign.left,
                                                      text:
                                                          "admin@dagstechnology.in"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: textUnderline(text: "Need Help??"),
                                  )
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 300.h,
                                    width: 300.h,
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  appButtons(
                                      buttonText: "Confirm",
                                      height: 45.h,
                                      width: 350.w,
                                      buttonBorderWidth: 2.h,
                                      buttonTextColor: Colors.black,
                                      anyWayDoor: () {
                                        controller.uploadDocuments(
                                            documentImage, docType);
                                      }),
                                ],
                              )
                      ],
                    ),
                  ),
                ))));
  }
}
