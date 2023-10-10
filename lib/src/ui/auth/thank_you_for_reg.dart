import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/src/ui/dashboard/dashboard_screen.dart';

class ThankYouForReg extends StatefulWidget {
  const ThankYouForReg({key});

  @override
  State<ThankYouForReg> createState() => _ThankYouForRegState();
}

class _ThankYouForRegState extends State<ThankYouForReg> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(DashboardScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          SizedBox(
              height: 200,
              width: 200,
              child: Image.asset("assets/thank.png").paddingOnly(bottom: 20)),
          Text(
            "Your number has been successfully verified".tr,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
