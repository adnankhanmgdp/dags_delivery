import 'package:dags_delivery_app/Common/utils/LogisticModel.dart';
import 'package:dags_delivery_app/Features/ApiService/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Common/utils/image_res.dart';
import '../../../Common/widgets/app_bar.dart';
import '../../../Common/widgets/app_button_widgets.dart';
import '../../../Common/widgets/text_widgets.dart';
import '../../../main.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  Future<void> scanBarcodeNormal(String orderId, String orderStatus) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes == '-1') {
        if (kDebugMode) {
          debugPrint('User canceled the scan');
        }
        return; // Exit the function as no valid barcode was scanned
      }
      if (kDebugMode) {
        print('barcode response is -> $barcodeScanRes');
      }
      LogisticModel.secretKey = barcodeScanRes;

      if (orderStatus == 'readyToPickup') {
        final bool isSuccess =
            await ApiService.pickingUpFromUser(orderId, barcodeScanRes);
        if (isSuccess) {
          navKey.currentState
              ?.pushNamedAndRemoveUntil('/order_det_scr', (route) => false);
        }
      } else if (orderStatus == 'readyToDelivery') {
        final bool isSuccess =
            await ApiService.pickingUpFromVendor(orderId, barcodeScanRes);
        if (isSuccess) {
          navKey.currentState
              ?.pushNamedAndRemoveUntil('/order_det_scr', (route) => false);
        }
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      if (kDebugMode) {
        print(barcodeScanRes);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final orderId = data['orderId'];
    final dynamic orderStatus = data['orderStatus'];
    return Scaffold(
      appBar: buildAppBar(context: context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   width: 20.w,
              // ),
              // Container(
              //     margin: EdgeInsets.only(top: 30.h),
              //     child: IconButton(
              //       onPressed: () {
              //         Navigator.of(context).pop();
              //       },
              //       icon: Icon(
              //         Icons.arrow_back_ios,
              //         size: 30.h,
              //         color: Colors.black,
              //       ),
              // //     )),
              // SizedBox(
              //   width: 20.h,
              // ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0, 30.h, 0, 0),
                  child: const textcustomnormal(
                    text: "Scan Order Bar Code",
                    fontSize: 26,
                    fontfamily: "Inter",
                    fontWeight: FontWeight.w800,
                  )),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          SizedBox(
            height: 270.h,
            width: 400.w,
            child: Image.asset(
              ImageRes.barcodeimage,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          appButtons(
              height: 65.h,
              width: 330.w,
              buttonText: "SCAN BAR CODE",
              buttonTextColor: Colors.black,
              buttonBorderWidth: 2.h,
              anyWayDoor: () {
                scanBarcodeNormal(orderId!, orderStatus);
              })
        ],
      ),
    );
  }
}
