import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:musan_client/ChatRoom.dart';
import 'package:musan_client/FCM.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/src/ui/dashboard/orders/workshop_offer.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderOfferScreen extends StatefulWidget {
  final String orderId;

  const OrderOfferScreen(this.orderId, {Key key}) : super(key: key);

  @override
  _OrderOfferScreenState createState() => _OrderOfferScreenState(orderId);
}

class _OrderOfferScreenState extends State<OrderOfferScreen> {
  String orderId;

  _OrderOfferScreenState(this.orderId);

  ExpandableController expandableController =
      ExpandableController(initialExpanded: false);
  var orderProvider =Provider.of<OrderScreenProvider>(Get.context, listen: false);

  @override
  void initState() {
    super.initState();
    analytics.logScreenView(
        screenName: "OrderOfferScreen", screenClass: "OrderOfferScreen");
    analytics.logEvent(name: "user_entered_offer_screen");
    orderProvider.getOfferrdersList();
    orderProvider.orderIdForOfferScreen=orderId;
  }


  Result result;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) =>
      Consumer<OrderScreenProvider>(builder: (builder, datas, child) {
        result=datas.offerResult;

        return Container(
          color: Colors.blue,
          child: Material(
            color: Colors.white,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                elevation: 0,
              ),
              body: Container(
                child: Stack(
                  children: [
                    SmartRefresher(
                      enablePullDown: true,
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.blue,
                            height: Get.height * 0.18,
                          ),
                          Expanded(
                            child: Container(color: Colors.grey.shade200),
                          ),
                        ],
                      ),
                    ),
                    result != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Container(height: 50,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(),
                                        Column(
                                          children: [
                                            Text("Order #".tr,
                                                style: TextStyle(
                                                    fontSize: 16.5,
                                                    color: Colors.white)),
                                            Text(
                                              "${result.orderId}",
                                              style: TextStyle(
                                                  fontSize: Get.height * 0.022,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 25,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 18,
                                          left: 18,
                                          right: 18,
                                          top: 10),
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
                                            controller: expandableController,
                                            theme: ExpandableThemeData(
                                                iconColor: Colors.black,
                                                iconSize: 30),
                                            header: Text(
                                              /*result!=null ? "${getAllissue(result.faults)}":*/
                                              "Sending offers".tr,
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: Get.height * 0.022,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            collapsed: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 6),
                                                    child: Text(
                                                      result.isTechnicianOrder
                                                          ? "Waiting".tr
                                                          : "${result.offers.length} " +
                                                              "WorkShop offers"
                                                                  .tr,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: Get.height *
                                                              0.022,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: Text(
                                                        "Average Price".tr,
                                                        style: TextStyle(
                                                            fontSize:
                                                                Get.height *
                                                                    0.018,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .blueGrey),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            getAveragePrice(
                                                                    result) ??
                                                                "",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  Get.height *
                                                                      0.022,
                                                            ),
                                                          ),
                                                          Text(
                                                            "SR ".tr,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  Get.height *
                                                                      0.022,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            expanded: Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              6.0),
                                                      child: Text(
                                                        result.isTechnicianOrder
                                                            ? "Waiting".tr
                                                            : " ${result.offers.length} " +
                                                                "Workshop Offers"
                                                                    .tr,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                                Get.height *
                                                                    0.022,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        softWrap: true,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
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
                                                                  "${result.creationDate.toString().replaceAll("00:00:00.000", '').replaceAll("T00:00:00", '')}",
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
                                                            left: 10),
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
                                                            left: 10),
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
                              result.offers.isNotEmpty
                                  ? Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          result.offers.length != 0
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10,
                                                          left: 10,
                                                          right: 10),
                                                  child: Text(
                                                    "WorkShop offers.".tr,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            Get.height * 0.022,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              : Container(),
                                          Expanded(
                                              child: ListView.builder(
                                                  // physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      result.offers.length,
                                                  padding: EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15,
                                                              right: 15,
                                                              bottom: 10),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          15.0),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        Get.height *
                                                                            0.07,
                                                                    width:
                                                                        Get.width *
                                                                            0.15,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        color: Colors
                                                                            .grey
                                                                            .shade200,
                                                                        image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'))),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              "${result.offers[index].workshopName}",
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: Get.height * 0.02,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          result.offers[index].isElite
                                                                              ? Row(
                                                                                  children: [
                                                                                    Image.asset('assets/images/yello_starr_filled.png'),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 6),
                                                                                      child: Text(
                                                                                        "Elite".tr,
                                                                                        style: TextStyle(color: orangeYellow, fontWeight: FontWeight.w500, fontSize: 17),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 15,
                                                                                    )
                                                                                  ],
                                                                                )
                                                                              : Container(),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                SvgPicture.asset(
                                                                                  'assets/save_tick_icon.svg',
                                                                                  height: 15,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    "Verified Shop".tr,
                                                                                    style: TextStyle(
                                                                                      color: Colors.green,
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontSize: Get.height * 0.016,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                SvgPicture.asset(
                                                                                  'assets/warranty.svg',
                                                                                  height: 15,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    "Offer Warranty".tr,
                                                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: Get.height * 0.016),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                SvgPicture.asset(
                                                                                  'assets/images/google.svg',
                                                                                  height: 16,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Text(
                                                                                  "${result.offers[index].googleRatings ?? 0}/5".tr,
                                                                                  style: TextStyle(color: Colors.black, fontSize: Get.height * 0.016),
                                                                                ),
                                                                                Icon(
                                                                                  Icons.star,
                                                                                  color: orangeYellow,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15,
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          20),
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade200,
                                                                        width:
                                                                            1.5),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          2.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                          child:
                                                                              Container(
                                                                        decoration:
                                                                            BoxDecoration(border: Border(right: BorderSide(color: Colors.grey.shade200, width: 0.5))),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(vertical: 0),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(
                                                                                "Price".tr,
                                                                                style: TextStyle(color: Colors.blueGrey),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 2,
                                                                              ),
                                                                              Text(
                                                                                " ${double.parse(result.offers[index].price.toString()).toStringAsFixed(1)} " + "SR".tr,
                                                                                style: TextStyle(fontSize: Get.height * 0.018, color: Colors.blue, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )),
                                                                      Expanded(
                                                                          child:
                                                                              Container(
                                                                        decoration:
                                                                            BoxDecoration(border: Border(left: BorderSide(color: Colors.grey.shade200, width: 0.5))),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(vertical: 12),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(
                                                                                "Duration".tr,
                                                                                style: TextStyle(color: Colors.blueGrey),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 2,
                                                                              ),
                                                                              Text(
                                                                                "${double.parse(result.offers[index].timeInDays.toString()).toInt()} " + "Working days".tr,
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(fontSize: Get.height * 0.016, color: Colors.black, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )),
                                                                      Expanded(
                                                                          child:
                                                                              Container(
                                                                        decoration:
                                                                            BoxDecoration(border: Border(left: BorderSide(color: Colors.grey.shade200, width: 0.5))),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(vertical: 12),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Text(
                                                                                "Distance".tr,
                                                                                style: TextStyle(color: Colors.blueGrey),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 2,
                                                                              ),
                                                                              Text(
                                                                                "${result.offers[index].distance} " + "KM".tr,
                                                                                style: TextStyle(fontSize: Get.height * 0.018, color: Colors.black, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),

                                                            !result
                                                                    .offers[
                                                                        index]
                                                                    .isRejected
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            20),
                                                                    child:
                                                                        Container(
                                                                      height: Get
                                                                              .height *
                                                                          0.07,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(2.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                                child: InkWell(
                                                                              onTap: () {
                                                                                negotiationSelector(index);
                                                                              },
                                                                              child: Container(
                                                                                height: 60,
                                                                                decoration: BoxDecoration(
                                                                                    color: Colors.blueGrey.shade400,
                                                                                    borderRadius: BorderRadius.only(
                                                                                      topLeft: Radius.circular(
                                                                                        Get.locale.toString().contains("en") ? 15 : 0,
                                                                                      ),
                                                                                      bottomLeft: Radius.circular(
                                                                                        Get.locale.toString().contains("en") ? 15 : 0,
                                                                                      ),

                                                                                      ///for arabic version
                                                                                      bottomRight: Radius.circular(
                                                                                        Get.locale.toString().contains("en") ? 0 : 15,
                                                                                      ),
                                                                                      topRight: Radius.circular(
                                                                                        Get.locale.toString().contains("en") ? 0 : 15,
                                                                                      ),
                                                                                    )),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "Negotiate".tr.tr,
                                                                                    style: TextStyle(color: Colors.white, fontSize: Get.height * 0.02, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )),
                                                                            Expanded(
                                                                                child: InkWell(
                                                                              onTap: () {
                                                                                acceptOffer(index);
                                                                              },
                                                                              child: Container(
                                                                                height: 60,
                                                                                decoration: BoxDecoration(
                                                                                    color: Colors.blue,
                                                                                    borderRadius: BorderRadius.only(
                                                                                      topLeft: Radius.circular(
                                                                                        Get.locale.toString().contains("en") ? 0 : 15,
                                                                                      ),
                                                                                      bottomLeft: Radius.circular(
                                                                                        Get.locale.toString().contains("en") ? 0 : 15,
                                                                                      ),

                                                                                      ///for arabic version
                                                                                      bottomRight: Radius.circular(
                                                                                        Get.locale.toString().contains("en") ? 15 : 0,
                                                                                      ),
                                                                                      topRight: Radius.circular(
                                                                                        Get.locale.toString().contains("en") ? 15 : 0,
                                                                                      ),
                                                                                    )),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "Accept".tr,
                                                                                    style: TextStyle(color: Colors.white, fontSize: Get.height * 0.02, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                            // data.offers[index].negotiationPendingCustomer ? Text(
                                                            //   'Workshop renegotiated the offer'.tr,
                                                            //   style: TextStyle(
                                                            //     color: Colors.red,
                                                            //     fontSize: Get.height * .02,
                                                            //   ),
                                                            // ): Container(),
                                                            InkWell(
                                                              onTap: () async {
                                                                Get.dialog(Center(
                                                                    child:
                                                                        CircularProgressIndicator()));
                                                                await ApiServices.rejectOffer(
                                                                    context,
                                                                    result
                                                                        .offers[
                                                                            index]
                                                                        .offerId
                                                                        .toString(),
                                                                    index,
                                                                    result
                                                                        .offers[
                                                                            index]
                                                                        .workshopId
                                                                        .toString());

                                                                orderProvider.getOfferrdersList();
                                                              },
                                                              child: Text(
                                                                !result
                                                                        .offers[
                                                                            index]
                                                                        .isRejected
                                                                    ? 'Reject'
                                                                        .tr
                                                                    : 'You rejected this offer'
                                                                        .tr
                                                                        .tr,
                                                                style:
                                                                    TextStyle(
                                                                  color: !result
                                                                          .offers[
                                                                              index]
                                                                          .isRejected
                                                                      ? Colors
                                                                          .grey
                                                                      : greylight,
                                                                  fontSize:
                                                                      Get.height *
                                                                          .02,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }))
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: Container(
                                      width: Get.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // SvgPicture.asset('assets/images/emoji_laugh.svg'),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            child: Text(
                                              result.isTechnicianOrder
                                                  ? "We are looking for the best technician for you, please wait"
                                                      .tr
                                                  : "We are looking for the best workshops offer for you, please wait"
                                                      .tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          JumpingDotsProgressIndicator(
                                            fontSize: 50,
                                            dotSpacing: 5,
                                            color: Colors.blue,
                                            milliseconds: 150,
                                          ),
                                          SizedBox(
                                            height: 50,
                                          ),
                                        ],
                                      ),
                                    )),
                            ],
                          )
                        : Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: blue,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      });

  void _onRefresh() async {
   orderProvider. getOfferrdersList();

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  Widget acceptOffer(int index) {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    logger.i(result.offers[index].offerId.toString());
    ApiServices.acceptOffer(
        context,
        result.offers[index].offerId.toString(),
        result.offers,
        result.orderId.toString(),
        result.offers[index].workshopId.toString());
  }

  String getAllissue(List<Fault> faults) {
    List<String> data = [];
    for (int i = 0; i < faults.length; i++) {
      data.add(faults[i].name);
    }
    return data.toString().replaceAll("[", "").replaceAll("]", "");
  }

  void negoitateOffer() async {
    await showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: orderNegotitateDialog(result.offers, 0, result: result),
          );
        });
    orderProvider.getOfferrdersList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    analytics.logEvent(name: "user_left_offer_screen");
  }

  void negotiationSelector(int index) {
    Get.bottomSheet(Material(
        color: Colors.transparent,
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.back();
                    negoitateOffer();
                  },
                  child: Container(
                    height: 55,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: blue,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Price Negotiate".tr,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.back();
                    var dashboardProvider = Provider.of<DashboardProvider>(
                        Get.context,
                        listen: false);
                    Get.to(ChatRoom(
                        chatRoomId:
                            "${dashboardProvider.userID}_${result.workshopId}_${result.orderId}",
                        messageSendBy: result.userId.toString()));
                  },
                  child: Container(
                    height: 55,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: blue)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Chat with workshop".tr,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    launch("tel://${result.offers[index].workShopContact}");
                  },
                  child: Container(
                    height: 55,
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: blue)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Call workshop".tr,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                  onTap: () => Get.back(),
                  child: Text(
                    "Cancel".tr,
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        )));
  }
}

String getAveragePrice(Result result) {
  double avr = 0.0;
  if (result.offers.isEmpty) {
    return avr.toString();
  }

  result.offers.forEach((element) {
    avr = avr + double.parse(element.price.toString());
  });

  return double.parse(avr.toString()).toInt().toString();
}
