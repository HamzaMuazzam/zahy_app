import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/src/ui/dashboard/dashboard_screen.dart';
import 'package:musan_client/src/ui/splash/OnBoardingScreen.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _authStatus = 'Unknown';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (Platform.isIOS) {
      WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());
    }

    nextScreen();
  }

  Future<void> initPlugin() async {
    try {
      final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
      setState(() => _authStatus = '$status');
      if (status == TrackingStatus.notDetermined) {
        await Future.delayed(const Duration(milliseconds: 200));
        // Request system's tracking authorization dialog
        final TrackingStatus status = await AppTrackingTransparency.requestTrackingAuthorization();
        setState(() => _authStatus = '$status');
        // }
      }
    } on PlatformException {
      setState(() => _authStatus = 'PlatformException was thrown');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  nextScreen() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var object = sharedPreferences.get(Finals.USER_LOGGED_IN_OR_NOT);
    if (object == true) {
      // ApiServices.getFreshOrderByUserId(Get.context, sharedPreferences.getString(Finals.USER_ID));
      // ApiServices.getInProgressHomeOrders(Get.context, sharedPreferences.getString(Finals.USER_ID));
      // ApiServices.getAllReportsByUserID(sharedPreferences.getString(Finals.USER_ID));
      // ApiServices.getDiscountOffers();
    }

    Future.delayed(Duration(seconds: 3), () async {
      if (object == null || object == false) {
        Get.offAll(OnBoardingScreen());
      } else {
        Get.offAll(DashboardScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Image.asset(
        "assets/back.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
