import 'dart:ui';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:musan_client/ChatRoom.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/response_models/GetCompletedOrInProgressOrderByUserId.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../ColumnCard.dart';

class OrderTracking extends StatefulWidget {
  Result result;
  bool isFromSingleOrder;
  int orderId;

  OrderTracking(this.result, this.isFromSingleOrder, this.orderId);

  @override
  _OrderTrackingState createState() =>
      _OrderTrackingState(this.result, this.isFromSingleOrder, this.orderId);
}

class _OrderTrackingState extends State<OrderTracking> {
  Result result;

  bool isFromSingleOrder;

  int orderId;



  _OrderTrackingState(this.result, this.isFromSingleOrder, this.orderId);

  int orderChecked;

  bool isWorkShopAddressSet = false;

  bool opensheet = false;

  bool isRatingShowed = true;

  String addressWorkshop = " ";

  _getSingleOrder() {
    // loadOffersAndOrdersAgain();
    orderChecked = 0;
    Future.delayed(Duration.zero, () {
      var orderScreenProvider =
          Provider.of<OrderScreenProvider>(Get.context, listen: false);
      orderScreenProvider.setSignleOrder(false, null);
      orderScreenProvider.setSignleOrderID(orderId.toString());
      ApiServices.getSignleOrderByUserID(orderId.toString());
      opensheet = true;
      setState(() {});
    });
    print("Order ID: $orderId");
  }

  bool tempCarPickupOrdered = true;

  @override
  void initState() {
    super.initState();
    if (isFromSingleOrder) {
      _getSingleOrder();
    }

    analytics.logScreenView(
        screenName: "ORDER TRACKING", screenClass: "OrderTracking");

    controller.addListener(() {
      isFirstBoxExpanded = !isFirstBoxExpanded;
      setState(() {});
    });
  }

  final ExpandableController controller =ExpandableController(initialExpanded: false);
  bool isFirstBoxExpanded=false;

  final ExpandableController controller2 =
      ExpandableController(initialExpanded: false);
  final ExpandableController controller3 =
      ExpandableController(initialExpanded: false);

  void _getWorkShopLocation(Result result) {
    WorkshopLocation workshopLocation = result.workshopLocation;

    // final coordinates = new Coordinates(workshopLocation.latitude, workshopLocation.longitude);
    //
    // Geocoder.local.findAddressesFromCoordinates(coordinates).then((addresses) {
    //   Address address = addresses.first;
    //   print(address.addressLine);
    //   if (address.addressLine != null) {
    // setState(() {
    //   isWorkShopAddressSet = true;
    //   addressWorkshop =result.workshopAddress;
    // });

    // if(!result.isTechnicianOrder){
    logger.i(workshopLocation.latitude);
    logger.i(workshopLocation.longitude);
    showMap(workshopLocation.latitude, workshopLocation.longitude);
  }

  showMap(lat, lng, {String title: ""}) async {
    MapType mapType = MapType.google;
    if (isAndroid()) {
      mapType = MapType.google;
    } else {
      mapType = MapType.apple;
    }
    if (await MapLauncher.isMapAvailable(mapType)) {
      await MapLauncher.showMarker(
        mapType: mapType,
        coords: Coords(lat, lng),
        title: title,
        description: 'see on map',
      );
    }
  }

