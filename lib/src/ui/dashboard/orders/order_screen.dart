import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/FCM.dart';
import 'package:musan_client/OrderOfferScreen.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart';
import 'package:musan_client/api_services/response_models/GetCompletedOrInProgressOrderByUserId.dart'
    as GetcompletedOrders;
import 'package:musan_client/api_services/response_models/OfferOrderCustomReponse.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_tracking_new.dart';
import 'package:musan_client/src/ui/order_booking_screens/utils.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'OrderDetails.dart';
import 'order_tracking.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with TickerProviderStateMixin {
  var tabIndex = 0;

  @override
  void initState() {
    var context = Get.context;
    analytics.logScreenView(screenName: "OrderScreen",screenClass:"OrderScreen");


    getOffersAndOderAtOnce();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderScreenProvider>(builder: (builder, data, child) {
      return Scaffold(
          backgroundColor: deepGrey,
          body: data.isFreshOrderDataLoaded &&
                  data.isInprogressCompletedOrderDataLoaded
              ?
          data.getFreshOrderByUserIdReponse.result.length+ data.completedOrInProgressOrderByUserIdFromJson.result.length!=0?
      Stack(children: [
        PageView(

          controller: data.homePagePictureIndicatorController,
          scrollDirection: Axis.horizontal,
          children: List.generate(
            data.getFreshOrderByUserIdReponse.result.length + data.completedOrInProgressOrderByUserIdFromJson.result.length,
                (index) {
              return index < data.getFreshOrderByUserIdReponse.result.length
                  ?
              OrderOfferScreen(data.getFreshOrderByUserIdReponse.result[index])
                  :
              OrderTracking(data.completedOrInProgressOrderByUserIdFromJson.result[index-data.getFreshOrderByUserIdReponse.result.length],false,null);

            },
          ),
          onPageChanged: (index) {

            /// offer screen view pager

          },
        ),
        Align(
          alignment: Alignment(0,-0.88),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [

                InkWell(
                    onTap: (){
                      data.homePagePictureIndicatorController.previousPage(duration: Duration(microseconds: 1), curve: Curves.easeIn);

                    },
                    child: Icon(Icons.arrow_back,color: Colors.white,)),
                Expanded(child:Icon(Icons.arrow_back,color: Colors.transparent,)),
                InkWell(
                    onTap: (){
                      data.homePagePictureIndicatorController.nextPage(duration: Duration(microseconds: 1), curve: Curves.easeOut);

                    },
                    child: Icon(Icons.arrow_forward,color: Colors.white,)),

              ],
            ),
          ),
        )



      ],)
              :
          Container(
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
               SvgPicture.asset('assets/images/emoji_laugh.svg'),
                SizedBox(height: 20,),
                Text("No Order Yet".tr,style: TextStyle(color: blue,fontSize: 25,fontWeight: FontWeight.bold),)

          ],),)
              :

          Center(
                  child: CircularProgressIndicator(color: Colors.blue,),
                ));
    });



  }

  // Widget orderWidget(OrderScreenProvider data) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         /*   Container(
  //         width: Get.width,
  //         height: Get.height * .065,
  //         margin: EdgeInsets.symmetric(vertical: Get.height * .02),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(8),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Color(0xff000000).withOpacity(.13),
  //               spreadRadius: .08,
  //               blurRadius: 1,
  //             ),
  //           ],
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: [
  //             Expanded(
  //               child: Center(
  //                 child: Container(
  //                   margin: EdgeInsets.only(
  //                       left: 16, right: 16),
  //                   child: AwesomeDropdownForSortingOrders(),
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               width: 2,
  //               height: Get.height * .035,
  //               color: Color(0xff000000).withOpacity(.20),
  //             ),
  //             Expanded(
  //               child: Center(child: AwesomeDropdownForFiltrationOrder()),
  //             )
  //           ],
  //         ),
  //       ),
  //       InkWell(onTap: (){
  //         data.setOrderRevesreValue(!data.isReverseOrders);
  //       },child: Align(child: Icon(Icons.sort,size: 35,),alignment: Alignment.topRight,)),*/
  //         SizedBox(
  //           height: 10,
  //         ),
  //         Column(
  //             children: data.isInprogressCompletedOrderDataLoaded
  //                 ? List.generate(
  //                     data.completedOrInProgressOrderByUserIdFromJson.result
  //                         .length, (index) {
  //                     GetcompletedOrders.Result result;
  //
  //                     if (data.isReverseOrders) {
  //                       print("eee true");
  //                       result = data.completedOrInProgressOrderByUserIdFromJson
  //                           .result.reversed
  //                           .elementAt(index);
  //                     } else {
  //                       result = data.completedOrInProgressOrderByUserIdFromJson
  //                           .result[index];
  //                     }
  //                     bool orderStatus = result.isCompleted;
  //
  //                     if (data.filterOrders.contains("Completed".tr)) {
  //                       if (!result.isCompleted) {
  //                         result = null;
  //                       }
  //                     } else if (data.filterOrders.contains("In Progress".tr)) {
  //                       if (result.isCompleted ||
  //                           result.orderStatusId.toString() == "5") {
  //                         result = null;
  //                       }
  //                     } else if (data.filterOrders.contains("Rejected".tr)) {
  //                       if (result.isCompleted ||
  //                           result.orderStatusId.toString() == "3") {
  //                         result = null;
  //                       }
  //                     }
  //
  //                     return result == null
  //                         ? Container()
  //                         : InkWell(
  //                             onTap: () {
  //                               onTapOrderItem(data, index);
  //                             },
  //                             child: Padding(
  //                               padding: const EdgeInsets.only(left: 10,right: 10),
  //                               child: Container(
  //                                 width: Get.width,
  //                                 padding: EdgeInsets.symmetric(
  //                                   vertical: Get.height * .02,
  //                                   horizontal: Get.width * .05,
  //                                 ),
  //                                 margin:
  //                                     EdgeInsets.only(bottom: Get.height * .02),
  //                                 decoration: BoxDecoration(
  //                                   color: Colors.white,
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   boxShadow: [
  //                                     BoxShadow(
  //                                       color: Color(0xff000000).withOpacity(.13),
  //                                       spreadRadius: .08,
  //                                       blurRadius: 1,
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 child: Column(
  //                                   crossAxisAlignment: CrossAxisAlignment.start,
  //                                   children: [
  //                                     Row(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.spaceBetween,
  //                                       children: [
  //                                         Container(
  //                                           width: 90,
  //                                           height: 25,
  //                                           margin: EdgeInsets.only(bottom: 10),
  //                                           decoration: BoxDecoration(
  //                                             color: orderStatus == 4
  //                                                 ? Color(0xff17CE3F)
  //                                                     .withOpacity(.30)
  //                                                 : Color(0xffFFD037)
  //                                                     .withOpacity(.28),
  //                                             borderRadius:
  //                                                 BorderRadius.circular(30),
  //                                           ),
  //                                           child: Center(
  //                                             child: Text(
  //                                               orderStatus
  //                                                   ? 'Completed'.tr
  //                                                   : !orderStatus &&
  //                                                           result.orderStatusId
  //                                                                   .toString() ==
  //                                                               "3"
  //                                                       ? 'In progress'.tr
  //                                                       : 'Rejected'.tr,
  //                                               style: TextStyle(
  //                                                 color: orderStatus
  //                                                     ? Color(0xff17CE3F)
  //                                                     : !orderStatus &&
  //                                                             result.orderStatusId
  //                                                                     .toString() ==
  //                                                                 "3"
  //                                                         ? Color(0xffFFD037)
  //                                                         : Color(0xffff3737),
  //                                                 fontSize: Get.height * .017,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                         result.isTechnicianOrder
  //                                             ? Container(
  //                                                 width: 90,
  //                                                 height: 25,
  //                                                 margin:
  //                                                     EdgeInsets.only(bottom: 10),
  //                                                 decoration: BoxDecoration(
  //                                                   color: Color(0xFF0F9BDC),
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(30),
  //                                                 ),
  //                                                 child: Center(
  //                                                   child: Text(
  //                                                     "Technician".tr,
  //                                                     style: TextStyle(
  //                                                       color: Color(0xFFE8F5E9),
  //                                                       fontSize:
  //                                                           Get.height * .019,
  //                                                     ),
  //                                                   ),
  //                                                 ),
  //                                               )
  //                                             : Container(),
  //                                       ],
  //                                     ),
  //                                     Row(
  //                                       children: [
  //                                         Expanded(
  //                                           child: headingNameColumnWidget(
  //                                               'order no'.tr,
  //                                               '${result.orderId}'),
  //                                         ),
  //                                         Expanded(
  //                                           child: headingNameColumnWidget(
  //                                               'order date'.tr,
  //                                               '${result.creationDate}'.replaceAll("T00:00:00", "")),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     SizedBox(height: 12),
  //                                     headingNameColumnWidget('Issue type'.tr,
  //                                         '${getAllissue2(data, index)}'),
  //                                     SizedBox(height: 12),
  //                                     Row(
  //                                       children: [
  //                                         Expanded(
  //                                           child: headingNameColumnWidget(
  //                                               'Car'.tr, '${result.carName}'),
  //                                         ),
  //                                         Expanded(
  //                                           child: headingNameColumnWidget(
  //                                               'Total cost'.tr,
  //                                               '${"SR".tr} ${double.parse(result.totalCost.toString()).toInt().toString()}'),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           );
  //                   })
  //                 : [
  //                     Center(
  //                       child: CircularProgressIndicator(
  //                         backgroundColor: themeColor,
  //                       ),
  //                     )
  //                   ]),
  //       ],
  //     ),
  //   );
  // }





  String getAllissue(List<GetcompletedOrders.Fault> faults) {
    List<String> data = [];
    for (int i = 0; i < faults.length; i++) {
      data.add(faults[i].name);
    }
    return data.toString().replaceAll("[", "").replaceAll("]", "");
  }

  String getAllissue2(OrderScreenProvider datas, int index) {
    var faults =
        datas.completedOrInProgressOrderByUserIdFromJson.result[index].faults;
    List<String> data = [];
    for (int i = 0; i < faults.length; i++) {
      data.add(faults[i].name);
    }
    return data.toString().replaceAll("[", "").replaceAll("]", "");
  }

  int getAverageOfferTime(List<Offer> offers) {
    int days = 0;
    offers.forEach((element) {
      days = days + element.timeInDays;
    });
    return days ~/ offers.length;
  }

  // onTapOrderItem(OrderScreenProvider data, int index) {
  //   var isCompleted = data
  //       .completedOrInProgressOrderByUserIdFromJson.result[index].isCompleted;
  //   if (isCompleted ||
  //       data.completedOrInProgressOrderByUserIdFromJson.result[index]
  //               .orderStatusId
  //               .toString() ==
  //           "5") {
  //     print(data.completedOrInProgressOrderByUserIdFromJson.result[index]);
  //     Get.to(OrderDetailsCompleted(data.completedOrInProgressOrderByUserIdFromJson.result[index]));
  //   } else if (data.completedOrInProgressOrderByUserIdFromJson.result[index]
  //           .orderStatusId
  //           .toString() ==
  //       "3") {
  //     // Get.to(() => OrderTracking(data.completedOrInProgressOrderByUserIdFromJson.result[index].orderId));
  //     Get.to(() => Get.to(OrderTracking(null,true,data.completedOrInProgressOrderByUserIdFromJson.result[index].orderId)));
  //   }
  // }

  headingNameColumnWidget(String heading, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            color: Color(0xff1E1E1E).withOpacity(.70),
            fontSize: Get.height * .018,
          ),
        ),
        SizedBox(height: Get.height * .007),
        Text(
          name,
          style: TextStyle(
            color: themeColor,
            fontSize: Get.height * .022,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  workShopButton(Result result, OrderScreenProvider data) {
    return GestureDetector(
      onTap: () {
        // if(result.offers.length!=0){
        data.setWorkshopOffers(result.offers);
        //   Get.to(WorkShopOffer(result.orderId.toString()));
        // }
        //
        //
        // Get.to(OrderOfferScreen(result));
      },
      child: Container(
        width: Get.width,
        height: Get.height * .065,
        margin: EdgeInsets.symmetric(vertical: Get.height * .01),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: themeColor, width: 1),
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
          '${result.offers.length} ${"workshop offer".tr}',
          style: TextStyle(
            color: themeColor,
            fontWeight: FontWeight.w600,
            fontSize: Get.height * .02,
          ),
        ),
      ),
    );
  }

  _divider() {
    return Divider(color: Color(0xff000000).withOpacity(.18), thickness: 1);
  }
}
