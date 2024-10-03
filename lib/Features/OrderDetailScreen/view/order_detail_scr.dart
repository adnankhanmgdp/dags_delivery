import 'package:dags_delivery_app/Features/OrderDetailScreen/view/active_orders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Common/Services/global.dart';
import '../../../Common/utils/app_colors.dart';
import '../../../Common/widgets/app_bar.dart';
import '../../../Common/widgets/app_shadow.dart';
import '../../../Common/widgets/text_widgets.dart';
import 'past_orders.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String lastDigitsOfOrder = '';
  bool isAvailable = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    isAvailable = Global.storageServices.getLogisticAvailable();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onIconPressed() {
    if (_controller.text.length == 4) {
      setState(() {
        lastDigitsOfOrder = _controller.text;
      });
    }else if(_controller.text.isEmpty){
      setState(() {
        lastDigitsOfOrder = '';
      });
    } else {
      Fluttertoast.showToast(
        msg: "Please enter last 4 digits of orderId",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.primaryElement,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: buildAppBarWithAction(),
          body: isAvailable?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Orders',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1d254e),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 230.w,
                    height: 40.h,
                    margin: EdgeInsets.only(right: 10.w),
                    decoration: appBoxDecoration(
                      color: Colors.white,
                      radius: 10.w,
                      borderColor: Colors.black,
                      borderWidth: 1.0.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _controller,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10.h, 3.h, 0, 3),
                              hintText: "Last 4 digits of Id",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade500,
                                fontFamily: "Inter",
                              ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)),
                              disabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent)),
                            ),
                            maxLines: 1,
                            autocorrect: false,
                            obscureText: false,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: onIconPressed,
                            icon: Icon(
                              Icons.forward,
                              size: 25.h,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              dashLine(
                color: Colors.grey.shade300,
              ),
              const TabBar(
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  color: Color(0xff1d254e),
                ),
                tabs: [
                  Tab(text: 'Active Orders'),
                  Tab(text: 'Past Orders'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ActiveOrders(lastOrderNumbers: lastDigitsOfOrder),
                    PastOrders(lastOrderNumbers: lastDigitsOfOrder),
                  ],
                ),
              ),
            ],
          ):Center(
            child: textcustomnormal(
              text: "You are offline",
              fontSize: 20,
              fontfamily: "Inter",
              fontWeight: FontWeight.w600,
            ),
          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            setState(() {
              lastDigitsOfOrder = '';
            });
          },backgroundColor: AppColors.primaryElement,
          child: const Icon(Icons.refresh),),
        ),
      ),
    );
  }
}
