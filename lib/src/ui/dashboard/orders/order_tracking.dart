import 'package:get/get.dart';
import 'package:musan_client/api_services/response_models/GetCompletedOrInProgressOrderByUserId.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'dart:ui';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoder/geocoder.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';

import '../../../../ColumnCard.dart';

// class OrderTracking extends StatefulWidget {
//   // final OfferCustomObjectResult result;
//   int orderId;
//   OrderTracking(this.orderId,  {Key key}) : super(key: key);
//
//   @override
//   _OrderTrackingState createState() => _OrderTrackingState(this.orderId);
// }
// class _OrderTrackingState extends State<OrderTracking> {
//   _OrderTrackingState(this.orderId);
//
//
//   bool isExapnded=false;
//
//   int orderChecked;
//
//   int orderId;
//
//   bool isWorkShopAddressSet = false;
//   bool opensheet = false;
//   bool isRatingShowed = true;
//   String addressWorkshop = " ";
//   _getSingleOrder() {
//     // loadOffersAndOrdersAgain();
//     orderChecked = 0;
//     Future.delayed(Duration.zero, () {
//       var orderScreenProvider = Provider.of<OrderScreenProvider>(Get.context, listen: false);
//       orderScreenProvider.setSignleOrder(false, null);
//       orderScreenProvider.setSignleOrderID(orderId.toString());
//       ApiServices.getSignleOrderByUserID(orderId.toString());
//       opensheet = true;
//       setState(() {});
//     });
//     print("Order ID: $orderId");
//   }
//   // GetSingleOrderByUserId
//   @override
//   void initState() {
//     super.initState();
//     _getSingleOrder();
//
//     analytics.logScreenView(screenName: "ORDER TRACKING",screenClass:"OrderTracking");
//
//     controller.addListener(() {
//       isExapnded= !isExapnded;
//       setState(() {
//       });
//     });
//   }
//
//   final ExpandableController controller= ExpandableController(initialExpanded: false);
//
//   void _getWorkShopLocation(Result result) {
//     WorkshopLocation workshopLocation = result.workshopLocation;
//     logger.e(workshopLocation.latitude);
//     logger.e(workshopLocation.longitude);
//     final coordinates = new Coordinates(workshopLocation.latitude, workshopLocation.longitude);
//     Geocoder.local.findAddressesFromCoordinates(coordinates).then((addresses) {
//       Address address = addresses.first;
//       print(address.addressLine);
//       if (address.addressLine != null) {
//         setState(() {
//           isWorkShopAddressSet = true;
//           addressWorkshop =address.addressLine;
//         });
//         //
//         if(!result.isTechnicianOrder){
//           // _showMapNavigationBottomSheet(workshopLocation.latitude, workshopLocation.longitude);
//         }
//
//
//       }
//     });
//   }
//   _ratingDialoge(Result result) {
//     Future.delayed(Duration(seconds:0), () {
//       if (isRatingShowed) {
//         if (result.orderRating == null) {
//           String rating = "5";
//           String feedback = "";
//           Get.dialog(Center(
//             child: Material(
//               color: Colors.transparent,
//               child: Padding(
//
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//
//                 child: Container(
//
//                     width: Get.width,
//
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.all(Radius.circular(8))),
//
//                     child: ListView(
//
//                       shrinkWrap: true,
//
//                       children: [
//
//                         SizedBox(
//                           height: 10,
//                         ),
//
//                         Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Text(
//                             '${"Order number".tr} \n${"Please rate and comment this workshop".tr}',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontSize: 18),
//                           ),
//                         ),
//
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 18),
//                           child: Text('Rate'.tr, style: TextStyle(fontSize: 20)),
//                         ),
//
//                         // Padding(
//                         //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                         //   child: Transform(
//                         //     alignment: Alignment.center,
//                         //     transform:  Matrix4.rotationY(math.pi),
//                         //     child: SmoothStarRating(
//                         //         allowHalfRating: true,
//                         //         onRated: (v) {
//                         //           print(v);
//                         //           rating = v.toString();
//                         //         },
//                         //         starCount: 5,
//                         //         rating: 0,
//                         //         size: 45.0,
//                         //         isReadOnly: false,
//                         //         // fullRatedIconData: Icons.blur_off,
//                         //         // halfRatedIconData: Icons.blur_on,
//                         //         color: Color(0xFFFAB002),
//                         //         borderColor: Color(0xFFFAB002),
//                         //         spacing: 0.0),
//                         //   ),
//                         // ),
//
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                           child: RatingBar.builder(
//                             initialRating: 5,
//                             minRating: 0,
//                             direction: Axis.horizontal,
//                             allowHalfRating: true,
//                             itemCount: 5,
//
//                             itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                             itemBuilder: (context, _) => Icon(
//                               Icons.star,
//                               color: Colors.amber,
//                             ),
//                             onRatingUpdate: (ratinga) {
//                               print(rating);
//                               rating = ratinga.toString();
//                             },
//                           ),
//                         ),
//
//                         Padding(
//                           padding: const EdgeInsets.all(18.0),
//                           child: Container(
//                             height: 100,
//                             decoration: BoxDecoration(
//                               color: Colors.grey.withOpacity(0.1),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(8),
//                               ),
//                               border: Border.all(width: 0.5),
//                             ),
//                             child: TextFormField(
//                               onTap: () {
//                                 // Get.forceAppUpdate();
//                               },
//                               onChanged: (value) {
//                                 feedback = value;
//                               },
//                               style: TextStyle(
//                                 fontSize: Get.height * .02,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                               textInputAction: TextInputAction.done,
//                               decoration: InputDecoration(
//                                 // floatingLabelBehavior: FloatingLabelBehavior.always,
//                                 // isDense: true,
//                                 // filled: true,
//                                   hintText: "Feedback".tr,
//                                   border: InputBorder.none,
//                                   contentPadding: EdgeInsets.all(5)),
//                               cursorColor: Colors.black,
//                               textAlign: TextAlign.left,
//                               enabled: true,
//                               maxLines: null,
//                               maxLength: null,
//                             ),
//                           ),
//                         ),
//
//                         Padding(
//                           padding: const EdgeInsets.all(18.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               if (rating.isEmpty || rating == "0") {
//                                 TOASTS("Select Star Rating".tr);
//                               }
//                               else if (feedback.isEmpty) {
//                                 TOASTS("Please Write review".tr);
//                               }
//                               else {
//                                 Get.back();
//                                 Get.dialog(Center(
//                                   child: CircularProgressIndicator(),
//                                 ));
//                                 ApiServices.giveFeedBack(result.orderId, rating, feedback,isRefreshHomeScreenData: true);
//                               }
//                             },
//                             child: Container(
//                               width: Get.width,
//                               height: Get.height * .065,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 color: themeColor,
//                                 borderRadius: BorderRadius.circular(8),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color(0xff000000).withOpacity(.13),
//                                     spreadRadius: .08,
//                                     blurRadius: 1,
//                                   ),
//                                 ],
//                               ),
//                               child: Text(
//                                 "Confirm".tr,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: Get.height * .02,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         InkWell(
//                           onTap: () {
//                             Get.back();
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(18.0),
//                             child: Center(
//                                 child: Text("Cancel".tr,
//                                     style:
//                                     TextStyle(fontSize: 20, color: blue))),
//                           ),
//                         )
//
//                       ],
//
//                     )
//                 ),
//               ),
//             ),
//           )
//           );
//         }
//         isRatingShowed = false;
//       }
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) => Consumer<OrderScreenProvider>(builder: (builder, data, child) {
//
//     if (data.isSingleOrderDataLoaded && opensheet & Get.currentRoute.contains("OrderTracking")) {
//       checkAndSeePendingPayments(data.singleOrderByUserIdFromJson.result);
//       if (!isWorkShopAddressSet) {
//         _getWorkShopLocation(data.singleOrderByUserIdFromJson.result);
//       }
//       if (data.isSingleOrderDataLoaded) {
//         if (data.singleOrderByUserIdFromJson.result.isCarPickupOrdered) {
//           if (setOrderStatus(4,data.singleOrderByUserIdFromJson.result.orderSteps) ==
//               "Completed".tr) {
//             /// show dialoge for rating
//             _ratingDialoge(data.singleOrderByUserIdFromJson.result);
//           }
//         }
//         else {
//           if (setOrderStatus(2, data.singleOrderByUserIdFromJson.result.orderSteps) ==
//               "Completed".tr) {
//             /// show dialoge for rating
//             _ratingDialoge(data.singleOrderByUserIdFromJson.result);
//           }
//         }
//       }
//     }
//     if (data.isSingleOrderDataLoaded){
//       if(data.singleOrderByUserIdFromJson.result.isTechnicianOrder
//           && data.singleOrderByUserIdFromJson.result.isCompleted){
//         Get.back();
//       }
//     }
//
//
//
//     return Container(
//       color: Colors.blue,
//       child: Material(
//         color: Colors.white,
//         child:
//         data.isSingleOrderDataLoaded ?
//
//         Container(
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       color: Colors.blue,
//                       height: Get.height * 0.28,
//                     ),
//                     Expanded(
//                       child: Container(color: Colors.grey.shade200),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Container(
//                       constraints: BoxConstraints(
//                           minHeight: Get.height * 0.37,
//                           minWidth: double.infinity),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//
//                               Column(
//                                 children: [
//                                   Text("Order #".tr,
//                                       style: TextStyle(
//                                           fontSize: 16.5,
//                                           color: Colors.white)),
//                                   Text(
//                                     "${data.singleOrderByUserIdFromJson.result.orderId}",
//                                     style: TextStyle(
//                                         fontSize: Get.height * 0.022,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                               Container(
//                                 width: 25,
//                               )
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 bottom: 18, left: 18, right: 18, top: 10),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(20),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.grey,
//                                         blurRadius: 1,
//                                         spreadRadius: .1)
//                                   ]),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: ExpandablePanel(
//                                   controller: controller,
//                                   theme: ExpandableThemeData(
//                                       iconColor: Colors.black, iconSize: 30),
//                                   header: Text(
//                                     getAllissue(data.singleOrderByUserIdFromJson.result.faults),
//                                     style: TextStyle(
//                                         color: Colors.blue,
//                                         fontSize: Get.height * 0.022,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   collapsed: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             color: data.singleOrderByUserIdFromJson.result.isCompleted ? Colors.greenAccent.withOpacity(0.75) :  Colors.orangeAccent.withOpacity(0.75),
//                                             borderRadius:
//                                             BorderRadius.circular(5)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 10, vertical: 6),
//                                           child: Text(
//
//                                             data.singleOrderByUserIdFromJson.result.isCompleted ?
//                                             "Completed".tr : "in progress".tr,
//                                             style: TextStyle(
//                                                 color: data.singleOrderByUserIdFromJson.result.isCompleted ? Colors.green:  Colors.deepOrange,
//                                                 fontWeight: FontWeight.w500),
//                                             softWrap: true,
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 15,
//                                       ),
//
//                                       workhsopProfileWidget(data.singleOrderByUserIdFromJson.result),
//                                       SizedBox(
//                                         height: 15,
//                                       )
//                                     ],
//                                   ),
//                                   expanded: Container(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                       border: Border(
//                                                         right: BorderSide(
//                                                             color:
//                                                             Colors.grey.shade200,
//                                                             width: 0.5),
//                                                         top: BorderSide(
//                                                             color:
//                                                             Colors.grey.shade200,
//                                                             width: 1),
//                                                         bottom: BorderSide(
//                                                             color:
//                                                             Colors.grey.shade200,
//                                                             width: 1),
//                                                       )),
//                                                   child: Padding(
//                                                     padding: const EdgeInsets.all(
//                                                         15.0),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                       CrossAxisAlignment
//                                                           .start,
//                                                       children: [
//                                                         Text("Order #".tr,
//                                                             style: TextStyle(
//                                                                 fontSize:
//                                                                 Get.height *
//                                                                     0.018,
//                                                                 color: Colors
//                                                                     .blueGrey)),
//                                                         SizedBox(
//                                                           height: 5,
//                                                         ),
//                                                         Text(
//                                                           "${data.singleOrderByUserIdFromJson.result.orderId}",
//                                                           style: TextStyle(
//                                                               fontSize:
//                                                               Get.height *
//                                                                   0.02,
//                                                               fontWeight:
//                                                               FontWeight.bold,
//                                                               color:
//                                                               Colors.black),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 )),
//                                             Expanded(
//                                                 child: Container(
//                                                   decoration: BoxDecoration(
//                                                       border: Border(
//                                                         left: BorderSide(
//                                                             color:
//                                                             Colors.grey.shade200,
//                                                             width: 0.5),
//                                                         top: BorderSide(
//                                                             color:
//                                                             Colors.grey.shade200,
//                                                             width: 1),
//                                                         bottom: BorderSide(
//                                                             color:
//                                                             Colors.grey.shade200,
//                                                             width: 1),
//                                                       )),
//                                                   child: Padding(
//                                                     padding: const EdgeInsets.all(
//                                                         15.0),
//                                                     child: Center(
//                                                       child: Column(
//                                                         crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                         children: [
//                                                           Text("Date".tr,
//                                                               style: TextStyle(
//                                                                   fontSize:
//                                                                   Get.height *
//                                                                       0.018,
//                                                                   color: Colors
//                                                                       .blueGrey)),
//                                                           SizedBox(
//                                                             height: 5,
//                                                           ),
//                                                           Text(
//                                                             "${DateFormat('yyyy-MM-dd').format(DateTime.parse(data.singleOrderByUserIdFromJson.result.creationDate))}",
//                                                             style: TextStyle(
//                                                                 fontSize:
//                                                                 Get.height *
//                                                                     0.018,
//                                                                 fontWeight:
//                                                                 FontWeight
//                                                                     .bold,
//                                                                 color:
//                                                                 Colors.black),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ],
//                                         ),
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                         Padding(
//                                           padding:
//                                           const EdgeInsets.only(left: 10),
//                                           child: Column(
//                                             children: [
//                                               Text(
//                                                 "Car".tr,
//                                                 style: TextStyle(
//                                                     fontSize:
//                                                     Get.height * 0.020,
//                                                     color: Colors.blueGrey),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                           const EdgeInsets.only(left: 10),
//                                           child: Column(
//                                             children: [
//                                               Text(
//                                                 "${data.singleOrderByUserIdFromJson.result.carName}",
//                                                 style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize:
//                                                   Get.height * 0.018,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 10,
//                                         ),
//                                         Container(
//                                           height: 1,
//                                           color: Colors.grey.shade200,
//                                         ),
//                                         SizedBox(
//                                           height: 5,
//                                         ),
//                                         /* Padding(
//                                           padding:
//                                           const EdgeInsets.only(left: 10),
//                                           child: Text(
//                                             result.orderAttachments.length > 0
//                                                 ? "Attachments".tr
//                                                 : "",
//                                             style: TextStyle(
//                                                 color: Colors.blueGrey),
//                                           ),
//                                         ),
//                                         Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 10),
//                                             child: SingleChildScrollView(
//                                               scrollDirection:
//                                               Axis.horizontal,
//                                               child: Row(
//                                                 children: List.generate(
//                                                     result.orderAttachments
//                                                         .length, (index) {
//                                                   print(
//                                                       result.orderAttachments[
//                                                       index]);
//                                                   return Padding(
//                                                     padding:
//                                                     const EdgeInsets.all(
//                                                         8.0),
//                                                     child: Container(
//                                                         width: 85,
//                                                         height: 85,
//                                                         decoration: BoxDecoration(
//                                                             color: Colors.grey
//                                                                 .shade200,
//                                                             borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                                 15),
//                                                             image: DecorationImage(
//                                                                 image: NetworkImage('https://muapi.deeps.info/' +
//                                                                     result
//                                                                         .orderAttachments[
//                                                                     index]
//                                                                         .attachmentLink
//                                                                         .toString()),
//                                                                 fit: BoxFit
//                                                                     .fill))),
//                                                   );
//                                                 }),
//                                               ),
//                                             )),*/
//
//                                         Padding(
//                                           padding:
//                                           const EdgeInsets.only(left: 10),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "Location".tr,
//                                                 style: TextStyle(
//                                                     fontSize:
//                                                     Get.height * 0.020,
//                                                     color: Colors.blueGrey),
//                                               ),
//                                               Text(
//                                                 'workshopAddress?',
//                                                 style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize:
//                                                   Get.height * 0.018,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         SizedBox(height: 10,),
//                                         Padding(
//                                           padding:
//                                           const EdgeInsets.only(left: 10),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "Distance".tr,
//                                                 style: TextStyle(
//                                                     fontSize:
//                                                     Get.height * 0.020,
//                                                     color: Colors.blueGrey),
//                                               ),
//                                               Text(
//                                                 "distance?",
//                                                 style: TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize:
//                                                   Get.height * 0.018,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.symmetric(vertical: 10),
//                                           child: workhsopProfileWidget(data.singleOrderByUserIdFromJson.result),
//                                         )
//
//                                       ],
//
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                         child: Container(
//                           child: SingleChildScrollView(
//                             padding: EdgeInsets.zero,
//                             child: Column(children: [
//                               ColumnCard(
//                                 color: white,
//                                 isElevated: false,
//                                 children: [
//                                   Container(height: 10,),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       Get.locale.toString().contains("ar")
//                                           ?
//                                       MainAxisAlignment.end
//                                           :
//                                       MainAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Invoices Details'.tr,
//                                           style: TextStyle(color: grey,fontWeight: FontWeight.bold),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//
//                                     child: Column(
//                                       children: List.generate(
//                                           data.singleOrderByUserIdFromJson.result.orderParts.length,
//                                               (index) => Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.all(
//                                                     8.0),
//                                                 child: Row(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                     children: getOrderPart1(data.singleOrderByUserIdFromJson.result,index)
//                                                 ),
//                                               ),
//
//                                               !data.singleOrderByUserIdFromJson.result.orderParts[index].isApproved
//                                                   &&
//                                                   data.singleOrderByUserIdFromJson.result.orderParts[index].pendingApproval
//
//                                                   ?
//
//                                               Row(
//                                                 children: [
//                                                   InkWell(
//                                                     onTap: (){
//
//                                                     },
//                                                     child: Padding(
//                                                       padding: const EdgeInsets.only(left: 8),
//                                                       child: Container(
//                                                           decoration: BoxDecoration(color: blue.withOpacity(0.15),
//                                                               borderRadius: BorderRadius.circular(5)),
//                                                           child: Padding(
//                                                             padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
//                                                             child: Row(
//
//                                                               children: [
//
//                                                                 Icon(Icons.check,color: green,),
//                                                                 Text('Accept & Pay'.tr,style: TextStyle(color: Colors.black),),
//                                                               ],
//                                                             ),
//                                                           )),
//                                                     ),
//                                                   ),
//                                                   InkWell(
//                                                     onTap: (){
//
//                                                     },
//                                                     child: Padding(
//                                                       padding: const EdgeInsets.only(left: 8),
//                                                       child: Container(
//                                                           decoration: BoxDecoration(color: blue.withOpacity(0.15),
//                                                               borderRadius: BorderRadius.circular(5)),
//                                                           child: Padding(
//                                                             padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
//                                                             child: Row(
//                                                               children: [
//                                                                 Icon(Icons.close,color: red,),
//                                                                 Text('Reject'.tr,style: TextStyle(color: Colors.black),),
//                                                               ],
//                                                             ),
//                                                           )),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                                   :
//                                               Container()
//
//                                               // Row(
//                                               //     mainAxisAlignment:
//                                               //     MainAxisAlignment
//                                               //         .spaceBetween,
//                                               //     children: getOrderPart2(result, index)
//                                               // ),
//                                             ],
//                                           )),
//                                     ),
//                                   ),
//                                   Divider(
//                                     color: grey,
//                                     thickness: 0.5,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: getTextList('Name'.tr,'${data.singleOrderByUserIdFromJson.result.workshopName.name}'),
//                                     ),
//                                   ),
//                                   !data.singleOrderByUserIdFromJson.result.isTechnicianOrder ? Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: getTextList('Issue type'.tr,getFualts(data.singleOrderByUserIdFromJson.result)??""),
//
//
//                                     ),
//                                   ) : Container(),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: getTextList('Comment'.tr,data.singleOrderByUserIdFromJson.result.comments??""),
//
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: getTextList("VAT".tr,'${"SR".tr} ${data.singleOrderByUserIdFromJson.result.vatCost.toString()}'),
//                                     ),
//                                   ),
//                                   Visibility(
//                                     visible: false,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children:  getTextList('Musan fee'.tr,'${"SR".tr} ${double.parse(data.singleOrderByUserIdFromJson.result.musanFee.toString()).toStringAsFixed(1)}'),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: getTextList('Work cost'.tr,'${"SR".tr} ${double.parse(data.singleOrderByUserIdFromJson.result.workCost.toString()).toStringAsFixed(2)}',),
//                                     ),
//                                   ),
//                                   data.singleOrderByUserIdFromJson.result.orderParts.length!=0?
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: getTextList('Part cost'.tr, '${"SR".tr} ${getPartCost(data.singleOrderByUserIdFromJson.result)}',),
//
//                                     ),
//                                   )
//                                       :
//                                   Container(),
//                                   Container(height: 1,color: Colors.grey.withOpacity(0.5),),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: getTextList('Total cost'.tr, '${"SR".tr} ${double.parse(data.singleOrderByUserIdFromJson.result.totalCost.toString()).toStringAsFixed(2)}',detailWeight: FontWeight.bold,detailsColor: Colors.blue,headingColor: grey),
//
//
//
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: getTextList('Duration'.tr,'${double.parse(data.singleOrderByUserIdFromJson.result.timeInDays.toString()).toInt()} ${"Days".tr}',detailWeight: FontWeight.bold,detailsColor: Colors.blue,headingColor: grey),
//                                     ),
//                                   ),
//                                   data.singleOrderByUserIdFromJson.result
//                                       .isDownPaymentRequested &&
//                                       !data.singleOrderByUserIdFromJson.result
//                                           .isDownPaymentCompleted ||
//                                       data.singleOrderByUserIdFromJson.result
//                                           .editsPending ||
//                                       checkAnyPartIsInPendingApproval(data.singleOrderByUserIdFromJson.result) ||
//                                       !data.singleOrderByUserIdFromJson.result
//                                           .isFinalPaymentCleared &&
//                                           checkFinalBillIsNeededToShowOrNot(data.singleOrderByUserIdFromJson.result) ==
//                                               "Completed".tr
//                                       ? InkWell(
//                                     onTap: () {
//                                       checkAndSeePendingPayments(data.singleOrderByUserIdFromJson.result);
//                                     },
//                                     child: Container(
//                                       width: Get.width,
//                                       height: Get.height * .065,
//                                       decoration: BoxDecoration(
//                                         color: Colors.transparent,
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(
//                                             color: themeColor, width: 1),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           'See Pending Approvals'.tr,
//                                           style: TextStyle(
//                                             color: themeColor,
//                                             fontSize: Get.height * .02,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                       : SizedBox(),
//                                 ],
//                               ),
//
//
//                             ],),
//                           ),
//
//                         )
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
//                       child: Row(
//                         children: [
//                           Expanded(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: orangeYellow,
//                                     borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(Get.locale.toString().contains('en')? 10:0),
//                                       topLeft: Radius.circular(Get.locale.toString().contains('en')? 10:0),
//                                       bottomRight: Radius.circular(Get.locale.toString().contains('ar')? 10:0),
//                                       topRight: Radius.circular(Get.locale.toString().contains('ar')? 10:0),
//
//                                     )
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child:
//                                   Center(child: Text("Chat Room".tr,
//                                       style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15))),
//                                 ),
//                               )),
//                           Expanded(
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(Get.locale.toString().contains('ar')? 10:0),
//                                     topLeft: Radius.circular(Get.locale.toString().contains('ar')? 10:0),
//                                     bottomRight: Radius.circular(Get.locale.toString().contains('en')? 10:0),
//                                     topRight: Radius.circular(Get.locale.toString().contains('en')? 10:0),
//
//                                   ),
//                                   color: blue,
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Center(
//                                       child: Text("Call Workshop".tr,
//                                         style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),
//                                 ),
//                               )),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 setOrderStatus(0,data.singleOrderByUserIdFromJson.result.orderSteps) != "Completed".tr
//                     ? Align(
//                   alignment: Alignment(0.85,isExapnded ? -.9: -0.8),
//                   child: InkWell(
//                     onTap: (){
//                       Get.bottomSheet(orderCancelBottomSheet(data.singleOrderByUserIdFromJson.result));
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius:
//                           BorderRadius.circular(5),boxShadow: [BoxShadow(color: grey,offset: Offset(0,0.5),spreadRadius: 1,blurRadius: 5)]),
//                       child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 6),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.close,color: red,),
//                               Text(
//                                 "Cancel Order".tr,
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500),
//                                 softWrap: true,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ],)
//                       ),
//                     ),
//                   ),
//                 ) : Container(),
//               ],
//             )) : Center(child:CircularProgressIndicator()),
//       ),
//     );
//   });
//   bottomSheetForDawnPayment(Result result) {
//     if (Get.isBottomSheetOpen) {
//       return;
//     }
//     Get.bottomSheet(
//         Consumer<DashboardProvider>(builder: (builder, data, child) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 topLeft: Radius.circular(30),
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: Get.height * .02,
//                   horizontal: Get.width * .06,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: Get.width * .2,
//                       child: Divider(
//                         thickness: 5,
//                         color: Color(0xffF1F1F1),
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .02),
//                     Text(
//                       "Pay down payment".tr,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: Get.height * .022,
//                         color: headingTextColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .02),
//                     Text(
//                       "you are requested to pay down payment before staring work!".tr,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: Get.height * .02,
//                         fontWeight: FontWeight.w600,
//                         color: headingTextColor,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         var dashboardProvider = Provider.of<DashboardProvider>(
//                             Get.context,
//                             listen: false);
//
//                         dashboardProvider.setPartIdAndORderId(partID: null,  orderId: result.orderId,workshopId:result.workshopId.toString());
//
//                         Get.back();
//                         Get.dialog(Center(
//                           child: CircularProgressIndicator(),
//                         ));
//                         ApiServices.getDefaultPaymentMethods(data.userID,
//                             result.downPayment.toString(), result.orderId,
//                             result.workshopId.toString(),
//                             paymentType: "DownPayment".tr);
//                       },
//                       child: Container(
//                         width: Get.width,
//                         height: Get.height * .065,
//                         margin: EdgeInsets.symmetric(vertical: Get.height * .02),
//                         decoration: BoxDecoration(
//                           color: themeColor,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xff000000).withOpacity(.13),
//                               spreadRadius: .08,
//                               blurRadius: 1,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             '${"Pay SAR".tr} ${double.parse(result.downPayment.toString()).toInt()}',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                         ApiServices.rejectDownPayment(result.orderId.toString(),result.workshopId);
//                       },
//                       child: Text(
//                         'Reject'.tr,
//                         style: TextStyle(
//                           color: themeColor,
//                           fontSize: Get.height * .02,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }), isDismissible: true);
//   }
//   bottomSheetForEditTimeAndCost(Result result) {
//     if (Get.isBottomSheetOpen) {
//       return;
//     }
//     Get.bottomSheet(
//         Consumer<DashboardProvider>(builder: (builder, data, child) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 topLeft: Radius.circular(30),
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: Get.height * .02,
//                   horizontal: Get.width * .06,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: Get.width * .2,
//                       child: Divider(
//                         thickness: 5,
//                         color: Color(0xffF1F1F1),
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .02),
//                     Text(
//                       "${"Order number".tr} ${result.orderId}\n${"Time and cost changes".tr}",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: Get.height * .022,
//                         color: headingTextColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .02),
//                     Row(
//                       children: [
//                         Expanded(
//                             child: Center(
//                                 child: Column(
//                                   children: [
//                                     Text("Timing".tr, style: TextStyle(fontSize: 16)),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       "${result.pendingEditedDays} ${"Days"}.tr",
//                                       style: TextStyle(
//                                           color: blue,
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 ))),
//                         Expanded(
//                             child: Center(
//                                 child: Column(
//                                   children: [
//                                     Text("Work Price".tr, style: TextStyle(fontSize: 16)),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       "${"SR".tr} ${double.parse(result.pendingEditedCost.toString()).toInt()}",
//                                       style: TextStyle(
//                                           color: blue,
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 ))),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         var dashboardProvider = Provider.of<DashboardProvider>(
//                             Get.context,
//                             listen: false);
//                         dashboardProvider.setPartIdAndORderId(
//                             partID: null, orderId: result.orderId);
//                         Get.back();
//                         Get.dialog(Center(
//                           child: CircularProgressIndicator(),
//                         ));
//                         // ApiServices.getDefaultPaymentMethods(data.userID,result.pendingEditedCost.toString().toString(),
//                         //     result.orderId,paymentType:"EditTimeAndCost");
//
//                         ApiServices.acceptEditInTimeAndCost(
//                             dashboardProvider.orderId.toString(),result.workshopId.toString());
//                       },
//                       child: Container(
//                         width: Get.width,
//                         height: Get.height * .065,
//                         margin: EdgeInsets.symmetric(vertical: Get.height * .02),
//                         decoration: BoxDecoration(
//                           color: themeColor,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xff000000).withOpacity(.13),
//                               spreadRadius: .08,
//                               blurRadius: 1,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Accept'.tr,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                         Get.dialog(Center(
//                           child: CircularProgressIndicator(),
//                         ));
//                         ApiServices.rejectEditInTimeAndCost(result.orderId.toString(),result.workshopId.toString());
//                       },
//                       child: Text(
//                         'Reject'.tr,
//                         style: TextStyle(
//                           color: themeColor,
//                           fontSize: Get.height * .02,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }), isDismissible: true);
//   }
//
//   void checkAndSeePendingPayments(Result result) async {
//     Future.delayed(Duration.zero, () {
//       if (result != null) {
//         try {
//
//           if (result.isDownPaymentRequested && !result.isDownPaymentCompleted) {
//             /// show dialoge for accept down payment here
//             print("pay dawn payment");
//             bottomSheetForDawnPayment(result);
//           }
//           else if (result.editsPending) {
//             /// show sheet here to accept edit time and cost
//             print('show sheet here to accept edit time and cost');
//             bottomSheetForEditTimeAndCost(result);
//           }
//           else if (checkAnyPartIsInPendingApproval(result)) {
//             /// show sheet to accept parts approval
//             print("show sheet to accept parts approval");
//             List<OrderPart> orderParts = [];
//             for (int i = 0; i < result.orderParts.length; i++) {
//               if (result.orderParts[i].pendingApproval &&
//                   !result.orderParts[i].isApproved) {
//                 orderParts.add(result.orderParts[i]);
//               }
//             }
//             if (orderParts.length > 0) {
//               bottomSheetToAcceptOrderParts(result, orderParts);
//             }
//           }
//           else if (!result.isFinalPaymentCleared && checkFinalBillIsNeededToShowOrNot(result) == "Completed".tr && !result.isCash) {
//             // TOASTS("data");
//             bottomSheetToFinalBill(result);
//           }
//           else if(result.isCarPickupOrdered && !result.isCarPickupPaid && setOrderStatus(0,result.orderSteps) =="Completed".tr){
//             bottomSheetForCarPickPayment(result);
//
//
//           }
//
//
//
//
//
//         } catch (e) {
//           print(e);
//         }
//       }
//     });
//   }
//   void bottomSheetForCarPickPayment(Result result) {
//
//     // TOASTS("data".tr);
//
//     if (Get.isBottomSheetOpen) {
//       return;
//     }
//     Get.bottomSheet(
//         Consumer<DashboardProvider>(builder: (builder, data, child) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 topLeft: Radius.circular(30),
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: Get.height * .02,
//                   horizontal: Get.width * .06,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: Get.width * .2,
//                       child: Divider(
//                         thickness: 5,
//                         color: Color(0xffF1F1F1),
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .02),
//                     Text(
//                       "Pay Car Pick up Bill".tr,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: Get.height * .022,
//                         color: headingTextColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .005),
//                     Text(
//                       "${"SR".tr} ${result.carPickupOrderAmount}",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: Get.height * .022,
//                         color: headingTextColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .02),
//                     GestureDetector(
//                       onTap: () {
//                         var dashboardProvider = Provider.of<DashboardProvider>(
//                             Get.context,
//                             listen: false);
//                         dashboardProvider.setPartIdAndORderId(
//                           partID: null,
//                           orderId: result.orderId,
//
//                         );
//                         Get.back();
//                         Get.dialog(Center(
//                           child: CircularProgressIndicator(),
//                         ));
//
//                         // TOASTS( "result.orderId ${result.orderId}");
//
//                         dashboardProvider.setCarPickOrderID(result.carPickupOrderId.toString(),result.carPickUpId.toString());
//                         ApiServices.getDefaultPaymentMethods(data.userID,
//                             result.carPickupOrderAmount.toString(), result.orderId,
//                             result.workshopId.toString(),
//                             paymentType: "CarPickUp".tr);
//                       },
//                       child: Container(
//                         width: Get.width,
//                         height: Get.height * .065,
//                         margin: EdgeInsets.symmetric(vertical: Get.height * .02),
//                         decoration: BoxDecoration(
//                           color: themeColor,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xff000000).withOpacity(.13),
//                               spreadRadius: .08,
//                               blurRadius: 1,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Pay'.tr,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                         // Get.dialog(Center(
//                         //   child: CircularProgressIndicator(),
//                         // ));
//                         // // ApiServices.payFinalBill(result.orderId.toString(),isCash:true);
//                         // var provider =
//                         // Provider.of<DashboardProvider>(context, listen: false);
//                         // ApiServices.initPayment(
//                         //     provider.userID,
//                         //     0,
//                         //     "visa",
//                         //     (double.parse(result.totalCost.toString()) * 100)
//                         //         .toString(),
//                         //     "${result.orderId.toString()}",
//                         //     isCash: true,
//                         //     refID: result.orderId.toString());
//                       },
//                       child: Container(
//                         width: Get.width,
//                         height: Get.height * .065,
//                         decoration: BoxDecoration(
//                           color: white,
//                           border: Border.all(color: blue),
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xff000000).withOpacity(.13),
//                               spreadRadius: .08,
//                               blurRadius: 1,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Cancel'.tr,
//                             style: TextStyle(
//                                 color: themeColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }), isDismissible: true);
//
//   }
//
//   bottomSheetToAcceptOrderParts(Result result, List<OrderPart> orderParts) {
//     if (Get.isBottomSheetOpen) {
//       return;
//     }
//     Get.bottomSheet(
//         Consumer<DashboardProvider>(builder: (builder, data, child) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 topLeft: Radius.circular(30),
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: Get.height * .02,
//                   horizontal: Get.width * .06,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: Get.width * .2,
//                       child: Divider(
//                         thickness: 5,
//                         color: Color(0xffF1F1F1),
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .02),
//                     Text(
//                       "Add an invoice".tr,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: Get.height * .022,
//                         color: headingTextColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .02),
//                     Row(
//                       children: [
//                         Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 25),
//                               child:Row(
//                                 children: List.generate(
//                                     orderParts[0].pictures.length, (index){
//                                   print(orderParts[0].pictures.length);
//                                   return  InkWell(
//                                     onTap: (){
//                                       openImage("https://muapi.deeps.info/${orderParts[0].pictures[index].imageUrl}");
//                                     },
//                                     child: Image.network(
//                                       orderParts[0].pictures.length == 0
//                                           ? "https://tamam.com.pk/logoplaceholder.png"
//                                           : "https://muapi.deeps.info/${orderParts[0].pictures[index].imageUrl}",
//                                       height: 80,
//                                       width: 60,
//                                       fit: BoxFit.fill,
//                                     ),
//                                   );
//                                 }),),
//                             )),
//                         Expanded(
//                             child: Center(
//                                 child: Column(
//                                   children: [
//                                     Text(orderParts[0].partName??"", style: TextStyle(fontSize: 16)),
//                                     SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       "${"SR".tr} ${orderParts[0].partCost}",
//                                       style: TextStyle(
//                                           color: blue,
//                                           fontSize: 22,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 ))),
//                       ],
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         var dashboardProvider = Provider.of<DashboardProvider>(
//                             Get.context,
//                             listen: false);
//                         dashboardProvider.setPartIdAndORderId(
//                             partID: orderParts[0].orderPartId,
//                             orderId: result.orderId,
//                             workshopId: result.workshopId.toString());
//                         Get.back();
//                         Get.dialog(Center(
//                           child: CircularProgressIndicator(),
//                         ));
//                         ApiServices.getDefaultPaymentMethods(
//                             data.userID,
//                             orderParts[0].partCost.toString(), result.orderId,result.workshopId.toString(),
//                             paymentType: "OrderPart".tr
//                         );
//                         // ApiServices.acceptEditInTimeAndCost(
//                         //     result.orderId.toString());
//                       },
//                       child: Container(
//                         width: Get.width,
//                         height: Get.height * .06,
//                         margin: EdgeInsets.symmetric(vertical: Get.height * .02),
//                         decoration: BoxDecoration(
//                           color: themeColor,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xff000000).withOpacity(.13),
//                               spreadRadius: .08,
//                               blurRadius: 1,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Accept & Pay'.tr,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                         Get.dialog(Center(
//                           child: CircularProgressIndicator(),
//                         ));
//
//                         ApiServices.acceptPart(
//                             isPaid: false,
//                             partID: orderParts[0].orderPartId,
//                             orderId: result.orderId,
//                             workshopId:result.workshopId.toString());
//                       },
//                       child: Container(
//                         width: Get.width,
//                         height: Get.height * .06,
//                         decoration: BoxDecoration(
//                           color: white,
//                           border: Border.all(color: blue),
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xff000000).withOpacity(.13),
//                               spreadRadius: .08,
//                               blurRadius: 1,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Accept & pay later'.tr,
//                             style: TextStyle(
//                               color: blue,
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                         Get.dialog(Center(
//                           child: CircularProgressIndicator(),
//                         ));
//                         ApiServices.rejectOrderParts(
//                             orderParts[0].orderPartId, result.orderId,result.workshopId.toString());
//                       },
//                       child: Text(
//                         'Reject'.tr,
//                         style: TextStyle(
//                           color: themeColor,
//                           fontSize: Get.height * .02,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }), isDismissible: true);
//   }
//   bottomSheetToFinalBill(Result result) {
//     if (Get.isBottomSheetOpen) {
//       return;
//     }
//     Get.bottomSheet(
//         Consumer<DashboardProvider>(builder: (builder, data, child) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 topLeft: Radius.circular(30),
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: Get.height * .02,
//                   horizontal: Get.width * .06,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: Get.width * .2,
//                       child: Divider(
//                         thickness: 5,
//                         color: Color(0xffF1F1F1),
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .02),
//                     Text(
//                       "Pay Final Bill".tr,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: Get.height * .022,
//                         color: headingTextColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .005),
//                     Text(
//                       "${"SR".tr} ${double.parse(result.totalCost.toString()).toStringAsFixed(2)}",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: Get.height * .022,
//                         color: headingTextColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: Get.height * .02),
//                     GestureDetector(
//                       onTap: () {
//                         var dashboardProvider = Provider.of<DashboardProvider>(
//                             Get.context,
//                             listen: false);
//                         dashboardProvider.setPartIdAndORderId(
//                             partID: null, orderId: result.orderId,workshopId: result.workshopId.toString() );
//                         Get.back();
//                         Get.dialog(Center(
//                           child: CircularProgressIndicator(),
//                         ));
//                         ApiServices.getDefaultPaymentMethods(data.userID,
//                             result.totalCost.toString(), result.orderId,
//                             result.workshopId.toString(),
//                             paymentType: "Final Bill".tr);
//                       },
//                       child: Container(
//                         width: Get.width,
//                         height: Get.height * .065,
//                         margin: EdgeInsets.symmetric(vertical: Get.height * .02),
//                         decoration: BoxDecoration(
//                           color: themeColor,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xff000000).withOpacity(.13),
//                               spreadRadius: .08,
//                               blurRadius: 1,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Pay'.tr,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                         Get.dialog(Center(
//                           child: CircularProgressIndicator(),
//                         ));
//                         // ApiServices.payFinalBill(result.orderId.toString(),isCash:true);
//                         var provider = Provider.of<DashboardProvider>(context, listen: false);
//                         provider.setPartIdAndORderId(partID:0,orderId:result.orderId,workshopId: result.workshopId.toString());
//                         ApiServices.initPayment(
//                             provider.userID,
//                             0,
//                             "visa".tr,
//                             (double.parse(result.totalCost.toString()) * 100)
//                                 .toString(),
//                             "${result.orderId.toString()}",
//                             isCash: true,
//                             refID: result.orderId.toString());
//                       },
//                       child: Container(
//                         width: Get.width,
//                         height: Get.height * .065,
//                         decoration: BoxDecoration(
//                           color: white,
//                           border: Border.all(color: blue),
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xff000000).withOpacity(.13),
//                               spreadRadius: .08,
//                               blurRadius: 1,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Cash on Delivery'.tr,
//                             style: TextStyle(
//                                 color: themeColor,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }), isDismissible: true);
//   }
//
//
//
//   bool checkAnyPartIsInPendingApproval(Result result) {
//     for (int i = 0; i < result.orderParts.length; i++) {
//       if (result.orderParts[i].pendingApproval) {
//         print("sghghjghjg");
//
//         return true;
//       }
//     }
//
//     return false;
//   }
//
//   String checkFinalBillIsNeededToShowOrNot(Result result) {
//     try {
//       if (result.isCarPickupOrdered) {
//         /// five steps
//         if (result.orderSteps[3].orderStepStatus == 0) {
//           return "in process".tr;
//         } else
//           return "Completed".tr;
//       } else {
//         /// three steps
//         if (result.orderSteps[1].orderStepStatus == 0) {
//           return "in process".tr;
//         } else
//           return "Completed".tr;
//       }
//     } catch (e) {
//       return 'in process'.tr;
//     }
//   }
//
//   getPartCost(Result result) {
//     double priceOfParts=0;
//     for(int i=0;i<result.orderParts.length;i++){
//       if(result.orderParts[i].isApproved && !result.orderParts[i].isPaid){
//         priceOfParts=priceOfParts+ double.parse(result.orderParts[i].partCost.toString());
//       }
//     }
//     return priceOfParts;
//   }
//
//   getTextList(String title,String detail,{Color headingColor:black ,Color detailsColor:black,FontWeight detailWeight:FontWeight.w500}) {
//     List<Widget> list=[
//       Text(title ,
//           style: TextStyle(
//             color: headingColor,
//           )),
//       Text(
//         detail,
//         style: TextStyle(
//             color: detailsColor,
//             fontSize: 16,
//             fontWeight: detailWeight),
//       )];
//     return Get.locale.toString().contains("en") ? list : list.reversed.toList();
//   }
//
//   String getAllissue(List<Fault> faults) {
//     List<String> data = [];
//     for (int i = 0; i < faults.length; i++) {
//       data.add(faults[i].name);
//     }
//     return data.toString().replaceAll("[", "").replaceAll("]", "");
//   }
//
//   String setOrderStatus(int i, List<OrderStep> orderSteps) {
//     try {
//       if (i == 0) {
//         if (orderSteps[0].orderStepStatus == 0) {
//           return "in process".tr;
//           print("Gello");
//         } else
//           return "Completed".tr;
//       }
//       if (i == 1) {
//         if (orderSteps[0].orderStepStatus == 0) {
//           return " ";
//         }
//         if (orderSteps[1].orderStepStatus == 0) {
//           return "in process".tr;
//         } else
//           return "Completed".tr;
//       }
//       if (i == 2) {
//         if (orderSteps[0].orderStepStatus == 0) {
//           return " ";
//         }
//         if (orderSteps[1].orderStepStatus == 0) {
//           return " ";
//         }
//         if (orderSteps[2].orderStepStatus == 0) {
//           return "in process".tr;
//         } else
//           return "Completed".tr;
//       }
//       if (i == 3) {
//         if (orderSteps[0].orderStepStatus == 0) {
//           return " ";
//         }
//         if (orderSteps[1].orderStepStatus == 0) {
//           return " ";
//         }
//         if (orderSteps[2].orderStepStatus == 0) {
//           return "";
//         }
//         if (orderSteps[3].orderStepStatus == 0) {
//           return "in process".tr;
//         } else
//           return "Completed".tr;
//       }
//       if (i == 4) {
//         if (orderSteps[0].orderStepStatus == 0) {
//           return " ";
//         }
//         if (orderSteps[1].orderStepStatus == 0) {
//           return " ";
//         }
//         if (orderSteps[2].orderStepStatus == 0) {
//           return "";
//         }
//         if (orderSteps[3].orderStepStatus == 0) {
//           return "";
//         }
//         if (orderSteps[4].orderStepStatus == 0) {
//           return "in process".tr;
//         } else
//           return "Completed".tr;
//       }
//     } catch (e) {
//       return " ";
//     }
//
//     // try{
//     //   if( orderSteps[i].orderStepStatus==0){
//     //     return "In process";
//     //   }else{
//     //     return "Completed";
//     //   }
//     //
//     // }catch(e){
//     //   print(e);
//     //   return "In process";
//     // }
//   }
//
//   Widget workhsopProfileWidget(Result result){
//     return    Row(
//       children: [
//         Container(
//           height: Get.height * 0.07,
//           width: Get.width * 0.15,
//           decoration: BoxDecoration(
//               borderRadius:
//               BorderRadius
//                   .circular(10),
//               color: Colors
//                   .grey.shade200,
//               image: DecorationImage(
//                   fit: BoxFit.fill,
//                   image: NetworkImage(
//                       'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'))),
//         ),
//         Expanded(
//           child: Column(
//             crossAxisAlignment:
//             CrossAxisAlignment
//                 .start,
//             children: [
//               Row(
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     result.workshopName.name,
//                     style: TextStyle(
//                       color: Colors
//                           .black,
//                       fontWeight:
//                       FontWeight
//                           .bold,
//                       fontSize:
//                       Get.height *
//                           0.022,
//                     ),
//                   ),
//                   Spacer(),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.star,
//                         color: Colors
//                             .yellow
//                             .shade800,
//                         size:
//                         Get.height *
//                             0.023,
//                       ),
//                       Text(
//                         "WR/5",
//                         style: TextStyle(
//                             fontSize:
//                             Get.height *
//                                 0.018,
//                             fontWeight:
//                             FontWeight
//                                 .bold),
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     width: 10,
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 mainAxisAlignment:
//                 MainAxisAlignment
//                     .spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Icons
//                             .check_circle,
//                         color: Colors
//                             .green,
//                         size:
//                         Get.height *
//                             0.022,
//                       ),
//                       Text(
//                         "Verified Shop"
//                             .tr,
//                         style:
//                         TextStyle(
//                           color: Colors
//                               .green,
//                           fontWeight:
//                           FontWeight
//                               .bold,
//                           fontSize:
//                           Get.height *
//                               0.018,
//                         ),
//                       )
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.save,
//                         color: Colors
//                             .blue,
//                         size:
//                         Get.height *
//                             0.02,
//                       ),
//                       Text(
//                         "Offer Warranty"
//                             .tr,
//                         style: TextStyle(
//                             color: Colors
//                                 .blue,
//                             fontWeight:
//                             FontWeight
//                                 .bold,
//                             fontSize:
//                             Get.height *
//                                 0.018),
//                       )
//                     ],
//                   ),
//                   Container()
//                 ],
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
//
//   getOrderPart1(Result result, int index,{Color detailColor:black}) {
//
//     List<Widget> list=[
//       Row(
//         children: [
//           Text(
//             result
//                 .orderParts[
//             index]
//                 .partName,
//             style: TextStyle(
//                 fontSize: 15),
//           ),
//           SizedBox(width: 5,),
//           !result.orderParts[index].pendingApproval &&
//               !result.orderParts[index].isApproved
//               ?
//           Container(
//               decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.2),borderRadius: BorderRadius.circular(5)),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 5),
//                 child: Text('Rejected'.tr,style: TextStyle(color: red),),
//               ))
//               :
//           result.orderParts[index].isApproved ?
//
//           Container(
//               decoration: BoxDecoration(color: Colors.green.withOpacity(0.2),borderRadius: BorderRadius.circular(5)),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 5),
//                 child: Text('Accepted'.tr,style: TextStyle(color: green),),
//               ))
//               :
//           Container(
//               decoration: BoxDecoration(color: Colors.yellow.withOpacity(0.2),borderRadius: BorderRadius.circular(5)),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 5),
//                 child: Text('New'.tr,style: TextStyle(color: yellow),),
//               ))
//
//
//
//         ],
//       ),
//       Text(
//         '${"SR".tr} ${result.orderParts[index].partCost.toString()}',
//         style: TextStyle(
//             color: detailColor,
//             fontSize: 13,
//             fontWeight:
//             FontWeight
//                 .bold),
//       )
//     ];
//
//
//     return Get.locale.toString().contains("ar") ? list.reversed.toList() : list;
//
//
//   }
//
//   String getFualts(Result result) {
//     List<String> faults=[];
//     result.faults.forEach((element) {
//       faults.add(element.name);
//     });
//     return faults.toString().replaceAll("[", '').replaceAll("]", '');
//   }
//
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//
//     analytics.logEvent(name: "user_left_offer_screen");
//   }
//
//   orderCancelBottomSheet(Result result) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(30),
//           topLeft: Radius.circular(30),
//         ),
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             vertical: Get.height * .02,
//             horizontal: Get.width * .06,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: Get.width * .2,
//                 child: Divider(
//                   thickness: 5,
//                   color: Color(0xffF1F1F1),
//                 ),
//               ),
//               SizedBox(height: Get.height * .02),
//               Text(
//                 "Cancel order".tr,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: Get.height * .022,
//                   color: headingTextColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: Get.height * .02),
//               Text(
//                 "Are you sure you want to\ncancel this order?".tr,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: Get.height * .02,
//                   fontWeight: FontWeight.w600,
//                   color: headingTextColor,
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                   Get.back();
//                   Get.dialog(Center(child: CircularProgressIndicator(),));
//                   ApiServices.cancelOrder(result.orderId.toString(),result.workshopId.toString());
//                 },
//                 child: Container(
//                   width: Get.width,
//                   height: Get.height * .065,
//                   margin: EdgeInsets.symmetric(vertical: Get.height * .02),
//                   decoration: BoxDecoration(
//                     color: themeColor,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0xff000000).withOpacity(.13),
//                         spreadRadius: .08,
//                         blurRadius: 1,
//                       ),
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Yes'.tr,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: Get.height * .02,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: Text(
//                   'No'.tr,
//                   style: TextStyle(
//                     color: themeColor,
//                     fontSize: Get.height * .02,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }

