import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:musan_client/CashBackScreen.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/api_services/response_models/GetDiscountOffers.dart';
import 'package:musan_client/api_services/response_models/GetMyCarsByUserId.dart'
as report;
import 'package:musan_client/api_services/response_models/OfferOrderCustomReponse.dart';
import 'package:musan_client/slider/carousel_slider.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/src/ui/dashboard/home/order_from_service.dart';
import 'package:musan_client/src/ui/dashboard/notification_screen.dart';
import 'package:musan_client/src/ui/dashboard/orders/OrderDetails.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_tracking.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_tracking_new.dart';
import 'package:musan_client/src/ui/order_booking_screens/car_location_screen.dart';
import 'package:musan_client/src/widgets/my_app_drawers.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:musan_client/utils/my_textstyle.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../OrderOfferScreen.dart';
import '../DiscountList.dart';
import 'package:musan_client/api_services/response_models/GetCompletedOrInProgressOrderByUserId.dart'
as GetcompletedOrders;
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart'
as Results;

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var orderProvider =
Provider.of<OrderScreenProvider>(Get.context, listen: false);

class _HomeScreenState extends State<HomeScreen> {
  var dashboardProvider =
  Provider.of<DashboardProvider>(Get.context, listen: false);
  var orderScreenProvider =
  Provider.of<OrderScreenProvider>(Get.context, listen: false);
  String couponCode = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      await ApiServices.getCashBack();
      ApiServices.getCashBackValueOfCoupon();
    });
    SharedPreferences.getInstance().then((value) {
      dashboardProvider.setUserId(value.getString(Finals.USER_ID));
      couponCode = value.getString(
        Finals.USER_COUPON,
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Consumer<DashboardProvider>(builder: (builder, data, _) {
      return Container(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.width * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(

                decoration: BoxDecoration(
                    border: Border.all(width: 0.75),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Center(
                              child: Text(
                                "مُصان "
                                    "لخدمات السيارات",
                                style: TextStyle(
                                    fontSize: Get.width * 0.055,
                                    fontWeight: FontWeight.w900),
                              )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(CashBackScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/home_assets/Wallet.svg',
                                color: black,
                                // height: 55,
                                // scale: 0.3,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "${data.isCashBackLoaded &&
                                        data.promotionCashBackFromJson != null
                                        ? "${data.promotionCashBackFromJson
                                        .result.amount}"
                                        : "0"} ",
                                    style: TextStyle(
                                        height: 1.45,
                                        letterSpacing: 1.0,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: midGrey),
                                  ),
                                  Text(
                                    "${"SAR".tr}",
                                    style: TextStyle(
                                        fontSize: 10,
                                        height: 1.45,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.bold,
                                        color: midGrey),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      /*SizedBox(width: 5,),
                    Expanded(child: Row(
                      children: [
                        InkWell(onTap: (){
                          Get.to(CashBackScreen());
                        },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/home_assets/Wallet.svg',
                                  color: black,
                                  // height: 55,
                                  // scale: 0.3,
                                ),
                                SizedBox(width: 5,),
                                Text("${"SAR".tr}",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.black),),
                                Text("${data.isCashBackLoaded && data. promotionCashBackFromJson!=null? "${data.promotionCashBackFromJson.result.amount}":"0"} ",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
                              ],
                            ),
                          ),
                        ),
                        Center(child: Text("مُصان لخدمات صيانة السيارات")),
                      ],
                    )),
                    InkWell(
                      onTap: (){
                        Get.to(NotificationScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/home_assets/bell.svg',
                          color: black
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),*/
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "مرحباً ${data.userName}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Get.width * 0.055,
                    fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "ايش محتاج؟",
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: Get.width * 0.045,
                    height: 1.2,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: Column(
                  children: [
                    Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 15),
                          child: InkWell(
                            onTap: () {
                              dashboardProvider.isTechnicianOrder = 1;
                              Get.to(CarLocationScreen(isTechnicianOrder: 1));
                            },
                            child: Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            "أفضل ورشه\nلصيانة السيارة",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "noto_all",
                                              fontSize: Get.width * 0.065,
                                              fontWeight: FontWeight.w900,
                                              height: 1.45,
                                              letterSpacing: 1.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        child: Image.asset(
                                          "assets/home_assets/Background1.png",
                                          fit: BoxFit.fill,
                                          height: Get.width * 0.25,
                                        ),
                                      )),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xffE8BC2A),
                                  borderRadius: BorderRadius.circular(18)),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 10, bottom: 10),
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xff858585),
                                            borderRadius: BorderRadius.circular(
                                                18)),
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    bottomForComingSoon(
                                                        "Technician service".tr,
                                                        "This service will be available soon"
                                                            "\nWe are testing the technician to make the best check car service for you"
                                                            "\nYou can call us directly to take a free consultation at 0507888779"
                                                            .tr);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15),
                                                    child: Container(
                                                      width: Get.width,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            "فني زائر",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                height: 1.48,
                                                                letterSpacing: 1.0,
                                                                fontSize: Get
                                                                    .width *
                                                                    0.06,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "لفحص السيارة",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: Get
                                                                    .width *
                                                                    0.055,
                                                                height: 1.45,
                                                                letterSpacing: 1.0,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                            Container(
                                              child: Image.asset(
                                                "assets/home_assets/Background3.png",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: InkWell(
                                        onTap: () {
                                          bottomForComingSoon(
                                              "Pickup service".tr,
                                              "This service will be available so soon.\n"
                                                  "We are collecting the best car pickups for you, please keep in touch."
                                                  .tr);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xff419FCF),
                                              borderRadius: BorderRadius
                                                  .circular(18)),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15),
                                                    child: Container(
                                                      width: Get.width,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            "أقرب سطحة",
                                                            style: TextStyle(
                                                                height: 1.45,
                                                                letterSpacing: 1.0,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: Get
                                                                    .width *
                                                                    0.055,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "لنقل السيارة",
                                                            style: TextStyle(
                                                                height: 1.45,
                                                                letterSpacing: 1.0,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: Get
                                                                    .width *
                                                                    0.075,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                              Container(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      top: 0,
                                                      left: 15,
                                                      right: 15,
                                                      bottom: 0),
                                                  child: Image.asset(
                                                    "assets/home_assets/background2.png",
                                                    fit: BoxFit.fill,
                                                    height: Get.width * 0.16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 10),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                    child: Text(
                                      "شارك وأربح ${data.couponAmount} ريال",
                                      style: TextStyle(
                                          color: Colors.black,
                                          height: 1.45,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.w900,
                                          fontSize: Get.width * 0.055),
                                    )),
                                Center(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(
                                                8)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () {
                                              Clipboard.setData(ClipboardData(
                                                  text: couponCode))
                                                  .then((_) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Coupon '${couponCode ??
                                                            ""}' copied to clipboard")));
                                              });
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "كود ${couponCode ?? "...."}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      height: 1.45,
                                                      letterSpacing: 1.0,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Icon(
                                                  Icons.copy,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )))
                              ],
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 1.5,
                                )),
                          ),
                        )),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        bottomForComingSoon(
                                            "خدمة بنشر الكفرات",
                                            "هذه الخدمة ستتوفر قريباً");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "بنشر",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Get.height *
                                                        0.025,
                                                    height: 1.45,
                                                    letterSpacing: 1.0,
                                                    fontWeight: FontWeight
                                                        .w900),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Expanded(
                                                child: Image.asset(
                                                  "assets/home_assets/i1.png",
                                                ),
                                              ),
                                              SizedBox(height: 10,),


                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Color(0xff419FCF),
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                // begin: const FractionalOffset(0.05, 0.09),
                                                // end: const FractionalOffset(1.0, 0.0),
                                                stops: [0.0, 0.35],
                                                tileMode: TileMode.decal),
                                          ),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        bottomForComingSoon(
                                            "خدمة تغيير البطارية",
                                            "هذه الخدمة ستتوفر قريباً");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              SizedBox(height: 10,),
                                              Text(
                                                "بطارية",
                                                style: TextStyle(
                                                    height: 1.45,
                                                    letterSpacing: 1.0,
                                                    color: Colors.white,
                                                    fontSize: Get.height *
                                                        0.025,
                                                    fontWeight: FontWeight
                                                        .w900),
                                              ),

                                              Expanded(
                                                child: Image.asset(
                                                  "assets/home_assets/i2.png",
                                                ),
                                              ),
                                              SizedBox(height: 0,),

                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Color(0xff419FCF),
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                // begin: const FractionalOffset(0.05, 0.09),
                                                // end: const FractionalOffset(1.0, 0.0),
                                                stops: [0.0, 0.35],
                                                tileMode: TileMode.decal),
                                          ),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        bottomForComingSoon(
                                            "خدمة زينة السيارة",
                                            "هذه الخدمة ستتوفر قريباً");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              SizedBox(height: 10,),
                                              Text(
                                                "زينة ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Get.height *
                                                        0.025,
                                                    height: 1.45,
                                                    letterSpacing: 1.0,
                                                    fontWeight: FontWeight
                                                        .w900),
                                              ),

                                              Expanded(
                                                child: Image.asset(
                                                  "assets/home_assets/i3.png",
                                                ),
                                              ),
                                              SizedBox(height: 10,),

                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                20),
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Color(0xff419FCF),
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                // begin: const FractionalOffset(0.05, 0.09),
                                                // end: const FractionalOffset(1.0, 0.0),
                                                stops: [0.0, 0.35],
                                                tileMode: TileMode.decal),
                                          ),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        bottomForComingSoon(
                                            "خدمة تغيير زجاج السيارة",
                                            "هذه الخدمة ستتوفر قريباً");
                                      },
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "زجاج",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: Get.height * 0.025,
                                                  height: 1.45,
                                                  letterSpacing: 1.0,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            Expanded(
                                              child: Image.asset(
                                                "assets/home_assets/i4.png",
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              20),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.white,
                                                Color(0xff419FCF),
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              // begin: const FractionalOffset(0.05, 0.09),
                                              // end: const FractionalOffset(1.0, 0.0),
                                              stops: [0.0, 0.35],
                                              tileMode: TileMode.decal),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        )),
                  ],
                ))

            /*Padding(
             padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
             child: Container(
               width: Get.width,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(NotificationScreen());
                              // dashboardProvider.dashboardBoardScaffoldKey.currentState.openDrawer();
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: blue),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: Colors.white)],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: SvgPicture.asset(
                                  'assets/home_assets/ring.svg',
                                  // height: 55,
                                  // scale: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                   SizedBox(height: 10,),
                   Row(
                   children: [
                     Text("Welcome!".tr,style: TextStyle(fontSize: Get.height * 0.035,color: blue,fontWeight: FontWeight.w900),),
                     Expanded(child: Text(" ${data.userName} ",style: TextStyle(fontSize: Get.height * 0.03,color: Colors.black),)),
                   ],

                 ),

                 Text("فضلاً اختر الخدمة التي تحتاجها.",style: TextStyle(fontSize: Get.height * 0.025,color: Colors.grey),),
               ],)
               ,),
           ),
            Expanded(
                child: Column(
              children: [
                SizedBox(height: 15,),

                Expanded(flex: 3,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap:(){
                      dashboardProvider.isTechnicianOrder=1;
                      Get.to(CarLocationScreen(isTechnicianOrder: 1));
                    },
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,

                            image: AssetImage('assets/home_assets/Banner.png')),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("أحتاج ورشة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.height*0.035,color: Colors.white),),
                          Text("لصيانة السيارة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.height*0.035,color: Colors.white),),
                        ],),
                      ),
                    ),
                  ),
                )),
                Expanded(flex: 3,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      bottomForComingSoon("Technician service".tr,"This service will be available soon"
                          "\nWe are testing the technician to make the best check car service for you"
                          "\nYou can call us directly to take a free consultation at 0507888779".tr);
                      },
                    child: Container(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("أحتاج فني",style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.height*0.035,color: Colors.white),),
                            Text("لفحص السيارة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.height*0.035,color: Colors.white),),
                          ],),
                      ),
                      decoration: BoxDecoration(

                        image: DecorationImage(
                            fit: BoxFit.fill,

                            image: AssetImage('assets/home_assets/Banner2.png')),
                        borderRadius: BorderRadius.circular(45)

                      ),
                    ),
                  ),
                )),


                Expanded(flex: 3,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){

                      bottomForComingSoon("Pickup service".tr,"This service will be available so soon.\n"
                          "We are collecting the best car pickups for you, please keep in touch.".tr);


                    },
                    child: Container(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("أحتاج سطحة ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.height*0.035,color: Colors.white),),
                            Text("لنقل السيارة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.height*0.035,color: Colors.white),),
                          ],),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/home_assets/Banner3.png')),
                        borderRadius: BorderRadius.circular(45)

                      ),
                    ),
                  ),
                )),


                Expanded(flex: 2,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      bottomSheetForHelpCall();
                    },
                    child: Container(
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("لا أدري, أحتاج مساعدة مصان",style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.height*0.035,color: Colors.white),),
                          ],),
                      ),
                      decoration: BoxDecoration(

                        image: DecorationImage(
                            fit: BoxFit.fill,

                            image: AssetImage('assets/home_assets/Banner4.png')),
                        borderRadius: BorderRadius.circular(20)

                      ),
                    ),
                  ),
                )),

              ],
            )),*/
          ],
        ),
      );
    });
  }

  void bottomForComingSoon(String title, String message) {
    Get.bottomSheet(
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              )),
          child: Column(
            // shrinkWrap: true,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Container(
                      height: 5,
                      width: Get.width / 4,
                      color: grey.withOpacity(0.5),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  title,
                  style: TextStyle(
                      color: blue,
                      fontSize: Get.height * 0.027,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: Get.height * 0.02,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _commonButton("Ok".tr, tap: () {
                  Get.back();
                }),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        isScrollControlled: true);
  }

  Widget _commonButton(String title,
      {double bottomPadding: 15, int index, Color bntColor = blue, tap}) {
    return InkWell(
      onTap: tap,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Container(
          width: Get.width * .8,
          height: Get.height * .06,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bntColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Color(0xff000000).withOpacity(.13),
                spreadRadius: 1,
                blurRadius: 3,
              ),
            ],
          ),
          child: Text(
            '$title'.tr,
            style: TextStyle(
                color: Colors.white,
                fontSize: Get.height * .0225,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
