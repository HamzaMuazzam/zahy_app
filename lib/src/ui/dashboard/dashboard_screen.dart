import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/FCM.dart';
import 'package:musan_client/Plugins/bottom_nav_bar/animated_bottom_navigation_bar.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_screen.dart';
import 'package:musan_client/src/ui/order_booking_screens/car_location_screen.dart';
import 'package:musan_client/src/widgets/my_app_drawers.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:musan_client/utils/images.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      var dashboardProvider = Provider.of<DashboardProvider>(Get.context, listen: false);
      dashboardProvider.userID = value.getString(Finals.USER_ID);
      dashboardProvider.userName = value.getString(Finals.USER_NAME);
      dashboardProvider.initAnalytics();
      print("USerID: ${value.getString(Finals.USER_ID)}");
      dashboardProvider.initlizeRealTimeDatabase();

      // FCM(userID: value.getString(Finals.USER_ID),userTypeId: "1");
      Future.delayed(Duration(seconds: 2),(){
        ApiServices.getNotifications();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (builder, dashboardProvider, _) {
      return WillPopScope(
        onWillPop: dashboardProvider.onWillPop,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: themeColor,
            child: SvgPicture.asset("assets/logo_white.svg"),
            onPressed: () {},
          ),
          bottomNavigationBar: AnimatedBottomNavigationBar(
            leftCornerRadius: 20,
            elevation: 2,
            backgroundColor: Colors.white54,
            gapLocation: GapLocation.center,
            // gapWidth: 100,
            notchSmoothness: NotchSmoothness.defaultEdge,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(.5),
            iconSize: 15,
            icons:  [
              SvgPicture.asset("assets/home_icon.svg",height: 20,),
              SvgPicture.asset("assets/cart_icon.svg",height: 20,),
              SvgPicture.asset("assets/shopping_icon.svg",height: 20,),
              SvgPicture.asset("assets/menu_icon.svg",height: 20,),

            ],
            labels: const ["Home", "Team", "Stack", "Statics"],
            activeIndex: 0,
            onTap: (int index) {
              dashboardProvider.bottomBarCurrentIndex=index;

              setState(() {});
            },
          ),
          backgroundColor: Colors.white,
          key: dashboardProvider.dashboardBoardScaffoldKey,
          drawer: MyAppDrawers(),
          endDrawer: MyAppDrawers(),
          body: Container(
            child: Column(
              children: [
                Expanded(
                    child: dashboardProvider.childrens[dashboardProvider.bottomBarCurrentIndex]),
                // bottomNavigationBar(dashboardProvider),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Widget bottomNavigationBar(DashboardProvider dashboardProvider) {
  //   return Padding(
  //     padding: const EdgeInsets.all(15.0),
  //     child: Container(
  //       width: Get.width,
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border.all(color: Colors.grey.withOpacity(0.25), width: 1),
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(10),
  //         child: Row(
  //           children: [
  //             Expanded(
  //                 child: bottomWidget(
  //                     0, ''.tr, "assets/home_assets/HomeIcon.svg", dashboardProvider,
  //                     name: 'Home'.tr)),
  //             Expanded(
  //                 child: bottomWidget(
  //                     1, ''.tr, "assets/home_assets/OrderIcon.svg", dashboardProvider,
  //                     name: "Orders".tr)),
  //             Expanded(
  //                 child: bottomWidget(
  //                     10, ''.tr, "assets/home_assets/homeICentercon.svg", dashboardProvider,
  //                     name: 'Order'.tr, scale: 40)),
  //             Expanded(
  //                 child: bottomWidget(
  //                     2, ''.tr, "assets/home_assets/MyCarsIcon.svg", dashboardProvider,
  //                     name: "My Cars".tr)),
  //             // Expanded(child: bottomWidget( 3,''.tr, phoneIcon, dashboardProvider)),
  //
  //             Expanded(
  //                 child:
  //                     bottomWidget(6, ''.tr, 'assets/home_assets/ListIcon.svg', dashboardProvider)),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget bottomWidget(int index, String title, icon, DashboardProvider dashboardProvider,
      {double scale = 25, String name: ""}) {
    return GestureDetector(
      onTap: () {
        if (index != 10) {
          if (index == 6) {
            dashboardProvider.dashboardBoardScaffoldKey.currentState.openDrawer();
            return;
          }
          if (index == 3) {
            bottomSheetForHelpCall();
          } else if (index == 1) {
            dashboardProvider.bottomBarCurrentIndex = index;
          } else {
            print(index);
            dashboardProvider.bottomBarCurrentIndex = index;
          }
        } else if (index == 10) {
          // orderDialoge();
          bottomSheetForHelpCall();
        }
        setState(() {});
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 25,
              child: SvgPicture.asset(
                icon,
                height: scale,
                color: dashboardProvider.bottomBarCurrentIndex == index
                    ? themeColor
                    : index == 10
                        ? null
                        : icon_grey_color,
              ),
            ),
            dashboardProvider.bottomBarCurrentIndex == index
                ? Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      name,
                      style: TextStyle(color: blue, fontWeight: FontWeight.bold),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  orderDialoge() {
    Get.bottomSheet(Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          )),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 6,
                width: Get.width / 6,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                "Order Now".tr,
                style: TextStyle(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "Do you know what's the issue?".tr,
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        dashboardProvider.isTechnicianOrder = 0;
                        Get.to(CarLocationScreen(isTechnicianOrder: 0));
                      },
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade200, width: 1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "NO".tr,
                              style: TextStyle(
                                  color: Color(0xFFFFA000),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "I need help from a technician".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFFFFA000),
                                  fontSize: Get.height * 0.015,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        dashboardProvider.isTechnicianOrder = 1;

                        Get.to(CarLocationScreen(isTechnicianOrder: 1));
                      },
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade200, width: 1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "YES".tr,
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Proceed to\norder now".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: Get.height * 0.015,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Text(
                "If you don't know the issue, choose no and we will send you a technician to your location to help you identify the problem."
                    .tr,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueGrey, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    ));
  }
}
