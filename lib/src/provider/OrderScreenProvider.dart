import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart';
import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart' as WorkshopOffer;
import 'package:musan_client/api_services/response_models/GetCompletedOrInProgressOrderByUserId.dart';
import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart' as GerOrderByUserIdReponsed;
import 'package:musan_client/api_services/response_models/GetReportsByUserId.dart';
import 'package:musan_client/api_services/response_models/GetSingleOrderByUserID.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';



class OrderScreenProvider extends ChangeNotifier{

  bool isFreshOrderDataLoaded = false;

  bool isInprogressCompletedOrderDataLoaded= false;

  bool isSingleOrderDataLoaded=false;

  GetFreshOrderByUserIdReponse getFreshOrderByUserIdReponse;

  GetCompletedOrInProgressOrderByUserId completedOrInProgressOrderByUserIdFromJson;
  GetCompletedOrInProgressOrderByUserId completedOrInProgressOrderByUserIdFromJsonForHome;
  var dashboardProvider = Provider.of<DashboardProvider>(Get.context,listen: false);
  bool isInprogressCompletedHomeOrderDataLoaded=false;

  GetSingleOrderByUserId singleOrderByUserIdFromJson;
  setORderData(GetFreshOrderByUserIdReponse gerOrderByUserIdReponseFromJson) {
    this.getFreshOrderByUserIdReponse = gerOrderByUserIdReponseFromJson;
    notifyListeners();
  }


  void setIsOrderDataLoaded(bool value) {
    this.isFreshOrderDataLoaded = value;
    notifyListeners();
  }

  removeOrderDueToAcceptOffer(GerOrderByUserIdReponsed.Result result){
  getFreshOrderByUserIdReponse.result.remove(result);
  notifyListeners();
  }

  setIsInprogressCompletedOrderDataLoaded(bool value, GetCompletedOrInProgressOrderByUserId completedOrInProgressOrderByUserIdFromJson) {
    this.completedOrInProgressOrderByUserIdFromJson=completedOrInProgressOrderByUserIdFromJson;
    isInprogressCompletedOrderDataLoaded = value;
    notifyListeners();
  }
  setIsInprogressCompletedOrderDataLoaded2() {
    this.completedOrInProgressOrderByUserIdFromJson=null;
    this.getFreshOrderByUserIdReponse=null;
    isInprogressCompletedOrderDataLoaded = false;
    isFreshOrderDataLoaded = false;
  }

  setIsInprogressCompletedHomeOrderDataLoaded(bool value, GetCompletedOrInProgressOrderByUserId completedOrInProgressOrderByUserIdFromJson) {
    this.completedOrInProgressOrderByUserIdFromJsonForHome=completedOrInProgressOrderByUserIdFromJson;
    isInprogressCompletedHomeOrderDataLoaded = value;
    notifyListeners();
  }
  void setSignleOrder(bool isSingleOrderDataLoaded, GetSingleOrderByUserId singleOrderByUserIdFromJson) {
    print("setSignleOrder");
    this.singleOrderByUserIdFromJson=singleOrderByUserIdFromJson;
    this.isSingleOrderDataLoaded=isSingleOrderDataLoaded;
    notifyListeners();
  }
  List<WorkshopOffer.Offer> offers=[];
  void setWorkshopOffers(List<WorkshopOffer.Offer> offers) {
    this.offers=offers;
    notifyListeners();

  }

  void addOfferTolist(offerObject) {
    if(offerObject!=null){
      var logger=new Logger();
      logger.e(offerObject);
      // final Map<String, dynamic> decode = json.decode(offerObject.toString());

    offers.add(WorkshopOffer.Offer.fromJson(offerObject));
    notifyListeners();
    }
  }
  String singalOrderId;
  void setSignleOrderID(String singalOrderId) {
    this.singalOrderId=singalOrderId;
    notifyListeners();
  }
  ///for sorting and Filter algothrm and
  ///
  ///

  String sortOrder = "Sort Reset".tr;
  String sortOrderForApi = "";
  void setsortOrders(String sortOrder) {
    this.sortOrder = sortOrder;
    if(sortOrder.contains("Sort".tr)){
      sortOrderForApi = "";
    }
    else if(sortOrder.contains("Date".tr)){
      sortOrderForApi = "date";
    }
    else if(sortOrder.contains("Order".tr)){
      sortOrderForApi = "ordernumber";
    }
    else if(sortOrder.contains("Price".tr)){
      sortOrderForApi = "price";
    }
    notifyListeners();
    // TOASTS(sortOrderForApi);
    Get.dialog(Center(child: CircularProgressIndicator(),));
    ApiServices.getInProgressOrders(Get.context, dashboardProvider.userID);
  }
  bool isReverseOrders=false;
  void setOrderRevesreValue(value){
    this.isReverseOrders=value;
    notifyListeners();
  }
  String filterOrders="Filter Reset".tr;
  void setFilterForOrders(String filterOrders) {
  this.filterOrders=filterOrders;
  notifyListeners();
  }

  ///
  ///
  ///
  String sortoffers="Sort Reset".tr;
  String sortoffersforApi="desc".tr;
  String filteroffers="Filter Reset".tr;
  void setFilterForOffers(String filter) {
    this.filteroffers=filter;
    notifyListeners();
  }
  void setsortOffers(String sort) {
    this.sortoffers=sort;

    if(sort.contains("Sort".tr)){

      sortoffersforApi="";
    }
    else if (sort.contains("Time".tr)){
      sortoffersforApi="timeInDays";
    }
    else if (sort.contains("Price".tr)){
      sortoffersforApi="price";
    }
    else if (sort.contains("Date".tr)){
      sortoffersforApi="date";
    }
    notifyListeners();
    Get.dialog(Center(child: CircularProgressIndicator(),));
    ApiServices.getFreshOrderByUserId(Get.context, dashboardProvider.userID.toString());
  }


  bool isReverseoffers=false;
  void setOffersRevesreValue(value){
    this.isReverseoffers=value;
    notifyListeners();
  }

///


  // Map<String,String> orderOfferAtOnce={
  //   '"OfferCustomObject"':"",
  //   '"OrderCustomObject"':"",
  // };
// getSetOfferAndOrderAtOnce(String offers,String orders){
//   if(offers!=null){
//     orderOfferAtOnce['"OfferCustomObject"']=offers;
//   }
//   if(orders!=null){
//     orderOfferAtOnce['"OrderCustomObject"']=orders;
//   }
//   // logger.e(orderOfferAtOnce);
//   notifyListeners();
//
// }
  PageController homePagePictureIndicatorController = new PageController();

bool isOrderFromReportsLoaded=false;
  GetReportsByUserId reportsByUserIdFromJson;
  void setORderFromReortsData(bool value, GetReportsByUserId reportsByUserIdFromJson) {
    isOrderFromReportsLoaded=value;
    this.reportsByUserIdFromJson=reportsByUserIdFromJson;
    notifyListeners();
  }



}