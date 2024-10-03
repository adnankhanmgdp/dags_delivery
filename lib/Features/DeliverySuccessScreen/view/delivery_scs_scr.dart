import 'package:flutter/material.dart';

import '../../../Common/utils/image_res.dart';

class DeliverySuccessScreen extends StatelessWidget {
  const DeliverySuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 430,
                height: 760,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      top: 150,
                      child: SizedBox(
                        width: 420,
                        height: 404,
                        child: Image.asset(ImageRes.deliveryscsimage,fit: BoxFit.fill,),
                      ),
                    ),
                    const Positioned(
                      left: 50,
                      top: 50,
                      child: SizedBox(
                        width: 295,
                        child: Text(
                          'Delivery Successful!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF2D2B2E),
                            fontSize: 36,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.80,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 110,
                      top: 520,
                      child: SizedBox(
                        width: 171,
                        height: 49,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 28,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.only(left: 3, right: 5),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'You drived',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF5F5F5F),
                                        fontSize: 18,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 0,
                              top: 22,
                              child: SizedBox(
                                width: 171,
                                height: 27,
                                child: Text(
                                  '25 min (7.9 km) \n',
                                  style: TextStyle(
                                    color: Color(0xFF1C254E),
                                    fontSize: 22,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 100,
                      top: 590,
                      child: SizedBox(
                        width: 171,
                        height: 49,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 28,
                              top: 0,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'You earnings',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF5F5F5F),
                                      fontSize: 18,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 25,
                              child: SizedBox(
                                width: 171,
                                height: 27,
                                child: Text(
                                  ' ₹ 149.48 \n',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF1C254E),
                                    fontSize: 22,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: 670,
                      child: Container(
                        width: 345,
                        height: 54,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFCC57),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1.70, color: Color(0xFF3F3F3F)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Home',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF1C254E),
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
