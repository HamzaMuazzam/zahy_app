import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '/CashBackScreen.dart';
import '/api_services/ApiServices.dart';
import '/api_services/Finals.dart';
import '/src/provider/OrderScreenProvider.dart';
import '/src/provider/dashboard_provider.dart';
import '/src/ui/auth/SignUp.dart';
import '/src/ui/order_booking_screens/car_location_screen.dart';
import '/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var orderProvider = Provider.of<OrderScreenProvider>(Get.context, listen: false);

class _HomeScreenState extends State<HomeScreen> {
  var dashboardProvider = Provider.of<DashboardProvider>(Get.context, listen: false);
  var orderScreenProvider = Provider.of<OrderScreenProvider>(Get.context, listen: false);
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
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

    return Consumer<DashboardProvider>(builder: (builder, data, _) {
      return Container(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                Image.asset("assets/dummy_profile.png", scale: 1.5),
                Expanded(child: SizedBox()),
                InkWell(
                  onTap: () {
                    Get.to(CashBackScreen());
                  },
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${data.isCashBackLoaded && data.promotionCashBackFromJson != null ? "${data.promotionCashBackFromJson.result.amount}" : "0"} ",
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
                              color: midGrey,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                      SvgPicture.asset('assets/home_assets/Wallet.svg'),
                      SizedBox(width: 5),
                    ],
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
            ).paddingOnly(left: 20, right: 20, bottom: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "مرحباً ${data.userName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Get.width * 0.055,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      "ايش محتاج؟",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: Get.width * 0.045,
                          height: 1.2,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                Image.asset("assets/home_assets/wave.png", scale: .6),
              ],
            ).paddingOnly(left: 20, right: 20),
            Expanded(
                child: Column(
              children: [
                Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 15),
                      child: InkWell(
                        onTap: () {
                          dashboardProvider.isTechnicianOrder = 1;
                          Get.to(CarLocationScreen(isTechnicianOrder: 1));
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                child: SvgPicture.asset("assets/home_assets/laundry.svg"),
                              )),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "Laundry service",
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
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: themeColor, borderRadius: BorderRadius.circular(18)),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffECFCFF),
                                    borderRadius: BorderRadius.circular(18)),
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
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Container(
                                          width: Get.width,
                                          child: Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Smart home",
                                                  style: TextStyle(
                                                      fontSize: 13, fontWeight: FontWeight.w700),
                                                ),
                                                Text(
                                                  "Service",
                                                  style: TextStyle(
                                                      fontSize: 13, fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                                    Expanded(
                                      child: Container(
                                        child: SvgPicture.asset("assets/home_assets/repair.svg"),
                                      ),
                                    ).paddingOnly(bottom: 10),

                                  ],
                                ),
                              ),
                            ).paddingOnly(right: 10)),
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
                                      color: Color(0xffECFCFF),
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Container(
                                          width: Get.width,
                                          child: Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "House maintenance",
                                                  style: TextStyle(
                                                      fontSize: 13, fontWeight: FontWeight.w700),
                                                ),
                                                Text(
                                                  "Service",
                                                  style: TextStyle(
                                                      fontSize: 13, fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )),
                                      Expanded(
                                        child: Image.asset(
                                          "assets/home_assets/home.png",
                                          scale: 2,
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
                    padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: Text(
                              "شارك وأربح ${data.couponAmount} ريال",
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w900,
                                  fontSize: Get.width * 0.055),
                            ),
                          ),
                          Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(text: couponCode))
                                            .then((_) {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(
                                                  "Coupon '${couponCode ?? ""}' copied to clipboard")));
                                        });
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(width: 5),
                                          Text(
                                            "كود ${couponCode ?? "...."}",
                                            style: TextStyle(
                                                color: themeColor,
                                                height: 1.45,
                                                letterSpacing: 1.0,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(width: 3),
                                          Icon(Icons.copy, color: themeColor),
                                          SizedBox(width: 5),
                                        ],
                                      ),
                                    ),
                                  )))
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: themeColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              bottomForComingSoon("خدمة بنشر الكفرات", "هذه الخدمة ستتوفر قريباً");
                            },
                            child: Column(
                              children: [
                                Container(
                                  child: Icon(Icons.arrow_back).paddingAll(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffFAFAFA),
                                  ),
                                ),
                                Text(
                                  "Show all",
                                  style:
                                      TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              bottomForComingSoon(
                                  "خدمة تغيير البطارية", "هذه الخدمة ستتوفر قريباً");
                            },
                            child: Column(
                              children: [
                                Container(

                                  child:
                                      SvgPicture.asset("assets/home_assets/device_mentinance.svg").paddingAll(10),
                                  decoration:
                                      BoxDecoration(color: themeColor, shape: BoxShape.circle),
                                ),
                                Text(
                                  "Devices",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "maintenance",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              bottomForComingSoon("خدمة زينة السيارة", "هذه الخدمة ستتوفر قريباً");
                            },
                            child: Column(
                              children: [
                                Container(

                                  child: SvgPicture.asset("assets/home_assets/house_cleaning.svg").paddingAll(10),
                                  decoration:
                                      BoxDecoration(color: Color(0xff00E592), shape: BoxShape.circle),
                                ),
                                Text(
                                  "House",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "cleaning",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              bottomForComingSoon(
                                  "خدمة تغيير زجاج السيارة", "هذه الخدمة ستتوفر قريباً");
                            },
                            child: Column(
                              children: [
                                Container(

                                    child:
                                        SvgPicture.asset("assets/home_assets/washing_clothes.svg").paddingAll(10),
                                    decoration:
                                        BoxDecoration(color: Color(0xffFFB516), shape: BoxShape.circle)),
                                Text("Washing", style: TextStyle(fontWeight: FontWeight.w400)),
                                Text("clothes", style: TextStyle(fontWeight: FontWeight.w400)),
                              ],
                            ),
                          )),
                        ],
                      ),
                    )),
              ],
            ))
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
                      color: blue, fontSize: Get.height * 0.027, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.grey, fontSize: Get.height * 0.02, fontWeight: FontWeight.bold),
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
      {double bottomPadding= 15, Color bntColor = blue, tap}) {
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
                color: Colors.white, fontSize: Get.height * .0225, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
