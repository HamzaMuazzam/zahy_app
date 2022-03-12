import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:musan_client/utils/colors.dart';

class HelpDetails extends StatefulWidget {
  String title;
  HelpDetails({this.title});
  @override
  _HelpDetailsState createState() => _HelpDetailsState();
}

class _HelpDetailsState extends State<HelpDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screenBgColor,
      bottomNavigationBar: bottomButton(),
      appBar: AppBar(
        backgroundColor: screenBgColor,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace, color: themeColor, size: 28),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(
            color: headingTextColor,
            fontSize: Get.height * .026,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              margin: EdgeInsets.symmetric(
                vertical: Get.height * .02,
                horizontal: Get.width * .06,
              ),
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .02,
                horizontal: Get.width * .04,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff000000).withOpacity(.13),
                    spreadRadius: .08,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'General Information'.tr,
                    style: TextStyle(
                      color: Colors.black.withOpacity(.70),
                      fontSize: Get.height * .019,
                    ),
                  ),
                  SizedBox(height: Get.height * .01),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut sed orci a mauris consequat dapibus sed non dolor. Sed a auctor leo, fringilla fringilla odio. Integer interdum orci sed tristique rhoncus. Vestibulum ut lacus in ex euismod tristique et ut odio. Curabitur congue at tellus id interdum. Duis ultrices quam leo, non ullamcorper orci aliquet imperdiet. Etiam ut volutpat quam. Mauris convallis orci mi, vel rutrum metus lacinia id. Maecenas molestie eu nibh a rhoncus. Mauris commodo, mauris eget consectetur sagittis, massa eros tristique libero, vitae bibendum leo ligula id nisl. Aliquam iaculis tellus fermentum eros auctor pellentesque. Praesent scelerisque odio lectus, eu faucibus augue consequat sit amet.',
                    style: TextStyle(
                      color: headingTextColor,
                      fontSize: Get.height * .019,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bottomButton() {
    return Container(
      width: Get.width,
      height: Get.height * .07,
      margin: EdgeInsets.symmetric(
        vertical: Get.height * .02,
        horizontal: Get.width * .06,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: themeColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(.13),
            spreadRadius: 1,
            blurRadius: 3,
          ),
        ],
      ),
      child: Text(
        'Call us'.tr,
        style: TextStyle(
          color: Colors.white,
          fontSize: Get.height * .02,
        ),
      ),
    );
  }
}
