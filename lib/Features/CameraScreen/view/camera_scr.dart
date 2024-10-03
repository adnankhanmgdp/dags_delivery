import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Common/utils/image_res.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../Controller/camera_controller.dart';
import '../provider/camera_notifier.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  File? image;
  String profilePic = "";
  late CameraController controller;
  bool isLoading = false;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 10,
          preferredCameraDevice: CameraDevice.front);
      if (image == null) return;
      final imageTemp = File(image.path);
      Uint8List _bytes = await imageTemp.readAsBytes();
      profilePic = base64.encode(_bytes);
      setState(() {
        this.image = imageTemp;
        ref.read(cameraNotifierProvider.notifier).changeState(true);
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to pick image due to $e error");
      }
    }
  }

  @override
  void initState() {
    controller = CameraController(ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final imagePicked = ref.watch(cameraNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200.h,
                  ),
                  imagePicked == true
                      ? Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(1.h),
                          width: 300.w,
                          height: 300.h,
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ))
                      : SizedBox(
                          width: 300.w,
                          height: 300.h,
                          child: Image.asset(
                            ImageRes.noprofileimage,
                            fit: BoxFit.cover,
                          )),
                  SizedBox(
                    height: 80.h,
                  ),
                  imagePicked == true
                      ? Center(
                          child: appButtons(
                              height: 45.h,
                              width: 350.w,
                              buttonTextColor: Colors.black,
                              buttonText: "Confirm",
                              buttonBorderWidth: 2.h,
                              anyWayDoor: () {
                                setState(() {
                                  isLoading= true;
                                });
                                controller.uploadProfilePic(profilePic);
                              }),
                        )
                      : Center(
                          child: appButtons(
                              height: 45.h,
                              width: 350.w,
                              buttonTextColor: Colors.black,
                              buttonText: "Pick Image",
                              buttonBorderWidth: 2.h,
                              anyWayDoor: () {
                                pickImage();
                              }),
                        )
                ],
              ),
      ),
    );
  }
}
