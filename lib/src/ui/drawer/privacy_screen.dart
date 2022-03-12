import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musan_client/src/ui/dashboard/notification_screen.dart';
import 'package:musan_client/utils/colors.dart';
class PrivacyScreen extends StatefulWidget {
  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBgColor,
      appBar: AppBar(
        backgroundColor: screenBgColor,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: themeColor, size: 28),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        title: Text(
          'Privacy'.tr,
          style: TextStyle(
            color: headingTextColor,
            fontSize: Get.height * .026,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
        child: Column(
          children: [
            privacyWidget(1, 'Notifications'.tr),
            // privacyWidget(2, 'Location'.tr),
          ],
        ),
      ),
    );
  }

  Widget privacyWidget(int index, String name) {
    return GestureDetector(
      onTap: () {
        index == 1 ? Get.to(NotificationScreen()) : null;
      },
      child: Container(
        width: Get.width,
        margin: EdgeInsets.only(
          bottom: Get.height * .01,
          top: Get.height * .01,
        ),
        padding: EdgeInsets.symmetric(
          vertical: Get.height * .025,
          horizontal: Get.width * .06,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000).withOpacity(.13),
              spreadRadius: .08,
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                color: headingTextColor,
                fontSize: Get.height * .02,
                fontWeight: FontWeight.w600,
              ),
            ),
            index == 1
                ? SizedBox()
                : Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: headingTextColor,
                    size: 12,
                  )
          ],
        ),
      ),
    );
  }
}