class ApprovalChip extends StatelessWidget {
   String isCompleted;
   double fontSize;

  // const ApprovalChip({this.isCompleted = 'Waiting Approval', this.fontSize = 11});
  ApprovalChip({ String isCompleted:'Waiting Approval',double fontSize:11}){
    this.isCompleted=isCompleted.tr;
    this.fontSize=fontSize;
  }

  @override
  Widget build(BuildContext context) {
    if (isCompleted.tr == 'Accepted'.tr) {
      return Chip(
        backgroundColor: green.withOpacity(0.2),
        label: Text('Accepted'.tr,
            style: TextStyle(
                color: green, fontSize: fontSize, fontWeight: FontWeight.bold)),
      );
    }
    else if (isCompleted.tr == 'Rejected'.tr) {
      return Chip(
        backgroundColor: red.withOpacity(0.2),
        label: Text('Rejected'.tr,
            style: TextStyle(
                color: red, fontSize: fontSize, fontWeight: FontWeight.bold)),
      );
    }
    else if (isCompleted.tr == 'Waiting Approval'.tr)
    {
      return Chip(
        backgroundColor: yellow.withOpacity(0.2),
        label: Text('Waiting Approval'.tr,
            style: TextStyle(
                color: yellow,
                fontSize: fontSize,
                fontWeight: FontWeight.bold)),
      );
    }
  }



}