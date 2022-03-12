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
import 'package:musan_client/utils/order_utils.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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

    orderChecked = 0;
    Future.delayed(Duration.zero, () {
      var orderScreenProvider = Provider.of<OrderScreenProvider>(Get.context, listen: false);
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
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  void _onRefresh() async{

    if(result!=null){
      this.orderId=result.orderId;
      _getSingleOrder();
    }
    print("sssss");
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{

    _refreshController.loadComplete();
  }
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
              child: SmartRefresher(
                  enablePullDown: true,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: Scaffold(
                  body: Container(
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
                                              // orderId != null
                                              //     ? Padding(
                                              //         padding:
                                              //             const EdgeInsets.only(
                                              //                 left: 10),
                                              //         child: InkWell(
                                              //             onTap: () {
                                              //               if (orderId != null) {
                                              //                 Get.back();
                                              //               }
                                              //             },
                                              //             child: Icon(
                                              //               Icons.arrow_back,
                                              //               size: 25,
                                              //               color: Colors.white,
                                              //             )),
                                              //       )
                                              //     : Container(),
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

                    _getStepsName(result).contains('Arrive & Deal')?
                      InkWell(
                          onTap:(){
                            orderCancelBottomSheet(result);
                          },
                          child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Align(
                              alignment: Alignment.topRight,
                          child: Icon(Icons.more_vert,color:white)),
                        ),
                      ):Container()
                    ],
                  )),
                ),
              ),
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
                                  "${result.googleRatings??0}/5".tr,
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    analytics.logEvent(name: "user_left_offer_screen");
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