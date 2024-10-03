import 'package:dags_delivery_app/Features/DeliveryPartnerScreen/view/delivery_prt_scr.dart';
import 'package:dags_delivery_app/Features/OrderConfirmOtpScreen/view/otp_order_scr.dart';
import 'package:dags_delivery_app/Features/SignIn/view/sign_in_scr.dart';
import 'package:dags_delivery_app/Features/otp%20screen/view/otp_scr.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../Features/AccountsScreen/view/accounts_scr.dart';
import '../../Features/CameraScreen/view/camera_scr.dart';
import '../../Features/DashboardScreen/View/dashboard_scr.dart';
import '../../Features/DeliverySuccessScreen/view/delivery_scs_scr.dart';
import '../../Features/HelpSupportScreen/view/help_support.dart';
import '../../Features/IDdetailScreen/view/id_detail_scr.dart';
import '../../Features/KycScreen/view/kyc_scr.dart';
import '../../Features/MapScreen/view/map_scr.dart';
import '../../Features/OrderDetailScreen/view/order_detail_scr.dart';
import '../../Features/ProfileScreen/view/profile.dart';
import '../../Features/ProofScreen/view/proof_scr.dart';
import '../../Features/ScanScreen/view/scanscreen.dart';
import '../../Features/SplashScreen/view/splash_scr_view.dart';
import '../../Features/TermsScreen/view/terms_scr.dart';
import '../../Features/VerificationSuccessScreen/view/verification_scs_scr.dart';
import '../../Features/VerifyingStayScreen/view/verifying_scr.dart';
import '../../Features/application/view/application.dart';
import '../Services/global.dart';
import 'appRoutes.dart';

class appPages {
  static List<RouteEntity> routes() {
    return [
      RouteEntity(
          path: AppRoutes.SPLASH,
          page: const ProviderScope(child: SplashScreen())),
      RouteEntity(
          path: AppRoutes.LOGIN,
          page: const ProviderScope(child: SignINScreen())),
      RouteEntity(
          path: AppRoutes.DELIVERYPARTNER,
          page: const ProviderScope(child: DeliveryPartnerScreen())),
      RouteEntity(
          path: AppRoutes.APPLICATION,
          page: const ProviderScope(child: Application())),
      RouteEntity(
          path: AppRoutes.KYC, page: const ProviderScope(child: KycScreen())),
      RouteEntity(
          path: AppRoutes.OTP, page: const ProviderScope(child: OtpScreen())),
      RouteEntity(
          path: AppRoutes.ORDEROTP,
          page: const ProviderScope(child: OtpOrderScreen())),
      RouteEntity(
          path: AppRoutes.PROOF,
          page: const ProviderScope(child: ProofScreen())),
      RouteEntity(
          path: AppRoutes.CAMERA,
          page: const ProviderScope(child: CameraScreen())),
      RouteEntity(
          path: AppRoutes.VERIFY,
          page: const ProviderScope(child: VerifyingScreen())),
      RouteEntity(
          path: AppRoutes.VERIFYSCS,
          page: const ProviderScope(child: VerifyingSuccessScreen())),
      RouteEntity(
          path: AppRoutes.DELIVERYSCS,
          page: const ProviderScope(child: DeliverySuccessScreen())),
      RouteEntity(
          path: AppRoutes.IDDETAILSCS,
          page: const ProviderScope(child: IDDetails())),
      RouteEntity(
          path: AppRoutes.ORDERDETAILSSCS,
          page: const ProviderScope(child: OrderDetails())),
      RouteEntity(
          path: AppRoutes.DASHBOARDSSCS,
          page: const ProviderScope(child: DashBoardScreen())),
      RouteEntity(
          path: AppRoutes.PROFILESCR,
          page: const ProviderScope(
              child: ProfileScreen(
            fromNavigationBar: false,
          ))),
      RouteEntity(
          path: AppRoutes.MAPSCR,
          page: ProviderScope(
              child: MapScreen(
            initialLocation: LatLng(0, 0),
            orderStatus: '',
          ))),
      RouteEntity(
          path: AppRoutes.TERMSSCR,
          page: const ProviderScope(child: TermsScreen())),
      RouteEntity(
          path: AppRoutes.HELPSCR,
          page: const ProviderScope(child: HelpScreen())),
      RouteEntity(
          path: AppRoutes.SCANSCR,
          page: const ProviderScope(child: ScanScreen())),
      RouteEntity(
          path: AppRoutes.ACCOUNTSSCR,
          page: const ProviderScope(child: AccountsScreen())),
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      print('current route name is ${settings.name}');
    }
    if (settings.name != null) {
      var result = routes().where((element) => element.path == settings.name);

      bool userRegisteredEarlier =
          Global.storageServices.getUserRegisteredEarlier();
      bool userLoggedIn = Global.storageServices.getUserLoggedInEarlier();

      bool kycDoneEarlier = Global.storageServices.getKycDoneEarlier();

      if (result.first.path == AppRoutes.DELIVERYPARTNER &&
          userRegisteredEarlier) {
        if (kDebugMode) {
          print('user registered');
        }
        if (kycDoneEarlier) {
          return MaterialPageRoute(
              builder: (_) => const ProviderScope(child: Application()),
              settings: settings);
        } else {
          return MaterialPageRoute(
              builder: (_) => const ProviderScope(child: KycScreen()),
              settings: settings);
        }
      } else if (result.first.path == AppRoutes.LOGIN && userLoggedIn) {
        return MaterialPageRoute(
            builder: (_) => const ProviderScope(child: Application()),
            settings: settings);
      } else {
        if (kDebugMode) {
          print('mamla locha hai');
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (_) => const ProviderScope(child: SplashScreen()),
        settings: settings);
  }
}

class RouteEntity {
  String path;
  Widget page;

  RouteEntity({required this.path, required this.page});
}
