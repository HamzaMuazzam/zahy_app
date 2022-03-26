// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:musan_client/FCM.dart';
// import 'package:musan_client/OrderOfferScreen.dart';
// import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart';
// import 'package:musan_client/api_services/response_models/GetCompletedOrInProgressOrderByUserId.dart'
//     as GetcompletedOrders;
// import 'package:musan_client/src/provider/OrderScreenProvider.dart';
// import 'package:musan_client/src/provider/dashboard_provider.dart';
// import 'package:musan_client/src/ui/dashboard/orders/order_tracking_new.dart';
// import 'package:musan_client/src/ui/order_booking_screens/utils.dart';
// import 'package:musan_client/utils/colors.dart';
// import 'package:provider/provider.dart';
//
//
// class OrderScreen extends StatefulWidget {
//   @override
//   _OrderScreenState createState() => _OrderScreenState();
// }
//
// class _OrderScreenState extends State<OrderScreen>
//     with TickerProviderStateMixin {
//   var tabIndex = 0;
//
//   @override
//   void initState() {
//     var context = Get.context;
//     analytics.logScreenView(screenName: "OrderScreen",screenClass:"OrderScreen");
//
//
//     getOffersAndOderAtOnce();
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<OrderScreenProvider>(builder: (builder, data, child) {
//       return Scaffold(
//           backgroundColor: deepGrey,
//           body: data.isFreshOrderDataLoaded &&
//                   data.isInprogressCompletedOrderDataLoaded
//               ?
//           data.getFreshOrderByUserIdReponse.result.length+ data.completedOrInProgressOrderByUserIdFromJson.result.length!=0?
//       Stack(children: [
//         PageView(
//
//           controller: data.homePagePictureIndicatorController,
//           scrollDirection: Axis.horizontal,
//           children: List.generate(
//             data.getFreshOrderByUserIdReponse.result.length + data.completedOrInProgressOrderByUserIdFromJson.result.length,
//                 (index) {
//               return index < data.getFreshOrderByUserIdReponse.result.length
//                   ?
//               OrderOfferScreen(data.getFreshOrderByUserIdReponse.result[index])
//                   :
//               OrderTracking(data.completedOrInProgressOrderByUserIdFromJson.result[index-data.getFreshOrderByUserIdReponse.result.length],false,null);
//
//             },
//           ),
//           onPageChanged: (index) {
//
//             /// offer screen view pager
//
//           },
//         ),
//         Align(
//           alignment: Alignment(0,-0.88),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               children: [
//
//                 InkWell(
//                     onTap: (){
//                       data.homePagePictureIndicatorController.previousPage(duration: Duration(microseconds: 1), curve: Curves.easeIn);
//
//                     },
//                     child: Icon(Icons.arrow_back,color: Colors.white,)),
//                 Expanded(child:Icon(Icons.arrow_back,color: Colors.transparent,)),
//                 InkWell(
//                     onTap: (){
//                       data.homePagePictureIndicatorController.nextPage(duration: Duration(microseconds: 1), curve: Curves.easeOut);
//
//                     },
//                     child: Icon(Icons.arrow_forward,color: Colors.white,)),
//
//               ],
//             ),
//           ),
//         )
//
//
//
//       ],)
//               :
//           Container(
//             width: Get.width,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//
//               children: [
//                SvgPicture.asset('assets/images/emoji_laugh.svg'),
//                 SizedBox(height: 20,),
//                 Text("No Order Yet".tr,style: TextStyle(color: blue,fontSize: 25,fontWeight: FontWeight.bold),)
//
//           ],),)
//               :
//
//           Center(
//                   child: CircularProgressIndicator(color: Colors.blue,),
//                 ));
//     });
//
//
//
//   }
//
//
//   String getAllissue(List<GetcompletedOrders.Fault> faults) {
//     List<String> data = [];
//     for (int i = 0; i < faults.length; i++) {
//       data.add(faults[i].name);
//     }
//     return data.toString().replaceAll("[", "").replaceAll("]", "");
//   }
//
//   String getAllissue2(OrderScreenProvider datas, int index) {
//     var faults =
//         datas.completedOrInProgressOrderByUserIdFromJson.result[index].faults;
//     List<String> data = [];
//     for (int i = 0; i < faults.length; i++) {
//       data.add(faults[i].name);
//     }
//     return data.toString().replaceAll("[", "").replaceAll("]", "");
//   }
//
//   int getAverageOfferTime(List<Offer> offers) {
//     int days = 0;
//     offers.forEach((element) {
//       days = days + element.timeInDays;
//     });
//     return days ~/ offers.length;
//   }
//
//
//   headingNameColumnWidget(String heading, String name) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           heading,
//           style: TextStyle(
//             color: Color(0xff1E1E1E).withOpacity(.70),
//             fontSize: Get.height * .018,
//           ),
//         ),
//         SizedBox(height: Get.height * .007),
//         Text(
//           name,
//           style: TextStyle(
//             color: themeColor,
//             fontSize: Get.height * .022,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
//
//   workShopButton(Result result, OrderScreenProvider data) {
//     return GestureDetector(
//       onTap: () {
//         data.setWorkshopOffers(result.offers);
//
//       },
//       child: Container(
//         width: Get.width,
//         height: Get.height * .065,
//         margin: EdgeInsets.symmetric(vertical: Get.height * .01),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: themeColor, width: 1),
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xff000000).withOpacity(.13),
//               spreadRadius: 1,
//               blurRadius: 3,
//             ),
//           ],
//         ),
//         child: Text(
//           '${result.offers.length} ${"workshop offer".tr}',
//           style: TextStyle(
//             color: themeColor,
//             fontWeight: FontWeight.w600,
//             fontSize: Get.height * .02,
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
// }
