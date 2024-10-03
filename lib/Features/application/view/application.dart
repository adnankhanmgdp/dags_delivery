import 'package:dags_delivery_app/Features/application/view/widgets/application_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Common/widgets/app_shadow.dart';
import '../provider/applicationprovider.dart';

class Application extends ConsumerStatefulWidget {
  const Application({super.key});

  @override
  ConsumerState<Application> createState() => _ApplicationState();
}

class _ApplicationState extends ConsumerState<Application> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Screenheight = MediaQuery.of(context).size.height;
    final ScreenWidth = MediaQuery.of(context).size.width;

    final index = ref.watch(applicationNotifierProvider);
    return ScreenUtilInit(
      designSize: Size(ScreenWidth, Screenheight),
      builder: (context, child) => Container(
        color: Colors.white,
        child: Scaffold(
          body: Center(child: appScreens(index: index)),
          bottomNavigationBar: Container(
            width: 300.w,
            height: 110.h,
            decoration:
                appBoxShadowWithUnidirectionalRadius(color: Colors.grey),
            child: BottomNavigationBar(
              currentIndex: index,
              onTap: (value) {
                ref
                    .read(applicationNotifierProvider.notifier)
                    .changeIndex(value);
              },
              items: bottomTabs,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ),
        ),
      ),
    );
  }
}
