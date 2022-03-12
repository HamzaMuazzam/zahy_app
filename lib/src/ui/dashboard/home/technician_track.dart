import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
 import 'package:get/get.dart';
import 'package:musan_client/utils/colors.dart';

class TechnicianTrack extends StatefulWidget {
  @override
  _TechnicianTrackState createState() => _TechnicianTrackState();
}

class _TechnicianTrackState extends State<TechnicianTrack> {
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
          'Technician tracking'.tr,
          style: TextStyle(
            color: headingTextColor,
            fontSize: Get.height * .026,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: bottomButton(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * .06,
            vertical: Get.height * .01,
          ),
          child: Column(
            children: [
              Container(
                width: Get.width,
                margin: EdgeInsets.only(bottom: Get.height * .02),
                padding: EdgeInsets.symmetric(
                  vertical: Get.height * .02,
                  horizontal: Get.width * .05,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Order number 24230980'.tr,
                      style: TextStyle(
                        color: Color(0xff1E1E1E).withOpacity(.70),
                        fontSize: Get.height * .02,
                      ),
                    ),
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.symmetric(
                        vertical: Get.height * .015,
                        horizontal: Get.width * .1,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: Get.height * .015,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: themeColor, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: themeColor,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Street 43, Barcelona'.tr,
                            style: TextStyle(
                              color: themeColor,
                              fontSize: Get.height * .02,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff6F7D95),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Step 1'.tr,
                                style: TextStyle(
                                  color: Color(0xff1E1E1E).withOpacity(.50),
                                  fontSize: Get.height * .02,
                                ),
                              ),
                              SizedBox(height: 5),
                              FittedBox(
                                child: Text(
                                  'In progress'.tr,
                                  style: TextStyle(
                                    color: Color(0xffFFD037),
                                    fontSize: Get.height * .02,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashLength: 7.0,
                            dashColor: Color(0xff707070),
                            dashRadius: 0.0,
                            dashGapLength: 5.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffD7D7D7),
                                ),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.check,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Step 2'.tr,
                                style: TextStyle(
                                  color: Color(0xff1E1E1E).withOpacity(.50),
                                  fontSize: Get.height * .02,
                                ),
                              ),
                              SizedBox(height: 5),
                              FittedBox(
                                child: Text(
                                  'Complete'.tr,
                                  style: TextStyle(
                                    color: Colors.transparent,
                                    fontSize: Get.height * .02,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Timing'.tr,
                              style: TextStyle(
                                color: Color(0xff1E1E1E).withOpacity(.50),
                                fontSize: Get.height * .019,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '5 days'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: themeColor,
                                fontSize: Get.height * .026,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Cost'.tr,
                              style: TextStyle(
                                color: Color(0xff1E1E1E).withOpacity(.50),
                                fontSize: Get.height * .019,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '\$1000'.tr,
                              style: TextStyle(
                                color: themeColor,
                                fontWeight: FontWeight.w600,
                                fontSize: Get.height * .026,
                              ),
                            ),
                          ],
                        ),
                      ],
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

  bottomButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Get.height * .01,
        horizontal: Get.width * .06,
      ),
      child: Row(
        children: [
          Expanded(
            child: chatAndCallButton(
              'Chat'.tr,
              Icons.chat_sharp,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: chatAndCallButton(
              'Call'.tr,
              Icons.phone_callback_sharp,
            ),
          ),
        ],
      ),
    );
  }

  chatAndCallButton(String text, icon) {
    return Container(
      width: Get.width,
      height: Get.height * .065,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: themeColor,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 15),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: Get.height * .02,
            ),
          ),
        ],
      ),
    );
  }
}
