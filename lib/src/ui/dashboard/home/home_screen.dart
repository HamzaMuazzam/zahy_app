import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/api_services/response_models/GetDiscountOffers.dart';
import 'package:musan_client/api_services/response_models/GetMyCarsByUserId.dart' as report;
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

import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart' as Results;


class HomeScreen extends StatefulWidget {
  HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var orderProvider=Provider.of<OrderScreenProvider>(Get.context,listen: false);

class _HomeScreenState extends State<HomeScreen> {


  var dashboardProvider = Provider.of<DashboardProvider>(Get.context,listen: false);
  var orderScreenProvider = Provider.of<OrderScreenProvider>(Get.context, listen: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      SharedPreferences.getInstance().then((value) {
        dashboardProvider.setUserId(value.getString(Finals.USER_ID));
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
           Padding(
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
            )),
          ],
        ),
      );
    });
  }

  void bottomForComingSoon(String title,String message){
    Get.bottomSheet(
        Container(

          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          )),
          child:
          Column(
            // shrinkWrap: true,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Container(height: 5,width: Get.width/4,color: grey.withOpacity(0.5),)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: Text(title,style: TextStyle(color: blue,fontSize: Get.height *0.027,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Text(message,style: TextStyle(color: Colors.grey,fontSize:  Get.height *0.02,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _commonButton("Ok".tr,tap:(){
                  Get.back();
                }),
              )
              ,
              SizedBox(height: 10,),


            ],),
        ),
        isScrollControlled: true

    );
  }

  Widget _commonButton(String title,{double bottomPadding:15, int index, Color bntColor=blue,tap}) {
    var dashboardProvider =
    Provider.of<DashboardProvider>(context, listen: false);
    return InkWell(
      onTap: tap,
      child: Padding(
        padding:  EdgeInsets.only(bottom: bottomPadding),
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


class t{
  int _a=0;

  int get a => _a;

  set a(int value) {
    _a = value;
  }
}