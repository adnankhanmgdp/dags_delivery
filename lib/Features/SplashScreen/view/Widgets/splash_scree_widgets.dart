import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Common/utils/image_res.dart';
import '../../../../Common/widgets/text_widgets.dart';


Widget logoContainer(Size size) {
  return ScreenUtilInit(
      designSize: Size(size.width, size.height),
      builder: (context, child) => Container(
            margin: EdgeInsets.fromLTRB(0, 80.h, 0, 0),
            alignment: Alignment.topCenter,
            child: SizedBox(child: Image.asset(ImageRes.logo)),
          ));
}
Widget imageStack(Size size) {
  return Stack(
    children: [
    textcustomnormal(
    text: "  Laundry delivery at doorstep",
    fontWeight: FontWeight.bold,
    fontSize: 26.w,
  ),
      ScreenUtilInit(
          designSize: Size(size.width, size.height),
          builder: (context,child)=>Container(
              height:550.h ,
              width: 600.w,
              padding: const EdgeInsets.all(2),
              alignment: Alignment.center,
              child: Image.asset(ImageRes.splashscrimage,fit: BoxFit.cover,))),
    ],
  );
}
