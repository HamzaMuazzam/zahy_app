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
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


    getHomeScreenDataAll(){
  Future.delayed(Duration(seconds: 1), () {
    SharedPreferences.getInstance().then((value) {
      ApiServices.getFreshOrderByUserId(Get.context, value.getString(Finals.USER_ID));
      ApiServices.getInProgressHomeOrders(Get.context, value.getString(Finals.USER_ID));
      ApiServices.getAllReportsByUserID(value.getString(Finals.USER_ID));
    });
    });
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHomeScreenDataAll();
      var provider = Provider.of<DashboardProvider>(Get.context, listen: false);
      // ApiServices.getDiscountOffers();
      SharedPreferences.getInstance().then((value) {
        provider.setUserId(value.getString(Finals.USER_ID));

      });

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return Consumer<DashboardProvider>(builder: (builder, data, _) {


      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

         Padding(
           padding: const EdgeInsets.only(top: 0,left: 15,right: 15),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: 25,),
               Container(
                 width: Get.width,
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [

                     Expanded(child: Container()),
                     InkWell(
                       onTap: (){
                         dashboardProvider.dashboardBoardScaffoldKey.currentState.openDrawer();
                       },
                       child: Container(
                         height: 50,
                         width: 50,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           color: Colors.white,
                           boxShadow: [BoxShadow(color: Colors.white)],
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(15.0),
                           child: Image.asset(
                             'assets/images/menu.png',
                             // scale: 0.3,
                           ),
                         ),

                       ),
                     ),
                     SizedBox(width: 10,),

                   ],),
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 10),
                 child: Column(

                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     SizedBox(height: Get.height*0.05,),
                     Text("Welcome!".tr,style: TextStyle(fontSize: Get.height * 0.05,fontWeight: FontWeight.bold,color: blue),),

                   ],),
               ),

               Container(
                 width: Get.width,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.end,
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 5),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("${data.userName}",style: TextStyle(fontSize: Get.height * 0.035,fontWeight: FontWeight.bold,color: orangeYellow),),
                               Text("",style: TextStyle(fontSize: Get.height * 0.04,fontWeight: FontWeight.bold,color: orangeYellow),),
                               Text("",style: TextStyle(fontSize: Get.height * 0.04,fontWeight: FontWeight.bold,color: orangeYellow),),
                               Text("",style: TextStyle(fontSize: Get.height * 0.04,fontWeight: FontWeight.bold,color: orangeYellow),),
                             ],
                           ),
                         ),
                         Padding(

                           padding: const EdgeInsets.symmetric(horizontal: 20),
                           child: SvgPicture.asset('assets/person_thinking.svg',height: Get.height*0.20,),
                         ),

                       ],
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),


          Flexible(
            child: Container(
                width: Get.width,
                child: Consumer<OrderScreenProvider>(
                builder: (builder, provider, child) {
              return showLatestOrder(provider);
            })),
          ),

        ],
      );
    });
  }

  Widget showLatestOrder(OrderScreenProvider provider) {
    return !provider.isInprogressCompletedHomeOrderDataLoaded
        ? showShimmer()
        : provider.completedOrInProgressOrderByUserIdFromJsonForHome.result.length==0
        &&  provider.getFreshOrderByUserIdReponse!=null && provider.getFreshOrderByUserIdReponse.result.length==0
        && provider.reportsByUserIdFromJson!=null &&
        provider.reportsByUserIdFromJson.result.length==0
        ? Padding(
          padding:  EdgeInsets.only(
              bottom: Get.height *0.025,
              left: Get.height *0.015,
              right: Get.height *0.015,
          ),
          child: Container(
            decoration: BoxDecoration(color: Colors.white,
                // boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 0.5,offset: Offset(1,2),spreadRadius: 3,blurStyle: BlurStyle.outer)],

                borderRadius: BorderRadius.circular(20)),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),

            Padding(
            padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Row(children: [
             Expanded(
               child: Container(width: Get.width,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("How can I help you?".tr,
                     style: TextStyle(fontSize: Get.height * 0.025,fontWeight: FontWeight.w600,color: Colors.grey),),
                   SizedBox(height: 10),
                   Text("Please select service you need.".tr,style: TextStyle(
                       fontSize: Get.height * 0.02,
                       fontWeight: FontWeight.normal,
                       color: grey),),

                 ],
               ),
               ),
             )

            ],),
        ),
            SizedBox(height: 10),


            Expanded(
               child: InkWell(
                  onTap:(){


                    dashboardProvider.isTechnicianOrder=1;

                    Get.to(CarLocationScreen(isTechnicianOrder: 1));






            },child: _commonButton("Fix My Car".tr, index:0)),
             ), /// direct order to workshop

            Expanded(
               child: InkWell(onTap:(){


                 bottomForComingSoon("Pickup service".tr,"This service will be available so soon.\n"
                     "We are collecting the best car pickups for you, please keep in touch.".tr);

                // dashboardProvider.isTechnicianOrder=0;
                // Get.to(CarLocationScreen(isTechnicianOrder: 0));



            },child: _commonButton("Check My Car".tr,index: 1)),
             ), /// direct to technician

            Expanded(child: InkWell(
                onTap: (){

                  bottomForComingSoon("Technician service".tr,"This service will be available soon"
                      "\nWe are testing the technician to make the best check car service for you"
                      "\nYou can call us directly to take a free consultation at 0507888779".tr);

                },

                child: _commonButton("Pick My Car".tr,index:  2))), /// order car pick up first then order to order ()

             Expanded(
               child: InkWell(
                onTap: (){
                  bottomSheetForHelpCall();
                },
                  child: _commonButton("I Need Help".tr,index: 3,bntColor:yellow)),
             ), /// just call

            SizedBox(height: 10),



          ],
    ),
          ),
        )
        : Container(
         child: SingleChildScrollView(
           child: Column(
            children: [
              SizedBox(height: 30,),
            provider.completedOrInProgressOrderByUserIdFromJsonForHome !=null  &&
                provider.completedOrInProgressOrderByUserIdFromJsonForHome.result.isNotEmpty ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: Get.locale.toString().contains("en")
                        ? 20
                        : 0,
                    right: Get.locale.toString().contains("en")
                        ? 0
                        : 20,
                  ),
                  child: Text(
                    "Latest orders".tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * 0.02
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                Container(
                  child: provider.completedOrInProgressOrderByUserIdFromJsonForHome!=null ?
                  CarouselSlider.builder(
                      itemCount: provider.completedOrInProgressOrderByUserIdFromJsonForHome.result.length,
                      itemBuilder: (BuildContext context, int index,
                          int number) {
                        print("provider.completedOrInProgressOrderByUserIdFromJsonForHome.result "
                            "${provider.completedOrInProgressOrderByUserIdFromJsonForHome.result.length}");

                        var result = provider.completedOrInProgressOrderByUserIdFromJsonForHome.result[index];
                        return InkWell(
                          onTap: (){
                            var orderScreenProvider =
                            Provider.of<OrderScreenProvider>(Get.context, listen: false);
                            orderScreenProvider.setSignleOrder(false, null);
                            orderScreenProvider.setSignleOrderID(result.orderId.toString());
                            Get.to(OrderTracking(null,true,result.orderId));

                          },
                          child: Container(
                            // height: 120,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: grey.withOpacity(0.5)
                                  )
                                ]),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${_getAllissue2(provider,index)}"
                                            ,style: TextStyle(
                                                color: Colors.blue,
                                                fontSize:  Get.height * 0.015,
                                                fontWeight: FontWeight.bold),),
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 8,
                                                  vertical: 2),
                                              child: Text(!result.isCompleted ? "In Progress".tr: "Completed".tr,
                                                  style: TextStyle(
                                                      color:!result.isCompleted ? Color(0xFFE8BC2A) : Colors.green,
                                                      fontSize:  Get.height * 0.014
                                                  )
                                              ),
                                            ),
                                            decoration: BoxDecoration(color: Color(0xFFFCF5DF),borderRadius: BorderRadius.circular(5)),
                                          )
                                        ],),
                                    ),
                                    Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,size: 15,)
                                  ],),
                              ),
                              // SizedBox(height: 5,),
                              Expanded(
                                child: Row(
                                  children: [

                                    Expanded(
                                        child: Container(

                                          decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade200,
                                                ),
                                                right: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.grey.shade200,
                                                ),
                                              )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10,top: 4,bottom: 4,right: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [

                                                Text("Order #".tr,style: TextStyle(color: Colors.blueGrey,
                                                    fontSize: Get.height * 0.016),),
                                                Text("${result.orderId}",style: TextStyle(color: Colors.black,fontSize: Get.height * 0.016,fontWeight: FontWeight.bold),),

                                              ],),
                                          ),
                                        )
                                    ),
                                    Expanded(
                                        child: Container(

                                          decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade200,
                                                ),
                                                left: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.grey.shade200,
                                                ),
                                              )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10,top: 4,bottom: 4,right: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,

                                              children: [

                                                Text("Date".tr,style: TextStyle(color: Colors.blueGrey,fontSize: Get.height * 0.016),),
                                                Text("${result.creationDate.replaceAll("T00:00:00", '')}",style: TextStyle(color: Colors.black,
                                                    fontSize: Get.height * 0.016,fontWeight: FontWeight.bold),),

                                              ],),
                                          ),
                                        )
                                    ),

                                  ],),
                              ),
                              Expanded(
                                child: Row(
                                  children: [

                                    Expanded(
                                        child: Container(

                                          decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade200,
                                                ),
                                                right: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.grey.shade200,
                                                ),
                                              )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10,top: 4,bottom: 4,right: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [

                                                Text("Car".tr,style: TextStyle(color: Colors.blueGrey,fontSize: Get.height * 0.016),),

                                                Expanded(child: Text("${result.carName}",style: TextStyle(color: Colors.black,fontSize: Get.height * 0.016,fontWeight: FontWeight.bold),)),

                                              ],),
                                          ),
                                        )
                                    ),
                                    Expanded(
                                        child: Container(

                                          decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade200,
                                                ),
                                                left: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.grey.shade200,
                                                ),
                                              )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10,top: 4,bottom: 4,right: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text("Cost".tr,style: TextStyle(color: Colors.blueGrey,fontSize: Get.height * 0.016),),
                                                Text("SR".tr+" ${double.parse(result.totalCost.toString()).toInt()} ",style: TextStyle(color: Colors.blue,fontSize: Get.height * 0.016,fontWeight: FontWeight.bold),),

                                              ],),
                                          ),
                                        )
                                    ),

                                  ],),
                              ),




                            ],),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: Get.height * 0.24,
                        // aspectRatio: 16 / 9,
                        viewportFraction: 0.85,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 30),
                        autoPlayAnimationDuration: Duration(milliseconds: 30),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (indexNumber, reasonToScroll) {},
                        scrollDirection: Axis.horizontal,
                      )
                  )
                      :
                  Center(child:Text("No Order Found!".tr)),


                ),

              ],)
                :
            Container(),


            ///


              provider.isFreshOrderDataLoaded
                  &&
                  provider.getFreshOrderByUserIdReponse!=null
                  &&
                  provider.getFreshOrderByUserIdReponse.result.length != 0?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),

                Padding(
                  padding: EdgeInsets.only(
                    top: 0,
                    bottom: 5,
                    left: Get.locale.toString().contains("en")
                        ? 20
                        : 0,
                    right: Get.locale.toString().contains("en")
                        ? 0
                        : 20,
                  ),
                  child: Text(
                    "Your Offers".tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * 0.02

                    ),
                  ),
                ),
                SizedBox(height: 10,),

                Container(
                  child: provider.getFreshOrderByUserIdReponse != null ?
                  Container(
                    child: provider.getFreshOrderByUserIdReponse.result.length!=0 ?
                    CarouselSlider.builder(
                        itemCount: provider.getFreshOrderByUserIdReponse.result.length,
                        itemBuilder: (BuildContext context, int index,
                            int number) {
                          var result = provider.getFreshOrderByUserIdReponse.result[index];

                          return  InkWell(
                            onTap: (){

                              var json = result.toJson();

                              Get.to(OrderOfferScreen(Results.Result.fromJson(json)));
                            },
                            child: Container(
                              // height: 120,
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // "Broken Windows",
                                                "${_getAllissueForOffer(provider, index)}",
                                                // "Text",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: Get.height * 0.02,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 2.5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 5),
                                                child: Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    child: Text(
                                                        " ${result.offers.length} "+"WorkShop offers".tr,
                                                        style: TextStyle(
                                                            fontSize: Get.height * 0.016,
                                                            color:
                                                            Colors.black)),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFDADEE1),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.black,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey.shade200,
                                                    ),
                                                    right: BorderSide(
                                                      width: 0.5,
                                                      color: Colors.grey.shade200,
                                                    ),
                                                  )),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 4, bottom: 4,right: 10),
                                                child: Column(
                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Order #".tr,
                                                      style: TextStyle(
                                                          fontSize: Get.height * 0.016,
                                                          color: Colors.blueGrey),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${result.orderId}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: Get.height * 0.016,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                        Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey.shade200,
                                                    ),
                                                    right: BorderSide(
                                                      width: 0.5,
                                                      color: Colors.grey.shade200,
                                                    ),
                                                  )),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 4, bottom: 4,right: 10),
                                                child: Column(
                                                  crossAxisAlignment:CrossAxisAlignment.start,
                                                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Date".tr,
                                                      style: TextStyle(
                                                          fontSize: Get.height * 0.016,
                                                          color: Colors.blueGrey),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${result.creationDate.replaceAll("T00:00:00", '')}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: Get.height * 0.016,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                        },
                        options: CarouselOptions(
                          height: Get.height * 0.175,
                          // aspectRatio: 16 / 9,
                          viewportFraction: 0.85,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 30),
                          autoPlayAnimationDuration: Duration(milliseconds: 30),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          onPageChanged: (indexNumber, reasonToScroll) {},
                          scrollDirection: Axis.horizontal,
                        )
                    )
                        :
                    Center(child:Text("No Order Found!".tr)),


                  )
                      :
                  Center(child:Text("No Offer Found!".tr)),

                )
              ],
            )
                :
            Container(),

            ///
              provider.reportsByUserIdFromJson!=null && provider.reportsByUserIdFromJson.result.isNotEmpty ?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),

                Padding(
                  padding: EdgeInsets.only(
                    top: 0,
                    bottom: 5,
                    left: Get.locale.toString().contains("en")
                        ? 20
                        : 0,
                    right: Get.locale.toString().contains("en")
                        ? 0
                        : 20,
                  ),
                  child: Text(
                    "Order From Reports".tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * 0.02
                    ),
                  ),
                ),
                SizedBox(height: 10,),

                Container(
                  child: provider.isOrderFromReportsLoaded && provider.reportsByUserIdFromJson.result.length!=0 ?
                  CarouselSlider.builder(
                      itemCount: provider.reportsByUserIdFromJson.result.length,
                      itemBuilder: (BuildContext context, int index,
                          int number) {
                        var result = provider.reportsByUserIdFromJson.result[index];
                        // logger.wtf(result.carType);
                        // report.IssueType list=report.IssueType();
                        List<report.IssueType> issueType=[];
                        result.issues.forEach((element) {
                          issueType.add( report.IssueType(faultId: 0,faultName: element.name));
                        });

                        return InkWell(
                          onTap: (){

                            // report.Report.fromJson(result.toJson());
                            Get.to(OrderFromReportService(report.Report(
                                reportId: result.reportId,
                                technicianId: "0",
                                addressLocation: result.clientAddress ??"",
                                comment: result.comment??"",
                                creationDate: result.creationDate.toString()??"",
                                issueTypes: issueType??[],
                                attachments: []
                            )));

                          },
                          child: Container(
                            // height: 120,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Issue Types".tr,
                                              style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: Get.height * 0.018
                                                // fontSize: 14,
                                                // fontWeight:FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2.5,
                                            ),
                                            Text(
                                                _getAllIssuesForTechnician(provider, index),
                                                style: TextStyle(
                                                    color:Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Get.height * 0.018
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.black,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  right: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 4, bottom: 4,right: 10),
                                              child: Column(
                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Car type".tr,
                                                    style: TextStyle(
                                                        fontSize: Get.height * 0.016,
                                                        color: Colors.blueGrey),
                                                  ),
                                                  Text(
                                                    "${result.carType}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: Get.height * 0.016,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                      Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border(
                                                  top: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  right: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                )),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 4, bottom: 4),
                                              child: Column(
                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Date".tr,
                                                    style: TextStyle(
                                                        fontSize: Get.height * 0.016,
                                                        color: Colors.blueGrey),
                                                  ),
                                                  Text(
                                                    // "${DateTime.parse(result.creationDate.toString())}",
                                                    "${DateFormat("yyyy-MM-dd").format(DateTime.parse(result.creationDate.toString()))}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: Get.height * 0.016,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );

                      },
                      options: CarouselOptions(
                        height: Get.height * 0.2,

                        // aspectRatio: 16 / 9,
                        viewportFraction: 0.85,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 30),
                        autoPlayAnimationDuration: Duration(milliseconds: 30),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        onPageChanged: (indexNumber, reasonToScroll) {},
                        scrollDirection: Axis.horizontal,
                      )
                  )
                      :
                  Center(child:Text("No Order Found!".tr)),


                )
              ],
            )
                :
            Container(),



            ///


          ],
        ),
      ),
    );
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


  Widget workShopWidget(image, int number, String name) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 55,
          height: 55,
          margin: EdgeInsets.only(bottom: Get.height * .0125),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1),
          ),
          child: Center(
            child: Image.asset(image, scale: 0.75),
          ),
        ),
        SizedBox(width: Get.width * .05),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$number',
              style: MyTextStyle.circular().copyWith(
                  color: Colors.white,
                  fontSize: Get.height * .035,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              name,
              style: TextStyle(
                color: Colors.white.withOpacity(.70),
                fontSize: Get.height * .017,
                fontStyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ],
    );

  }

  bgImageWidget(index, List<Result> result, DashboardProvider data) {
    return GestureDetector(
      onTap: () {
        // Get.to(DiscountList(dashboardProvider.imagesList[index]));
        // onTap: (){
        Get.to(() => DiscountList(
            "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/bf638567266649.5b338bb6444a3.jpg",
            discountOffer: data.discountOffersFromJson.result));
        // },
        // Get.to(()=>WorkShopAndTechnicianORDER(screenChecked: 1,isFromDicountOffers: true,offerID:result[index].discountOfferId));
      },
      child: Stack(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(result[index].workshop.displayPicture ==
                          null
                      ? "https://i.imgur.com/vNYmZ47.png"
                      :
                      // "https://muapi.deeps.info/${result[index].workshop.displayPicture}"
                      "https://tamam.com.pk/Background.png"),
                  fit: BoxFit.fill,
                )),
          ),
          Container(
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: blue.withOpacity(0.25)),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(
                Get.locale.toString().contains("en") ? 0 : math.pi),
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  image: DecorationImage(
                    image: AssetImage("assets/images/Artboard 1.png"),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Container(),
                flex: 5,
              ),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Special Offer".tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "You can take up to 20% off if you use our app to find your mechanic.".tr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }


  Widget headingNameColumnWidget(String heading, String name, {Color color: midGrey}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          heading,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: midGrey.withOpacity(0.8),
            fontSize: Get.height * .018,
          ),
        ),
        SizedBox(height: Get.height * .007),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontSize: Get.height * .016,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  String _getAllissue2(OrderScreenProvider datas, int index) {
    var faults =
        datas.completedOrInProgressOrderByUserIdFromJsonForHome.result[index].faults;
    List<String> data = [];
    for (int i = 0; i < faults.length; i++) {
      data.add(faults[i].name);
    }
    return data.toString().replaceAll("[", "").replaceAll("]", "");
  }

  String _getAllissueForOffer(OrderScreenProvider datas, int index) {
    var faults = datas.getFreshOrderByUserIdReponse.result[index].faults;
    List<String> data = [];
    for (int i = 0; i < faults.length; i++) {
      data.add(faults[i].name);
    }
    return data.toString().replaceAll("[", "").replaceAll("]", "");
  }



  void showComingSoon() {

    showDialog(
        context: context,
        builder: (context){
          return CupertinoAlertDialog(
            title: Text("Special Discount Offer Coming Soon!".tr),
            // content: Text( ""),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel".tr)
              ),
              CupertinoDialogAction(
                  textStyle: TextStyle(color: Colors.red),
                  isDefaultAction: true,
                  onPressed: () async {
                    Navigator.pop(context);
                    },
                  child: Text("OK".tr)
              ),
            ],
          );
        });
  }

  String _getAllIssuesForTechnician(OrderScreenProvider provider, int index) {
String issues='';
    var result = provider.reportsByUserIdFromJson.result[index];

    result.issues;

    for(int i=0;i<result.issues.length;i++){
    issues=issues+result.issues[i].name+', ';
    }

    print(issues);
    return issues;
  }

// String _getJsonString(String data){
//   data=data.replaceAll("{", "").replaceAll("}", "");
//   var dataSp = data.split(',');
//   Map<String, String> mapData = Map();
//   dataSp.forEach(
//           (element) => mapData[element.split(':')[0]] = element.split(':')[1]);
//
//   Map<String, String> lastmap = {};
//
//   mapData.forEach((key, value) {
//     print('"${key.trim()}"');
//     print('"${value.trim()}"');
//
//     lastmap['"${key.trim()}"'] = '"${value.trim()}"';
//   });
//   return lastmap.toString();
// }
}