  _ratingDialoge(Result result) {
    Future.delayed(Duration(seconds: 0), () {
      if (isRatingShowed) {
        if (result.orderRating == null) {
          String rating = "5";
          String feedback = "";
          Get.dialog(Center(
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 10,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '${"Please rate and comment this workshop".tr}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child:
                              Text('Rate'.tr, style: TextStyle(fontSize: 20)),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        //   child: Transform(
                        //     alignment: Alignment.center,
                        //     transform:  Matrix4.rotationY(math.pi),
                        //     child: SmoothStarRating(
                        //         allowHalfRating: true,
                        //         onRated: (v) {
                        //           print(v);
                        //           rating = v.toString();
                        //         },
                        //         starCount: 5,
                        //         rating: 0,
                        //         size: 45.0,
                        //         isReadOnly: false,
                        //         // fullRatedIconData: Icons.blur_off,
                        //         // halfRatedIconData: Icons.blur_on,
                        //         color: Color(0xFFFAB002),
                        //         borderColor: Color(0xFFFAB002),
                        //         spacing: 0.0),
                        //   ),
                        // ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: RatingBar.builder(
                            initialRating: 5,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (ratinga) {
                              print(rating);
                              rating = ratinga.toString();
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              border: Border.all(width: 0.5),
                            ),
                            child: TextFormField(
                              onTap: () {
                                // Get.forceAppUpdate();
                              },
                              onChanged: (value) {
                                feedback = value;
                              },
                              style: TextStyle(
                                fontSize: Get.height * .02,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  // floatingLabelBehavior: FloatingLabelBehavior.always,
                                  // isDense: true,
                                  // filled: true,
                                  hintText: "Feedback".tr,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(5)),
                              cursorColor: Colors.black,
                              enabled: true,
                              maxLines: null,
                              maxLength: null,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: GestureDetector(
                            onTap: () {
                              if (rating.isEmpty || rating == "0") {
                                TOASTS("Select Star Rating".tr);
                              } else if (feedback.isEmpty) {
                                TOASTS("Please Write review".tr);
                              } else {
                                Get.back();
                                Get.dialog(Center(
                                  child: CircularProgressIndicator(),
                                ));
                                ApiServices.giveFeedBack(result.orderId, rating, feedback, isRefreshHomeScreenData: true);
                              }
                            },
                            child: Container(
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
                              child: Text(
                                "Confirm".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Get.height * .02,
                                ),
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Center(
                                child: Text("Cancel".tr,
                                    style:
                                        TextStyle(fontSize: 20, color: blue))),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ));
        }
        isRatingShowed = false;
      }
    });
  }

  var dashboard = Provider.of<DashboardProvider>(Get.context, listen: false);

  @override
  Widget build(BuildContext context) =>
      Consumer<OrderScreenProvider>(builder: (builder, data, child) {


        if (isFromSingleOrder && data.isSingleOrderDataLoaded) {
          result = data.singleOrderByUserIdFromJson.result;
        }
        if (result != null) {
          if (!Get.currentRoute.contains("PaymentWebView")) {
            while (Get.isBottomSheetOpen) {
              Get.back();
            }
            Future.delayed(Duration(seconds: 3), () {
              checkAndSeePendingPayments(result);

              if (result.isCarPickupOrdered) {
                if (setOrderStatus(4, result.orderSteps) == "Completed".tr) {
                  /// show dialoge for rating
                  _ratingDialoge(result);
                }
              } else {
                if (setOrderStatus(2, result.orderSteps) == "Completed".tr) {
                  /// show dialoge for rating
                  _ratingDialoge(result);
                }
              }
            });
          }

          return Container(
            color: Colors.blue,
            child: Material(
              color: Colors.white,
              child: Container(
                  child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        height: Get.height * 0.25,
                      ),
                      Expanded(
                        child: Container(color: Colors.grey.shade200),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                    minHeight: setOrderStatus(
                                                    0, result.orderSteps) !=
                                                "Completed".tr &&
                                            !result.isCompleted &&
                                            result.orderStatusId.toString() !=
                                                "5"
                                        ? Get.height * 0.37
                                        : Get.height * 0.36,
                                    minWidth: double.infinity),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    isFirstBoxExpanded?
                                     SizedBox(height:40):Container(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          orderId != null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: InkWell(
                                                      onTap: () {
                                                        if (orderId != null) {
                                                          Get.back();
                                                        }
                                                      },
                                                      child: Icon(
                                                        Icons.arrow_back,
                                                        size: 25,
                                                        color: Colors.white,
                                                      )),
                                                )
                                              : Container(),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text("Order #".tr,
                                                    style: TextStyle(
                                                        fontSize: 16.5,
                                                        color: Colors.white)),
                                                Text(
                                                  "${result.orderId}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          Get.height * 0.022,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18, right: 18, top: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 1,
                                                  spreadRadius: .1)
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: ExpandablePanel(
                                            controller: controller,
                                            theme: ExpandableThemeData(
                                                iconColor: Colors.black,
                                                iconSize: 30),
                                            header: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [


                                                Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          _getStepsColor(result)
                                                              .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 6),
                                                    child: Text(
                                                      _getStepsName(result),

                                                      style: TextStyle(
                                                          color: _getStepsColor(
                                                              result),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                )
                                              ],
                                            ),
                                            collapsed: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        _getStepsDescription(
                                                                result) ??
                                                            "",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        softWrap: true,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                workhsopProfileWidget(),
                                                SizedBox(
                                                  height: 15,
                                                )
                                              ],
                                            ),
                                            expanded: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                border: Border(
                                                          right: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              width: 0.5),
                                                          top: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              width: 1),
                                                          bottom: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              width: 1),
                                                        )),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text("Order #".tr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          Get.height *
                                                                              0.018,
                                                                      color: Colors
                                                                          .blueGrey)),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                "${result.orderId}",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Get.height *
                                                                            0.02,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                      Expanded(
                                                          child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                border: Border(
                                                          left: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              width: 0.5),
                                                          top: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              width: 1),
                                                          bottom: BorderSide(
                                                              color: Colors.grey
                                                                  .shade200,
                                                              width: 1),
                                                        )),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Center(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text("Date".tr,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            Get.height *
                                                                                0.018,
                                                                        color: Colors
                                                                            .blueGrey)),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "${DateFormat('yyyy-MM-dd').format(DateTime.parse(result.creationDate))}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          Get.height *
                                                                              0.018,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,right: 8),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "Car".tr,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.height *
                                                                      0.020,
                                                              color: Colors
                                                                  .blueGrey),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,right: 8),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${result.carName}",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                Get.height *
                                                                    0.018,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  /* Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: getTextList(
                                                        'Name'.tr,
                                                        '${result.workshopName.name}'),
                                                  ),
                                                ),*/
                                                  SizedBox(
                                                    height: 10,
                                                  ),

                                                  Container(height: 0.25, color:grey),

                                                !result.isTechnicianOrder
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Issue type'.tr,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    Get.height *
                                                                        0.020,
                                                                    color: Colors
                                                                        .blueGrey),
                                                              ),
                                                              Text(
                                                                getFualts(result)??"",
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontWeight:
                                                                  FontWeight.bold,
                                                                  fontSize:
                                                                  Get.height *
                                                                      0.018,
                                                                ),
                                                              ),
                                                             

                                                            ],
                                                        ),
                                                        // child: Column(
                                                        //   mainAxisAlignment:
                                                        //       MainAxisAlignment
                                                        //           .spaceBetween,
                                                        //   children: getTextList(
                                                        //       'Issue type'.tr,
                                                    
                                                        // ),
                                                      )
                                                    : Container(),
                                                  Container(height: 0.25, color:grey),

                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8.0),
                                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Comment'.tr,
                                                          style: TextStyle(
                                                              fontSize:
                                                              Get.height *
                                                                  0.020,
                                                              color: Colors
                                                                  .blueGrey),
                                                        ),
                                                        Text(
                                                          result.comments ?? "",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize:
                                                            Get.height *
                                                                0.018,
                                                          ),
                                                        ),


                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      result.orderAttachments
                                                                  .length >
                                                              0
                                                          ? "Attachments".tr
                                                          : "",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blueGrey),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          children: List.generate(
                                                              result
                                                                  .orderAttachments
                                                                  .length,
                                                              (index) {
                                                            print(result
                                                                    .orderAttachments[
                                                                index]);
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                  width: 85,
                                                                  height: 85,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade200,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      image: DecorationImage(
                                                                          image:
                                                                              NetworkImage('https://muapi.deeps.info/' + result.orderAttachments[index].attachmentLink.toString()),
                                                                          fit: BoxFit.fill))),
                                                            );
                                                          }),
                                                        ),
                                                      )),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child:
                                                        workhsopProfileWidget(),
                                                  )
                                                ],
                                              ),
                                            ),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.zero,
                                  child: Column(
                                    children: [
                                      ColumnCard(
                                        color: white,
                                        isElevated: false,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  // !result.isCarPickupOrdered &&
                                                  //         !result
                                                  //             .isTechnicianOrder &&
                                                  //         result.orderSteps[0]
                                                  //                 .orderStepStatus
                                                  //                 .toString() ==
                                                  //             "0"
                                                  //     ? 
                                                  InkWell(
                                                          onTap: () {
                                                            _getWorkShopLocation(
                                                                result);
                                                          },
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/google_map_icon.svg',
                                                            height: 45,
                                                          )),
                                                      // : Container(),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "موقع الورشه",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "${getLastLocation()}",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: black,
                                                        ),
                                                      ),
                                                      Text(
                                                        "المسافة  ${result.distance} كيلو",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ))
                                                ],
                                              )),
                                              Expanded(
                                                  child: Row(
                                                children: [
                                                  // !result.isCarPickupOrdered &&
                                                  //         !result
                                                  //             .isTechnicianOrder &&
                                                  //         result.orderSteps[0]
                                                  //                 .orderStepStatus
                                                  //                 .toString() ==
                                                  //             "0"
                                                  //     ?
                                                  SvgPicture.asset(
                                                          'assets/calender.svg',
                                                          height: 40,
                                                        ),
                                                      // : Container(),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "مدة العمل ",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "يتم احتساب المدة بعد البدء في الإصلاح",
                                                        style: TextStyle(
                                                            color: black,
                                                            fontSize: 10),
                                                      ),
                                                     
                                                      Text(
                                                        "مدة الإصلاح ${result.timeInDays} يوم عمل",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: blue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ))
                                                ],
                                              ))
                                            ],
                                          )
                                        ],
                                      ),

                                      ///

                                      ColumnCard(
                                        color: white,
                                        isElevated: false,
                                        children: [
                                          ExpandablePanel(

                                            controller: controller2,
                                            theme: ExpandableThemeData(
                                                iconColor: Colors.black,
                                                iconSize: 30),
                                            header: invoiceHeader(),
                                            // collapsed: invoiceHeader(),
                                            expanded: Column(
                                              children: [
                                                // invoiceHeader(),
                                                Divider(
                                                  color: grey,
                                                  thickness: 0.5,
                                                ),

                                                Visibility(
                                                  visible: false,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: getTextList(
                                                          'Musan fee'.tr,
                                                          '${double.parse(result.musanFee.toString()).toStringAsFixed(1)} ${"SR".tr}'),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: getTextList(
                                                      'Work cost'.tr,
                                                      '${double.parse(result.workCost.toString()).toStringAsFixed(2)} ${"SR".tr}',
                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: getTextList(
                                                        "VAT".tr,
                                                        '${result.vatCost.toString()} ${"SR".tr}'),
                                                  ),
                                                ),
                                                result.orderParts.length != 0
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: getTextList(
                                                            'Part cost'.tr,
                                                            '${getPartCost(result)} ${"SR".tr}',
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                                Container(
                                                  height: 1,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: getTextList(
                                                        'Total cost'.tr,
                                                        ' ${double.parse(result.totalCost.toString()).toStringAsFixed(2)} ${"SR".tr}',
                                                        detailWeight:
                                                            FontWeight.bold,
                                                        detailsColor:
                                                            Colors.blue,
                                                        headingColor: grey),
                                                  ),
                                                ),

                                               /* !result.isTechnicianOrder
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: getTextList(
                                                              'Duration'.tr,
                                                              '${double.parse(result.timeInDays.toString()).toInt()} ${"Days".tr}',
                                                              detailWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              detailsColor:
                                                                  Colors.blue,
                                                              headingColor:
                                                                  grey),
                                                        ),
                                                      )
                                                    : Container(),
*/
                                                result.isDownPaymentRequested &&
                                                            !result
                                                                .isDownPaymentCompleted ||
                                                        result.editsPending ||
                                                        checkAnyPartIsInPendingApproval(
                                                            result) ||
                                                        !result.isFinalPaymentCleared &&
                                                            checkFinalBillIsNeededToShowOrNot(
                                                                    result) ==
                                                                "Completed".tr
                                                    ? InkWell(
                                                        onTap: () {
                                                          checkAndSeePendingPayments(
                                                              result);
                                                        },
                                                        child: Container(
                                                          width: Get.width,
                                                          height:
                                                              Get.height * .065,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                color:
                                                                    themeColor,
                                                                width: 1),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              'See Pending Approvals'
                                                                  .tr,
                                                              style: TextStyle(
                                                                color:
                                                                    themeColor,
                                                                fontSize:
                                                                    Get.height *
                                                                        .02,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      result.orderParts.isNotEmpty
                                          ? ColumnCard(
                                              color: white,
                                              isElevated: false,
                                              children: [
                                                ExpandablePanel(
                                                    controller: controller3,
                                                    theme: ExpandableThemeData(
                                                        iconColor: Colors.black,
                                                        iconSize: 30),
                                                    header: partsHeader(),
                                                    expanded: ColumnCard(
                                                      color: white,
                                                      isElevated: false,
                                                      children: [
                                                        Container(
                                                          child: Column(
                                                            children:
                                                                List.generate(
                                                                    result
                                                                        .orderParts
                                                                        .length,
                                                                    (index) =>
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: getOrderPart1(result, index)),
                                                                            ),
                                                                            !result.orderParts[index].isApproved && result.orderParts[index].pendingApproval
                                                                                ? Row(children: getOrderPart(result, index))
                                                                                : Container()
                                                                          ],
                                                                        )),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            )),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 15, bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      var dashboardProvider =
                                          Provider.of<DashboardProvider>(
                                              Get.context,
                                              listen: false);
                                      Get.to(ChatRoom(
                                          chatRoomId:
                                              "${dashboardProvider.userID}_${result.workshopId}_${result.orderId}",
                                          messageSendBy:
                                              result.userId.toString()));
                                    },
                                    child: Container(
                                      decoration: !result.isTechnicianOrder
                                          ? BoxDecoration(
                                              color: orangeYellow,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(Get
                                                        .locale
                                                        .toString()
                                                        .contains('en')
                                                    ? 10
                                                    : 0),
                                                topLeft: Radius.circular(Get
                                                        .locale
                                                        .toString()
                                                        .contains('en')
                                                    ? 10
                                                    : 0),
                                                bottomRight: Radius.circular(Get
                                                        .locale
                                                        .toString()
                                                        .contains('ar')
                                                    ? 10
                                                    : 0),
                                                topRight: Radius.circular(Get
                                                        .locale
                                                        .toString()
                                                        .contains('ar')
                                                    ? 10
                                                    : 0),
                                              ))
                                          : BoxDecoration(
                                              color: orangeYellow,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Center(
                                            child: Text("Chat Room".tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15))),
                                      ),
                                    ),
                                  )),
                                  !result.isTechnicianOrder
                                      ? Expanded(
                                          child: InkWell(
                                          onTap: () {
                                            launch(
                                                "tel://${result.workshopPhoneNumber}");
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(Get
                                                        .locale
                                                        .toString()
                                                        .contains('ar')
                                                    ? 10
                                                    : 0),
                                                topLeft: Radius.circular(Get
                                                        .locale
                                                        .toString()
                                                        .contains('ar')
                                                    ? 10
                                                    : 0),
                                                bottomRight: Radius.circular(Get
                                                        .locale
                                                        .toString()
                                                        .contains('en')
                                                    ? 10
                                                    : 0),
                                                topRight: Radius.circular(Get
                                                        .locale
                                                        .toString()
                                                        .contains('en')
                                                    ? 10
                                                    : 0),
                                              ),
                                              color: blue,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Center(
                                                  child: Text(
                                                "Call Workshop".tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              )),
                                            ),
                                          ),
                                        ))
                                      : Container(),
                                ],
                              ),
                            ),
                            /*setOrderStatus(0, result.orderSteps) ==
                                        "in process".tr &&
                                    tempCarPickupOrdered &&
                                    !result.isTechnicianOrder
                                ? Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        border: Border.all(
                                            color: grey.withOpacity(0.5),
                                            width: 3)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "Need a car pickup?".tr,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Text(
                                            "You can now order our pickup service to help you bring your car to the workshop"
                                                .tr,
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showProgress();
                                                  ApiServices
                                                      .getCarPickTypeCosts(
                                                          result);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: green
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 40,
                                                        vertical: 8),
                                                    child: Center(
                                                        child: Text(
                                                      "Yes".tr,
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  tempCarPickupOrdered = false;
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          red.withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 40,
                                                        vertical: 8),
                                                    child: Center(
                                                        child: Text(
                                                      "No".tr,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),*/
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )),
            ),
          );
        } else {
          return Material(
              color: Colors.white,
              child: Container(
                  child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )));
        }
      });

  Widget invoiceHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SvgPicture.asset('assets/recieptIcon.svg'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invoices Details'.tr,
                  style: TextStyle(color: black, fontWeight: FontWeight.bold),
                ),
                Text(
                  '#${result.orderId}'.tr,
                  style: TextStyle(color: grey, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '',
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' الاجمالي ${double.parse(result.totalCost.toString()).toStringAsFixed(2)} ر.س'
                          .tr,
                      style: TextStyle(
                          fontSize: 16,
                          color: blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget partsHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SvgPicture.asset('assets/carWithGear.svg'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'قطع الغيار'.tr,
                  style: TextStyle(color: black, fontWeight: FontWeight.bold),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: green.withOpacity(0.25)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      "معتمد",
                      style: TextStyle(color: green),
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '',
                      style:
                          TextStyle(color: black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'تكلفة القطع ${getPartCost(result)} ر.س',
                      style: TextStyle(
                          fontSize: 15,
                          color: blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  bottomSheetForDawnPayment(Result result) async {
    if (Get.isBottomSheetOpen) {
      return;
    }
    bool isCashBack = await ApiServices.getCashBack();

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
                  "Pay down payment".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Get.height * .022,
                    color: headingTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * .02),
                Text(
                  "you are requested to pay down payment before staring work!"
                      .tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Get.height * .02,
                    fontWeight: FontWeight.w600,
                    color: headingTextColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    var dashboardProvider = Provider.of<DashboardProvider>(
                        Get.context,
                        listen: false);

                    Get.back();

                    // Get.dialog(Center(
                    //   child: CircularProgressIndicator(),
                    // ));

                    dashboardProvider.setPartIdAndORderId(
                        partID: null,
                        orderId: result.orderId,
                        workshopId: result.workshopId.toString());
                    dashboardProvider.startPayingPayment(
                        "DownPayment".tr, result.downPayment.toString());

                    // ApiServices.getDefaultPaymentMethods(data.userID,
                    //     result.downPayment.toString(), result.orderId,
                    //     result.workshopId.toString(),
                    //     paymentType: "DownPayment".tr);
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
                        '${"Pay SAR".tr} ${double.parse(result.downPayment.toString()).toInt()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                isCashBack &&
                        double.parse(result.downPayment.toString()) <
                            double.parse(dashboard
                                .promotionCashBackFromJson.result.amount
                                .toString())
                    ? GestureDetector(
                        onTap: () async {
                          var dashboardProvider =
                              Provider.of<DashboardProvider>(Get.context,
                                  listen: false);
                          Get.back();

                          dashboardProvider.setPartIdAndORderId(
                              partID: null,
                              orderId: result.orderId,
                              workshopId: result.workshopId.toString());
                          // dashboardProvider.startPayingPayment("DownPayment".tr, result.downPayment.toString());
                          var bool = await ApiServices.acceptAndPayDownPayment(
                              result.orderId.toString(),
                              isCashback: true);
                          if (bool == true) {
                            dashboardProvider.hitWorkshopForOrderProgressed(
                                result.workshopId.toString() ?? "0",
                                result.orderId.toString() ?? "0");
                          }
                        },
                        child: Container(
                          width: Get.width,
                          height: Get.height * .065,
                          margin:
                              EdgeInsets.symmetric(vertical: Get.height * .02),
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
                              '${"Pay from wallet".tr} ${"SAR".tr} ${double.parse(result.downPayment.toString()).toInt()}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    ApiServices.rejectDownPayment(
                        result.orderId.toString(), result.workshopId);
                  },
                  child: Text(
                    'Reject'.tr,
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

  bottomSheetForEditTimeAndCost(Result result) {
    if (Get.isBottomSheetOpen) {
      return;
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
                  "${"Order number".tr} ${result.orderId}\n${"Time and cost changes".tr}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Get.height * .022,
                    color: headingTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * .02),
                Row(
                  children: [
                    Expanded(
                        child: Center(
                            child: Column(
                      children: [
                        Text("Timing".tr, style: TextStyle(fontSize: 16)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${result.pendingEditedDays} ${"Days".tr}",
                          style: TextStyle(
                              color: blue,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ))),
                    Expanded(
                        child: Center(
                            child: Column(
                      children: [
                        Text("Work Price".tr, style: TextStyle(fontSize: 16)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${"SR".tr} ${double.parse(result.pendingEditedCost.toString()).toInt()}",
                          style: TextStyle(
                              color: blue,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ))),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    var dashboardProvider = Provider.of<DashboardProvider>(
                        Get.context,
                        listen: false);
                    dashboardProvider.setPartIdAndORderId(
                        partID: null, orderId: result.orderId);
                    Get.back();
                    Get.dialog(Center(
                      child: CircularProgressIndicator(),
                    ));
                    // ApiServices.getDefaultPaymentMethods(data.userID,result.pendingEditedCost.toString().toString(),
                    //     result.orderId,paymentType:"EditTimeAndCost");

                    ApiServices.acceptEditInTimeAndCost(
                        dashboardProvider.orderId.toString(),
                        result.workshopId.toString());
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
                        'Accept'.tr,
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
                    Get.dialog(Center(
                      child: CircularProgressIndicator(),
                    ));
                    ApiServices.rejectEditInTimeAndCost(
                        result.orderId.toString(),
                        result.workshopId.toString());
                  },
                  child: Text(
                    'Reject'.tr,
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

  void checkAndSeePendingPayments(Result result) async {
    Future.delayed(Duration.zero, () {
      if (result != null) {
        try {
          if (result.isDownPaymentRequested && !result.isDownPaymentCompleted) {
            /// show dialoge for accept down payment here
            print("pay dawn payment");
            bottomSheetForDawnPayment(result);
          } else if (result.editsPending) {
            /// show sheet here to accept edit time and cost
            print('show sheet here to accept edit time and cost');
            bottomSheetForEditTimeAndCost(result);
          } else if (checkAnyPartIsInPendingApproval(result)) {
            /// show sheet to accept parts approval
            print("show sheet to accept parts approval");
            List<OrderPart> orderParts = [];
            for (int i = 0; i < result.orderParts.length; i++) {
              if (result.orderParts[i].pendingApproval &&
                  !result.orderParts[i].isApproved) {
                orderParts.add(result.orderParts[i]);
              }
            }
            if (orderParts.length > 0) {
              bottomSheetToAcceptOrderParts(result, orderParts);
            }
          } else if (!result.isFinalPaymentCleared &&
              checkFinalBillIsNeededToShowOrNot(result) == "Completed".tr &&
              !result.isCash) {
            // TOASTS("data");
            bottomSheetToFinalBill(result);
          } else if (result.isCarPickupOrdered &&
              !result.isCarPickupPaid &&
              setOrderStatus(0, result.orderSteps) == "Completed".tr) {
            bottomSheetForCarPickPayment(result);
          }
        } catch (e) {
          print(e);
        }
      }
    });
  }

  void bottomSheetForCarPickPayment(Result result) {
    // TOASTS("data".tr);

    if (Get.isBottomSheetOpen) {
      return;
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
                  "Pay Car Pick up Bill".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Get.height * .022,
                    color: headingTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * .005),
                Text(
                  "${"SR".tr} ${result.carPickupOrderAmount}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Get.height * .022,
                    color: headingTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * .02),
                GestureDetector(
                  onTap: () {
                    var dashboardProvider = Provider.of<DashboardProvider>(
                        Get.context,
                        listen: false);
                    dashboardProvider.setPartIdAndORderId(
                      partID: null,
                      orderId: result.orderId,
                    );
                    Get.back();
                    Get.dialog(Center(
                      child: CircularProgressIndicator(),
                    ));

                    // TOASTS( "result.orderId ${result.orderId}");

                    dashboardProvider.setCarPickOrderID(
                      result.carPickupOrderId.toString(),
                      result.carPickUpId.toString(),
                      result.workshopId.toString(),
                    );

                    dashboardProvider.startPayingPayment(
                        "CarPickUp".tr, result.totalCost.toString());

                    // ApiServices.getDefaultPaymentMethods(data.userID,
                    //     result.carPickupOrderAmount.toString(), result.orderId,
                    //     result.workshopId.toString(),
                    //     paymentType: "CarPickUp".tr);
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
                        'Pay'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    // Get.dialog(Center(
                    //   child: CircularProgressIndicator(),
                    // ));
                    // // ApiServices.payFinalBill(result.orderId.toString(),isCash:true);
                    // var provider =
                    // Provider.of<DashboardProvider>(context, listen: false);
                    // ApiServices.initPayment(
                    //     provider.userID,
                    //     0,
                    //     "visa",
                    //     (double.parse(result.totalCost.toString()) * 100)
                    //         .toString(),
                    //     "${result.orderId.toString()}",
                    //     isCash: true,
                    //     refID: result.orderId.toString());
                  },
                  child: Container(
                    width: Get.width,
                    height: Get.height * .065,
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: blue),
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
                        'Cancel'.tr,
                        style: TextStyle(
                            color: themeColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    }), isDismissible: true);
  }

  bottomSheetToAcceptOrderParts(
      Result result, List<OrderPart> orderParts) async {
    if (Get.isBottomSheetOpen) {
      return;
    }
    bool isCashBack = await ApiServices.getCashBack();
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
                  "Order Part".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Get.height * .022,
                    color: headingTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * .02),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: List.generate(orderParts[0].pictures.length,
                            (index) {
                          print(orderParts[0].pictures.length);
                          return InkWell(
                            onTap: () {
                              openImage(
                                  "https://muapi.deeps.info/${orderParts[0].pictures[index].imageUrl}");
                            },
                            child: Image.network(
                              orderParts[0].pictures.length == 0
                                  ? "https://tamam.com.pk/logoplaceholder.png"
                                  : "https://muapi.deeps.info/${orderParts[0].pictures[index].imageUrl}",
                              height: 80,
                              width: 60,
                              fit: BoxFit.fill,
                            ),
                          );
                        }),
                      ),
                    )),
                    Expanded(
                        child: Center(
                            child: Column(
                      children: [
                        Text(orderParts[0].partName ?? "",
                            style: TextStyle(fontSize: 16)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${"SR".tr} ${orderParts[0].partCost}",
                          style: TextStyle(
                              color: blue,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ))),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    var dashboardProvider = Provider.of<DashboardProvider>(
                        Get.context,
                        listen: false);
                    dashboardProvider.setPartIdAndORderId(
                        partID: orderParts[0].orderPartId,
                        orderId: result.orderId,
                        workshopId: result.workshopId.toString());
                    await Get.back();
                    await dashboardProvider.startPayingPayment(
                        "OrderPart".tr, orderParts[0].partCost.toString());

                    // Get.dialog(Center(child: CircularProgressIndicator(),));

                    // ApiServices.getDefaultPaymentMethods(
                    //     data.userID,
                    //     orderParts[0].partCost.toString(), result.orderId,result.workshopId.toString(),
                    //     paymentType: "OrderPart".tr
                    // );
                    // ApiServices.acceptEditInTimeAndCost(
                    //     result.orderId.toString());
                  },
                  child: Container(
                    width: Get.width,
                    height: Get.height * .06,
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
                        'Accept & Pay'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),

                ///
                isCashBack &&
                        double.parse(result.downPayment.toString()) <
                            double.parse(dashboard
                                .promotionCashBackFromJson.result.amount
                                .toString())
                    ? GestureDetector(
                        onTap: () async {
                          var dashboardProvider =
                              Provider.of<DashboardProvider>(Get.context,
                                  listen: false);
                          dashboardProvider.setPartIdAndORderId(
                              partID: orderParts[0].orderPartId,
                              orderId: result.orderId,
                              workshopId: result.workshopId.toString());
                          await Get.back();

                          var bool = await ApiServices.acceptPart(
                              isPaid: true,
                              partID: orderParts[0].orderPartId,
                              orderId: result.orderId.toString(),
                              workshopId: result.workshopId.toString());

                          if (bool == true) {
                            dashboardProvider.hitWorkshopForOrderProgressed(
                                result.workshopId.toString() ?? "0",
                                result.orderId.toString() ?? "0");
                            logger.i("DSDDDSDSDSDSD");
                          }

                          // await dashboardProvider.startPayingPayment("OrderPart".tr, orderParts[0].partCost.toString());

                          // Get.dialog(Center(child: CircularProgressIndicator(),));

                          // ApiServices.getDefaultPaymentMethods(
                          //     data.userID,
                          //     orderParts[0].partCost.toString(), result.orderId,result.workshopId.toString(),
                          //     paymentType: "OrderPart".tr
                          // );
                          // ApiServices.acceptEditInTimeAndCost(
                          //     result.orderId.toString());
                        },
                        child: Container(
                          width: Get.width,
                          height: Get.height * .06,
                          margin:
                              EdgeInsets.symmetric(vertical: Get.height * .02),
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
                              'Accept & Pay by Wallet'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),

                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.dialog(Center(
                      child: CircularProgressIndicator(),
                    ));

                    ApiServices.acceptPart(
                        isPaid: false,
                        partID: orderParts[0].orderPartId,
                        orderId: result.orderId,
                        workshopId: result.workshopId.toString());
                  },
                  child: Container(
                    width: Get.width,
                    height: Get.height * .06,
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: blue),
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
                        'Accept & pay later'.tr,
                        style: TextStyle(
                          color: blue,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.dialog(Center(
                      child: CircularProgressIndicator(),
                    ));
                    ApiServices.rejectOrderParts(orderParts[0].orderPartId,
                        result.orderId, result.workshopId.toString());
                  },
                  child: Text(
                    'Reject'.tr,
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

  bottomSheetToFinalBill(Result result) async {
    if (Get.isBottomSheetOpen) {
      return;
    }

    bool isCashBack = await ApiServices.getCashBack();

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
                  "Pay Final Bill".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Get.height * .022,
                    color: headingTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * .005),
                Text(
                  "${"SR".tr} ${double.parse(result.totalCost.toString()).toStringAsFixed(2)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Get.height * .022,
                    color: headingTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * .02),
                GestureDetector(
                  onTap: () async {
                    var dashboardProvider = Provider.of<DashboardProvider>(
                        Get.context,
                        listen: false);
                    dashboardProvider.setPartIdAndORderId(
                        partID: null,
                        orderId: result.orderId,
                        workshopId: result.workshopId.toString());

                    // Final Bill
                    logger.w(result.totalCost.toString());
                    if (Get.isBottomSheetOpen) {
                      Get.back();
                    }
                    await dashboardProvider.startPayingPayment(
                        "Final Bill".tr, result.totalCost.toString());

                    // ApiServices.getDefaultPaymentMethods(data.userID,
                    //     result.totalCost.toString(), result.orderId,
                    //     result.workshopId.toString(),
                    //     paymentType: "Final Bill".tr);
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
                        'Pay'.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                isCashBack &&
                        double.parse(result.downPayment.toString()) <
                            double.parse(dashboard
                                .promotionCashBackFromJson.result.amount
                                .toString())
                    ? GestureDetector(
                        onTap: () async {
                          var dashboardProvider =
                              Provider.of<DashboardProvider>(Get.context,
                                  listen: false);
                          dashboardProvider.setPartIdAndORderId(
                              partID: null,
                              orderId: result.orderId,
                              workshopId: result.workshopId.toString());

                          // Final Bill
                          logger.w(result.totalCost.toString());
                          if (Get.isBottomSheetOpen) {
                            Get.back();
                          }
                          // await  dashboardProvider.startPayingPayment("Final Bill".tr, result.totalCost.toString());

                          await ApiServices.payFinalBill(orderId.toString(),
                              isCash: false, isWallet: true);
                          dashboardProvider.hitWorkshopForOrderProgressed(
                              result.workshopId.toString() ?? "0",
                              result.orderId.toString() ?? "0");

                          // ApiServices.getDefaultPaymentMethods(data.userID,
                          //     result.totalCost.toString(), result.orderId,
                          //     result.workshopId.toString(),
                          //     paymentType: "Final Bill".tr);
                        },
                        child: Container(
                          width: Get.width,
                          height: Get.height * .065,
                          margin:
                              EdgeInsets.symmetric(vertical: Get.height * .02),
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
                              'Final Bill via wallet'.tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    showProgress();

                    ApiServices.payFinalBill(result.orderId.toString(),
                        isCash: true);
                    // var provider = Provider.of<DashboardProvider>(context, listen: false);
                    // provider.setPartIdAndORderId(partID:0,orderId:result.orderId,workshopId: result.workshopId.toString());
                    // ApiServices.makeFinalPaymentCOD( provider.userID,result.totalCost.toString(),true,result.orderId.toString());
                    // ApiServices.initPayment(
                    //     provider.userID,
                    //     0,
                    //     "visa".tr,
                    //     (double.parse(result.totalCost.toString()) * 100)
                    //         .toString(),
                    //     "${result.orderId.toString()}",
                    //     isCash: true,
                    //     orderID: result.orderId.toString());
                  },
                  child: Container(
                    width: Get.width,
                    height: Get.height * .065,
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: blue),
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
                        'Cash on Delivery'.tr,
                        style: TextStyle(
                            color: themeColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    }), isDismissible: true);
  }

  bool checkAnyPartIsInPendingApproval(Result result) {
    for (int i = 0; i < result.orderParts.length; i++) {
      if (result.orderParts[i].pendingApproval) {
        print("sghghjghjg");

        return true;
      }
    }

    return false;
  }

  String checkFinalBillIsNeededToShowOrNot(Result result) {
    try {
      if (result.isCarPickupOrdered) {
        /// five steps
        if (result.orderSteps[3].orderStepStatus == 0) {
          return "in process".tr;
        } else
          return "Completed".tr;
      } else {
        /// three steps
        if (result.orderSteps[1].orderStepStatus == 0) {
          return "in process".tr;
        } else
          return "Completed".tr;
      }
    } catch (e) {
      return 'in process'.tr;
    }
  }

  getPartCost(Result result) {
    double priceOfParts = 0;
    for (int i = 0; i < result.orderParts.length; i++) {
      if (result.orderParts[i].isApproved && !result.orderParts[i].isPaid) {
        priceOfParts = priceOfParts +
            double.parse(result.orderParts[i].partCost.toString());
      }
    }
    return priceOfParts;
  }

  getTextList(String title, String detail,
      {Color headingColor: black,
      Color detailsColor: black,
      FontWeight detailWeight: FontWeight.w500}) {
    List<Widget> list = [
      Text(title,
          style: TextStyle(
            color: headingColor,
          )),
      Text(
        detail,
        style: TextStyle(
            color: detailsColor, fontSize: 16, fontWeight: detailWeight),
      )
    ];
    // return Get.locale.toString().contains("en") ? list : list.reversed.toList();

    return list;
  }

  String getAllissue(List<Fault> faults) {
    List<String> data = [];
    for (int i = 0; i < faults.length; i++) {
      data.add(faults[i].name);
    }
    return data.toString().replaceAll("[", "").replaceAll("]", "");
  }

  String setOrderStatus(int i, List<OrderStep> orderSteps) {
    try {
      if (i == 0) {
        if (orderSteps[0].orderStepStatus == 0) {
          return "in process".tr;
          print("Gello");
        } else
          return "Completed".tr;
      }
      if (i == 1) {
        if (orderSteps[0].orderStepStatus == 0) {
          return " ";
        }
        if (orderSteps[1].orderStepStatus == 0) {
          return "in process".tr;
        } else
          return "Completed".tr;
      }
      if (i == 2) {
        if (orderSteps[0].orderStepStatus == 0) {
          return " ";
        }
        if (orderSteps[1].orderStepStatus == 0) {
          return " ";
        }
        if (orderSteps[2].orderStepStatus == 0) {
          return "in process".tr;
        } else
          return "Completed".tr;
      }
      if (i == 3) {
        if (orderSteps[0].orderStepStatus == 0) {
          return " ";
        }
        if (orderSteps[1].orderStepStatus == 0) {
          return " ";
        }
        if (orderSteps[2].orderStepStatus == 0) {
          return "";
        }
        if (orderSteps[3].orderStepStatus == 0) {
          return "in process".tr;
        } else
          return "Completed".tr;
      }
      if (i == 4) {
        if (orderSteps[0].orderStepStatus == 0) {
          return " ";
        }
        if (orderSteps[1].orderStepStatus == 0) {
          return " ";
        }
        if (orderSteps[2].orderStepStatus == 0) {
          return "";
        }
        if (orderSteps[3].orderStepStatus == 0) {
          return "";
        }
        if (orderSteps[4].orderStepStatus == 0) {
          return "in process".tr;
        } else
          return "Completed".tr;
      }
    } catch (e) {
      return " ";
    }
  }

  Widget workhsopProfileWidget() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            height: Get.height * 0.07,
            width: Get.width * 0.15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'))),
          ),
        ),
        Expanded(
            child: !result.isTechnicianOrder
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.workshopName.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.height * 0.015,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/save_tick_icon.svg',
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Verified Shop".tr,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Get.height * 0.016,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 35,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/google.svg',
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "4.8/5".tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.height * 0.016),
                                ),
                                Icon(
                                  Icons.star,
                                  color: orangeYellow,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/warranty.svg',
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Offer Warranty".tr,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.height * 0.016),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 35,
                          ),
                          Expanded(
                            child: result.isElite
                                ? Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/yello_starr_filled.png',
                                        height: 15,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: Text(
                                          "Elite".tr,
                                          style: TextStyle(
                                              color: orangeYellow,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container())
      ],
    );
  }

  getOrderPart1(Result result, int index, {Color detailColor: black}) {
    List<Widget> list = [
      Row(
        children: [
          Text(
            result.orderParts[index].partName,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            width: 5,
          ),
          !result.orderParts[index].pendingApproval &&
                  !result.orderParts[index].isApproved
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                    child: Text(
                      'Rejected'.tr,
                      style: TextStyle(color: red),
                    ),
                  ))
              : result.orderParts[index].isApproved
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 5),
                        child: Text(
                          'Accepted'.tr,
                          style: TextStyle(color: green),
                        ),
                      ))
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 5),
                        child: Text(
                          'New'.tr,
                          style: TextStyle(color: yellow),
                        ),
                      ))
        ],
      ),
      Text(
        '${"SR".tr} ${result.orderParts[index].partCost.toString()}',
        style: TextStyle(
            color: detailColor, fontSize: 13, fontWeight: FontWeight.bold),
      )
    ];

    return Get.locale.toString().contains("ar") ? list.reversed.toList() : list;
  }

  String getFualts(Result result) {
    List<String> faults = [];
    result.faults.forEach((element) {
      faults.add(element.name);
    });
    return faults.toString().replaceAll("[", '').replaceAll("]", '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    analytics.logEvent(name: "user_left_offer_screen");
  }

  orderCancelBottomSheet(Result result) {
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
                "Cancel order".tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.height * .022,
                  color: headingTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Get.height * .02),
              Text(
                "Are you sure you want to\ncancel this order?".tr,
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
                  Get.back();
                  Get.dialog(Center(
                    child: CircularProgressIndicator(),
                  ));
                  ApiServices.cancelOrder(
                      result.orderId.toString(), result.workshopId.toString());
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
                      'Yes'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.height * .02,
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
                  'No'.tr,
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
  }

  getOrderPart(Result result, int index) {
    List<Widget> list = [
      InkWell(
        onTap: () {
          bottomSheetToAcceptOrderParts(result, result.orderParts);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
              decoration: BoxDecoration(
                  color: blue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: green,
                    ),
                    Text(
                      'Accept & Pay'.tr,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              )),
        ),
      ),
      InkWell(
        onTap: () {
          showProgress();

          ApiServices.rejectOrderParts(result.orderParts[index].orderPartId,
              result.orderId, result.workshopId);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
              decoration: BoxDecoration(
                  color: blue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.close,
                      color: red,
                    ),
                    Text(
                      'Reject'.tr,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              )),
        ),
      ),
    ];

    return Get.locale.toString().contains("ar") ? list.reversed.toList() : list;
  }

  Color _getStepsColor(Result result, {String stepNo}) {
    if (!result.isCarPickupOrdered && !result.isTechnicianOrder) {
      if (result.orderSteps[0].orderStepStatus.toString() == "0") {
        return Colors.grey;
      } else if (result.orderSteps[1].orderStepStatus.toString() == "0") {
        return Colors.red;
      } else if (result.orderSteps[2].orderStepStatus.toString() == "0") {
        return Colors.green;
      }
    }

    return Colors.blue;

/*



    else if (result.isCarPickupOrdered && !result.isTechnicianOrder){
      if(stepNo=="step1".tr){
        return "On the way".tr;
      }
      else if (stepNo=="step2".tr){
        return "Picking up".tr;
      }
      else if(stepNo=="step3".tr){
        return "Arrive & Deal".tr;
      }
      else if(stepNo=="step4".tr){
        return "Fixing".tr;
      }
      else if(stepNo=="step5".tr){
        return "Deliver".tr;
      }

    }

    else if (result.isTechnicianOrder){

      if(stepNo=="step1".tr){
        return "Arrive & Deal".tr;
      }
      else if (stepNo=="step2".tr){
        return "Checking".tr;
      }
      else if(stepNo=="step3".tr){
        return "Report Deliver".tr;
      }

    }*/
  }

  String _getStepsDescription(Result result) {
    if (!result.isCarPickupOrdered && !result.isTechnicianOrder) {
      if (result.orderSteps[0].orderStepStatus.toString() == "0") {
        return "Please go to the workshop and let him check your can to confirm the deal"
            .tr;
      } else if (result.orderSteps[0].orderStepStatus.toString() == "1" &&
          result.orderSteps[1].orderStepStatus.toString() == "0") {
        return "Deal, now you can relax and wait till the workshop complete fixing."
            .tr;
      } else if (result.orderSteps[1].orderStepStatus.toString() == "1" &&
          result.orderSteps[2].orderStepStatus.toString() == "0") {
        return "Congratulations 🎉, your car is fixed, please get your car and check it before you leave."
            .tr;
      } else if (result.orderSteps[2].orderStepStatus.toString() == "1") {
        return "The order has been completed, thank you please keep in touch"
            .tr;
      }
    } else if (result.isCarPickupOrdered && !result.isTechnicianOrder) {
      /*     if(stepNo=="step1".tr){
        return "On the way".tr;
      }
      else if (stepNo=="step2".tr){
        return "Picking up".tr;
      }
      else if(stepNo=="step3".tr){
        return "Arrive & Deal".tr;
      }
      else if(stepNo=="step4".tr){
        return "Fixing".tr;
      }
      else if(stepNo=="step5".tr){
        return "Deliver".tr;
      }*/

    } else if (result.isTechnicianOrder) {
      if (result.orderSteps[0].orderStepStatus.toString() == "0") {
        // return "Arrive & Deal".tr;
        return "Please wait, A technician is coming to you.".tr;
      } else if (result.orderSteps[1].orderStepStatus.toString() == "0") {
        // return "Checking".tr;
        return "A technician is arrived and checking your car.".tr;
      } else if (result.orderSteps[2].orderStepStatus.toString() == "0") {
        // return "Report Deliver".tr;
        return "Congratulations 🎉, your report has been written".tr;
      }
    }

    return " ";
  }

  String _getStepsName(Result result) {
    try {
      if (!result.isCarPickupOrdered && !result.isTechnicianOrder) {
        if (result.orderSteps[0].orderStepStatus.toString() == "0") {
          return "Arrive & Deal".tr;
        } else if (result.orderSteps[0].orderStepStatus.toString() == "1" &&
            result.orderSteps[1].orderStepStatus.toString() == "0") {
          return "Fixing".tr;
        } else if (result.orderSteps[1].orderStepStatus.toString() == "1" &&
            result.orderSteps[2].orderStepStatus.toString() == "0") {
          return "Deliver".tr;
        } else if (result.orderSteps[2].orderStepStatus.toString() == "1") {
          return "Completed".tr;
        }
      } else if (result.isCarPickupOrdered && !result.isTechnicianOrder) {
        if (result.orderSteps[0].orderStepStatus.toString() == "0") {
          return "On the way".tr;
        } else if (result.orderSteps[1].orderStepStatus.toString() == "0") {
          return "Picking up".tr;
        } else if (result.orderSteps[2].orderStepStatus.toString() == "0") {
          return "Arrive & Deal".tr;
        } else if (result.orderSteps[3].orderStepStatus.toString() == "0") {
          return "Fixing".tr;
        } else if (result.orderSteps[4].orderStepStatus.toString() == "0") {
          return "Deliver".tr;
        }
      } else if (result.isTechnicianOrder) {
        if (result.orderSteps[0].orderStepStatus.toString() == "0") {
          return "Arrive & Deal".tr;
        } else if (result.orderSteps[1].orderStepStatus.toString() == "0") {
          return "Checking".tr;
        } else if (result.orderSteps[2].orderStepStatus.toString() == "0") {
          return "Report Deliver".tr;
        }
      }
    } catch (e) {
      print(e);
    }

    return "".tr;
  }

  String getLastLocation() {

    try {
      var split = result.workshopAddress.toString().split("،");
      return split[1]+"،"+split[2];
    } catch (e) {
      return '';
    }
  }
}
