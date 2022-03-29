import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/CashBackScreen.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/new_desgin_login/Signup.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/dashboard/notification_screen.dart';
import 'package:musan_client/src/ui/drawer/AboutUsScreen.dart';
import 'package:musan_client/src/ui/drawer/TermsConditions.dart';
import 'package:musan_client/src/ui/drawer/invite_screen.dart';
import 'package:musan_client/src/ui/drawer/payments_screen.dart';
import 'package:musan_client/src/ui/drawer/setting_screen.dart';
import 'package:musan_client/src/ui/order_booking_screens/utils.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/images.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppDrawers extends StatefulWidget {
  @override
  _MyAppDrawersState createState() => _MyAppDrawersState();
}

class _MyAppDrawersState extends State<MyAppDrawers> {
  var dashboardProvider = Provider.of<DashboardProvider>(Get.context,listen: false);

  @override
  void initState() {
    dashboardProvider.isUserProfileLoaded=false;
    if(dashboardProvider.isUserProfileLoaded){


    }else{
      ApiServices.loadUserProfile(dashboardProvider.userID);


    }



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (builder,data,child){
      return Container(
        width: Get.width,
        color: Colors.white,
        child: Drawer(
          child: Container(
            color: screenBgColor,
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * .06,

            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height * .03),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.clear,
                          color: headingTextColor,
                        ),
                      ),
                      SizedBox(height: Get.height * .02),
                        Row(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Column(children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                colorFilter: ColorFilter.mode(Colors.blue, BlendMode.color),
                                image: NetworkImage(
                                    data.isUserProfileLoaded ?
                                    data.userProfileFromJson.result.displayPicture== null ?
                                    "https://tamam.com.pk/profileimage_placeholder.png" :
                                    "${"https://muapi.deeps.info/"+data.userProfileFromJson.result.displayPicture}" :" "),
                                fit: BoxFit.fill),


                          ),


                        ),
                        SizedBox(height: 12,),
                        Text(data.isUserProfileLoaded ? data.userProfileFromJson.result.name : " ",
                        // Text("حمزة معظم",
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w900,
                            fontSize: Get.height * .025,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(data.isUserProfileLoaded ? data.userProfileFromJson.result.phoneNumber : "",

                            style: TextStyle(color: textColor,fontSize: 16),
                          ),
                        ),
                      ],)
                    ],),

                      SizedBox(height: Get.height * .035),
                      // mainWidget(1, 'Wallet'.tr, "assets/drawer_icons/WalletIcon.svg"),
                      mainWidget(10, 'Cashback'.tr, "assets/drawer_icons/CashBackIcon.svg"),
                      // mainWidget(2, 'My Cars'.tr, drawerCarIcon),
                      mainWidget(3, 'Settings'.tr, "assets/drawer_icons/SettingsIcon.svg"),
                      mainWidget(4, 'Terms'.tr, "assets/drawer_icons/TermsIcon.svg"),
                      mainWidget(5, 'Invite'.tr, "assets/drawer_icons/InviteIcon.svg"),
                      mainWidget(8, 'Help'.tr, "assets/drawer_icons/HelpIcon.svg",scale: 4.5),
                      // mainWidget(9, 'Notifications'.tr, notificationImage,scale: 4.5),
                      // mainWidget(6, 'About us'.tr, "assets/images/drawerAboutIcon.png"),
                    ],
                  ),
                  mainWidget(7, 'Log out'.tr, "assets/drawer_icons/LogoutIcon.svg"),
                ],
              ),
            ),
          ),
        ),
      );
    },);
  }


  Widget mainWidget(int index, String name, image,{double scale:1.3}) {
    return GestureDetector(
      onTap: () {
        index == 3
            ? Get.to(SettingScreen())
            : index == 1
                ? Get.to(PaymentsScreen())
                    : index == 4
                      ? Get.to(TermsConditions())
                        : index == 8
                          ? bottomSheetForHelpCall()
                              : index == 9
                                   ? Get.to(NotificationScreen())
                                        : index == 5
                                            ? Get.to(InviteCodeScreen())
                                                : index == 6
                                                    ? Get.to(AboutUsScreen())
                                                  : index == 10
                                                    ? Get.to(CashBackScreen())
                                                       : index == 7
                                                          ? logOut()
                                                            : null;
      },
      child: Container(
        // color: Colors.transparent,
        margin: EdgeInsets.only(bottom: Get.height * .02),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 45,
              height: 45,
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   border: Border.all(color: Color(0xffF1F3F5), width: 1),
              //   borderRadius: BorderRadius.circular(5),
              //   boxShadow: [
              //     BoxShadow(
              //       color: Color(0xff000000).withOpacity(.13),
              //       spreadRadius: 1,
              //       blurRadius: 3,
              //     ),
              //   ],
              // ),
              child: Center(
                child:SvgPicture.asset(image,color: Color(0xff000000),),
              ),
            ),
            SizedBox(width: 15),
            Text(
              name,
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.w500,
                fontSize: Get.height * .023,
              ),
            ),
          ],
        ),
      ),
    );
  }

  logOut() {
    SharedPreferences.getInstance().then((value) {
      value.clear().then((value){
        Get.offAll(Signup());
      });
    });

  }
}
bottomSheetForHelpCall() {
  Get.back();
  if (Get.isBottomSheetOpen) {
    Get.back();
  }
  Get.bottomSheet(
      Consumer<DashboardProvider>(builder: (builder, data, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .02,
                horizontal: Get.width * .06,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Get.width * .2,
                    child: Divider(
                      thickness: 5,
                      color: Color(0xffF1F1F1),
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Text(
                    "Call us".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Get.height * .022,
                      color: headingTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * .02),
                  Text(
                    "call now and talk to our representative".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Get.height * .02,
                      fontWeight: FontWeight.w600,
                      color: headingTextColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      launch("tel://+966507888779");

                    },
                    child: Container(
                      width: Get.width,
                      height: Get.height * .065,
                      margin: EdgeInsets.symmetric(vertical: Get.height * .02),
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
                      child: Center(
                        child: Text(
                          'Call'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel'.tr,
                      style: TextStyle(
                        color: themeColor,
                        fontSize: Get.height * .02,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      }), isDismissible: true);
}
