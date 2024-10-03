import 'package:dags_delivery_app/Features/ApiService/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common/widgets/app_bar.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  late InAppWebViewController webController;
  double pageProgress = 0;
  String? webContent;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    fetchData();
    super.didChangeDependencies();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final charges = await ApiService.fetchCharges();
      String initialString = charges.tnc;
      setState(() {
        webContent = """<html>
        <head> 
        <meta charset="UTF-8">
        <meta name="viewport" content ="width = device-width, user-scalable=no, initial-scale=1.0">
        </head>
        <body>
        $initialString
        </body>
        </html>""";
      });
      setState(() {
        isLoading = false;
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
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Stack(
                    children: [
                      (webContent != null)
                          ? InAppWebView(
                              initialData:
                                  InAppWebViewInitialData(data: webContent!),
                              onWebViewCreated:
                                  (InAppWebViewController controller) {
                                webController = controller;
                              },
                              onProgressChanged:
                                  (InAppWebViewController controller,
                                      int progress) {
                                setState(() {
                                  pageProgress = progress / 100;
                                });
                              })
                          : const Center(
                              child: Center(child: CircularProgressIndicator()),
                            ),
                    ],
                  ),
                ),
              ));
  }
}
