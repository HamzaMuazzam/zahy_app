import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:musan_client/FCM.dart';

// import 'package:logger/logger.dart';
import 'package:musan_client/OrderPaymentHistoryDetailsCompleted.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/api_services/response_models/CarInformationReponse.dart';
import 'package:musan_client/api_services/response_models/CarPickUpType.dart';
import 'package:musan_client/api_services/response_models/CarRelatedInfoReponse.dart';
import 'package:musan_client/api_services/response_models/FaultsReponse.dart';
import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart'
    as WorkshopOffer;
import 'package:musan_client/api_services/response_models/GerOrderByUserIDReponse.dart';
import 'package:musan_client/api_services/response_models/GetDashboardCountsReponse.dart';
import 'package:musan_client/api_services/response_models/GetDiscountOffers.dart';
import 'package:musan_client/api_services/response_models/GetMyCarsByUserId.dart';
import 'package:musan_client/api_services/response_models/GetNotification.dart';
import 'package:musan_client/api_services/response_models/GetReportsByUserId.dart';


import 'package:musan_client/api_services/response_models/GetSinlgeOfferByOfferID.dart';
import 'package:musan_client/api_services/response_models/GetUserProfile.dart';
import 'package:musan_client/api_services/response_models/InitPaymentResponse.dart';
import 'package:musan_client/api_services/response_models/LoginReponse.dart';
import 'package:musan_client/api_services/response_models/PaymentHistoryResponse.dart';
import 'package:musan_client/api_services/response_models/PromotionCashBack.dart';
import 'package:musan_client/api_services/response_models/SignUpReponse.dart';
import 'package:musan_client/api_services/response_models/UserAllPaymentMethod.dart';
import 'package:musan_client/new_desgin_login/CreateAccount.dart';
import 'package:musan_client/locale/constantString.dart';
import 'package:musan_client/src/provider/Login_provider.dart';
import 'package:musan_client/src/provider/MyCarsScreenProvider.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/provider/WorkShopOrderProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/ThankYou.dart';
import 'package:musan_client/src/ui/auth/SignUp.dart';
import 'package:musan_client/src/ui/dashboard/dashboard_screen.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_tracking.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_tracking_new.dart';
import 'package:musan_client/utils/colors.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'response_models/GetCompletedOrInProgressOrderByUserId.dart';
import 'response_models/GetCompletedOrInProgressOrderByUserId.dart' as ord;

class ApiServices {
  static var _BASE_URL = 'https://muapi.deeps.info/api/';
  static var _LOGIN_URL = "accounts/signin";
  static var _GET_DASHBOARD_WIDGET_DATA = "workshops/getcounts";
  static var _GET_FAULTS = "faults";
  static var _GET_CAR_RELATED_INFORMATION = "carinformation/car-related-new-info";
  static var _GET_CAR_INFORMATION_BY_ID = "carinformation";
  static var _GET_FRESH_ORDER_BY_USER_ID = "orders/get-pending-orders/";
  static var _GET_FRESH_HOME_ORDER_BY_USER_ID = "orders/get-homepage-orders/";
  static var _ACCEPT_OFFER = "Offer/AcceptOffer/";
  static var _NegotiateOffer = "Offer/NegotiateOffer/";
  static var _ADD_A_CAR = "carinformation";
  static var _REJECT_OFFER = "Offer/RejectOffer/";
  static var _GET_INPROGRESSORDER = "orders/get-completedOrInProgress-orders/";

  static var _GET_MY_CARS_BY_ID = "carinformation/MyCars/";

  static var _GET_SINGLE_ORDER_BY_ID = "orders/";

  static var _ORDER_CAR_PICKUP = "CarPickupOrder/order";

  static var _ORDER_FROM_REPORT = "orders/order-from-report";

  static var _GET_ALL_REPORTS_USER_ID = "Technician/get-reports-user/";

  static var _GET_USERPROFILE = "usersettings/";

  static var _GET_NOTIFICATION = "notifications/getByUser/";

  static var _MARK_AS_READ_NOTIFICATION = "notifications/view/";

  static var _GET_DISCOUNT_OFFERS = "DiscountOffer";

  static var _GET_DEFAULT_PAYMENT_METHODS = "users/GetDefaultCards/";

  static var _GET_CARTYPE_PICKUP = "CarPickupType";

  static var _ADD_A_CARD = "users/add-card";

  static var _headers = {'Content-Type': 'application/json'};

  static var _PAYMENT_HISTORY = "orders/get-paymentstatuses/";

  static var _GET_SINGLE_OFFER_BY_ID = "Offer/";

  static var _NOTIFICATION_TEST = "notifications/test";

  static var _PAY_CAR_PICK_FINAL_BILL = "CarPickupOrder/pay-order/";

  static var _CANCEL_ORDER = "orders/cancel-order/";

  static var _HIT_NOTIFICATION_AFTER_PAYEMENT_DONE = "client/SendPaymentReceivedNotification/";
  static var _GET_COUPON_VALUE = "orders/coupon-value";

  static var dashboardProvider = Provider.of<DashboardProvider>(Get.context, listen: false);

  static var orderScreenProvider = Provider.of<OrderScreenProvider>(Get.context, listen: false);

  static final  workShopOrderProvider = Provider.of<WorkShopOrderProvider>(Get.context, listen: false);

  static http.Request requestCall;

  static Future request({String requestType, String feedUrl, String body}) async {

    requestCall = http.Request(requestType, Uri.parse('$_BASE_URL$feedUrl'));
    if (requestType == "GET") {
    }
    else if (requestType == "POST" && body!=null) {
      requestCall.body = body;
    }
    else if (requestType == "PUT" && body != null) {
      requestCall.body = body;
    }
    try{

      requestCall.headers.addAll(_headers);
      http.StreamedResponse response = await requestCall.send().timeout(Duration(minutes: 5));
      if (response.statusCode == 200) {
        print("await response.stream.bytesToString()");
        return await response.stream.bytesToString();
      }
      else {
        if(Get.isDialogOpen){
          Get.back();
        }
        print("response.reasonPhrase");
        return response.stream.bytesToString();
      }
    }
    catch(e){

      await analytics.logEvent(name: "API_CALL_FAILED:",parameters: {
        "Method":requestCall.method??"",
        "url_path":requestCall.url.path??"",
        "url_origin":requestCall.url.origin??"",
        "body":requestCall.body??"",
        "Error":e.toString()??"",
      });
      while(Get.isDialogOpen){
        if(Get.isDialogOpen){
          Get.back();
        }
      }
    }

  }

  static Future<bool> loginAccount(String body, BuildContext context, String phoneNumber, {bool isLoginMethodGoogle = false}) async {



    await ApiServices.request(
            requestType: "POST",
            feedUrl: ApiServices._LOGIN_URL,
            body: body.toString())
        .then((value) {
      if (Get.isDialogOpen) {
        Get.back();
      }
      if (value != null) {
        logger.e(value);
        if (value.toString().contains('"isError": true')) {
          /// this means user not registered
          print('setup an account');
          var loginProvider = Provider.of<LoginProvider>(context, listen: false);

          loginProvider.setUserMobileNumner(phoneNumber);

          if (!isLoginMethodGoogle) {
            Get.to(CreateAccount());
            analytics.logLogin(loginMethod: "CREATE_ACCOUNT_USING_MOBILE_NUMBER");

            // Get.to(EmailEnter());
          }
          else {
            /// sign up the user by google sign in details not email and name etc
            analytics.logLogin(loginMethod: "CREATE_ACCOUNT_USING_GOOGLE ");

            // String body ='{"name": "${loginProvider.currentUser.displayName}","email": "${loginProvider.currentUser.email}","phoneNumber": "${loginProvider.userMobileNumber}","password": "123456789","type": 1}';
            Map<String, String> body = {
              'Name': '${loginProvider.currentUser.displayName}',
              'PhoneNumber': '${loginProvider.userMobileNumber}',
              'Password': '123456789',
              'Type': '1',
              'Email': '${loginProvider.currentUser.email}',
              'FCMToken': 'noToken',
              'SpecializationId': '1',
              'IndustryId': '1',
              'CityId': '1',
              'Address': 'No Address Associated',
              'Latitude': '0',
              'Longitude': '0'
            };
            signUpUser(body, context);
          }
        }
        else {
          /// this means user already registered
          LoginReponse loginReponse = loginReponseFromJson(value);
          var loginProvider =Provider.of<LoginProvider>(context, listen: false);

          loginProvider.saveLogin(loginReponse);
          analytics.logLogin(loginMethod: "LOGIN_ACCOUNT");

          if (Get.isDialogOpen) {
            Get.back();
          }
        }




      } else {
        Get.snackbar(strError, strSomethingwentwrong);
      }
    });
  }

  static Future<String> signUpUser(Map<String, String> bodyMap, BuildContext context) async {
    TOASTS("Sign up");

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://muapi.deeps.info/api/Accounts/Register'));
    request.fields.addAll(bodyMap);
    http.StreamedResponse response = await request.send();
    try {
      if (Get.isDialogOpen) {
        Get.back();
      }

      response.stream.bytesToString().then((value) {
        print("Value: $value");
        if (value.toString().contains("successful")) {
          SignUpResponse signUpResponse =
              signUpResponseFromJson(value.toString());
          // signUpResponse.result.
          // Provider.of<Login>(context,listen: false);
          SharedPreferences.getInstance().then((value) {
            value
                .setString(Finals.USER_ID, signUpResponse.result.id.toString())
                .then((value) => null);
            value
                .setString(Finals.USER_TYPE_ID,
                    signUpResponse.result.userTypeId.toString())
                .then((value) => null);
            value
                .setString(
                    Finals.USER_EMAIL, signUpResponse.result.email.toString())
                .then((value) => null);
            value
                .setString(
                    Finals.USER_NAME, signUpResponse.result.name.toString())
                .then((value) => null);
            value
                .setString(Finals.USER_PHONE,
                    signUpResponse.result.phoneNumber.toString())
                .then((value) => null);
            value
                .setBool(Finals.USER_LOGGED_IN_OR_NOT, true)
                .then((value) => null);

            Get.offAll(() => DashboardScreen());
          });
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar(strError, strSomethingwentwrong);
    }

/*    await ApiServices.request(requestType: "POST", feedUrl: SIGN_UP_URL, body: body.toString())
        .then((value) async {
      if (value != null) {
        print(value);
        if (value.toString().contains(' "isError": true,')) {
          print('Error:  $value');
          if (Get.isDialogOpen) {
            Get.back();
          }
          return null;
        }
        else {
          print(value);

          SignUpReponse fromJson = signUpReponseFromJson(value);

          print("HElllo sign up response: $value");
          await SharedPreferences.getInstance().then((value) async {
            await value
                .setBool(Finals.USER_LOGGED_IN_OR_NOT, true)
                .then((value) => null);
            await value
                .setString(Finals.USER_EMAIL, fromJson.result.email)
                .then((value) => null);
            await value
                .setString(Finals.USER_ID, fromJson.result.id.toString())
                .then((value) => null);
            await value
                .setString(Finals.USER_NAME, fromJson.result.name)
                .then((value) => null);
            await value
                .setString(
                    Finals.USER_TYPE_ID, fromJson.result.userTypeId.toString())
                .then((value) => null);
            await value
                .setString(Finals.USER_PHONE, fromJson.result.phoneNumber)
                .then((value) => null);

            // var data = Provider.of<LoginProvider>(context);
            // data.setUserMobileNumner(fromJson.result.phoneNumber);

            Get.offAll(DashboardScreen());

            if (Get.isDialogOpen) {
              Get.back();
            }
          });

          return value;
        }





      } else {
       Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });*/
  }

  static getDashboardWidgetData(BuildContext context) {
    ApiServices.request(requestType: "GET", feedUrl: _GET_DASHBOARD_WIDGET_DATA)
        .then((value) async {
      if (value != null) {
        print("Value of data is: $value");

        try {
          GetDashboardCountsReponse countsReponseFromJson;

          countsReponseFromJson =
              getDashboardCountsReponseFromJson(value.toString());
          var provider = Provider.of<DashboardProvider>(context, listen: false);
          provider.setDashBoardWidgetData(true, countsReponseFromJson);
        } catch (e) {
          print(e);
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static getFaults(BuildContext context) {
    ApiServices.request(requestType: "GET", feedUrl: _GET_FAULTS)
        .then((value) async {
      if (value != null) {
        print("Value of data is: $value");

        try {
          FaultsReponse reponse = faultsReponseFromJson(value);

          var provider =
              Provider.of<WorkShopOrderProvider>(context, listen: false);
          provider.setFaultsResponse(true, reponse);

          if (Get.isDialogOpen) {
            Get.back();
          }
        } catch (e) {
          print(e);
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static addACar(BuildContext context, String body) {
    ApiServices.request(requestType: "POST", feedUrl: _ADD_A_CAR, body: body)
        .then((value) async {
      if (value != null) {
        print("Value of data is::::: $value");
        try {
          if (!value.toString().contains('isError": true')) {
            if (Get.isDialogOpen) {
              Get.back();
            }
            // Get.back();
            Provider.of<WorkShopOrderProvider>(context, listen: false).setisNewCarAdded(true);
            Get.dialog(Center(
              child: CircularProgressIndicator(),
            ));
            SharedPreferences.getInstance().then((value) {
              print("value.getString(Finals.USER_ID) ${value.getString(Finals.USER_ID)}");
              getCarInformationByUserID(context, value.getString(Finals.USER_ID));
            });
          }
        } catch (e) {
          print(e);
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static getCarRelatedInformation(BuildContext context) {
    ApiServices.request(
            requestType: "GET", feedUrl: _GET_CAR_RELATED_INFORMATION)
        .then((value) async {
      if (value != null) {
        print("Value of data is: $value");

          if (!value.toString().contains('isError": true')) {
            var provider =
                Provider.of<WorkShopOrderProvider>(context, listen: false);
            provider.setCarRelatedDataResponse(
                true, carRelatedInfoReponseFromJson(value.toString()));
          }
          if (Get.isDialogOpen) {
            Get.back();
          }

      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static getCarInformationByUserID(BuildContext context, String useRID) {
    ApiServices.request(
            requestType: "GET", feedUrl: "$_GET_CAR_INFORMATION_BY_ID/$useRID")
        .then((value) async {
      if (value != null) {
        // print("Car Response:: $value");
        // try {
        if (Get.isDialogOpen) {
          Get.back();
        }
        if (!value.toString().contains('isError": true')) {
          var provider =
              Provider.of<WorkShopOrderProvider>(Get.context, listen: false);
          provider.setCarInformationByUserIDResponse(true, carInformationReponseFromJson(value.toString()));
        }

        // } catch (e) {
        //   print("Error : : : $e");
        // }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static submitOrder(BuildContext context,Map<String, dynamic> body,
      int screenNumber,List<PickedFile> imageList,bool isFromDicountOffers) async {
    String url;
    if (isFromDicountOffers) {
      url = "https://muapi.deeps.info/api/DiscountOffer/avail";
    }
    else {
      url = "https://muapi.deeps.info/api/orders/client-order";
    }

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(body);

    imageList.forEach((element) async {
      request.files.add(await http.MultipartFile.fromPath(
          isFromDicountOffers ? 'pictures' : 'Pictures', element.path));
    });

    http.StreamedResponse response = await request.send();

    response.stream.bytesToString().then((value) async {

      if (Get.isDialogOpen) {
        Get.back();
      }
      if (value.toString().contains("successful")) {



        ///if service booked that's mean 0 and service is booked if not then workshop is booked and passed true for isWorkshop?
        dashboardProvider.hitWorkshopOrTechnician(screenNumber==0 ? false : true );


        Get.back();
        if (screenNumber == 0) {
          Get.snackbar(strServiceBooked, strYourservicehasbeenbooked);
        }
        else {
          Get.snackbar(strOrderBooked, strYourorderhasbeenbooked);
        }
        workShopOrderProvider.setImageSeletedOrNot(false);
        workShopOrderProvider.setisUserCarsLoaded(false);
        workShopOrderProvider.setFaultsResponse(false, null);
        workShopOrderProvider.setissuetypesList([]);
        workShopOrderProvider.setAddress("$strSelectLocation");
        workShopOrderProvider.imageList.clear();
        workShopOrderProvider.freeComment="";
        await getOffersAndOderAtOnce();

        Get.to(ThankYou());
        await analytics.logEvent(name: "NEW_ORDER_BOOKED",parameters:body);

      }
      else {
        Get.snackbar(strError, strSomethingwentwrong);
      }
    });

    // ApiServices.request(
    //         requestType: "POST", feedUrl: "$SUBMIT_ORDER", body: body)
    //     .then((value) async {
    //   if (value != null) {
    //     print("Order Response:: $value");
    //     try {

    //       if (!value.toString().contains('isError": true')) {
    //         Get.back();
    //

    //       }
    //     } catch (e) {
    //       print(e);
    //     }
    //   } else {
    //     if (Get.isDialogOpen) {
    //       Get.back();
    //     }
    //   }
    // });
  }

  static Future<void> getFreshOrderByUserId(BuildContext context, String body) async{
    print("body $body");

   await  request(requestType: "GET",feedUrl: "$_GET_FRESH_ORDER_BY_USER_ID$body?sortBy=${orderScreenProvider.sortoffers}&sortDir=desc",

   ).then((value) {
      if (Get.isDialogOpen) {
        Get.back();
      }
      // logger.e("_GET_FRESH_ORDER_BY_USER_ID $value");
      if (value != null) {
        if (value.toString().contains('"isError": true')) {
          return;
        }

        orderScreenProvider.setIsOrderDataLoaded(true);
        orderScreenProvider.setFreshOrderData(getFreshOrderByUserIdReponseFromJson(value.toString()));
        // orderScreenProvider.getSetOfferAndOrderAtOnce(value.toString(), null);
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });


  }

  static acceptOffer(BuildContext context, String offerid, offers, String orderId, String workshopId) {
    request(
      requestType: "PUT",
      feedUrl: "$_ACCEPT_OFFER$offerid",
    ).then((value) async{
      if (Get.isDialogOpen) {
        Get.back();
      }
      logger.wtf("ACCPET OFFER $value");
      if (value != null) {
        try {
          if (value.toString().contains("successful")) {
            dashboardProvider.hitSpecificWorkshop(workshopId,orderId);

            dashboardProvider.hitWorkshopOrTechnician(true);
            if (offers != null) {
            }
            Get.back();
            Get.snackbar("$strSuccessful", strOfferaccepted);
            await  getOffersAndOderAtOnce();

            Get.to(OrderTracking(null,true,int.parse(orderId)));


            analytics.logEvent(name: "Offer Accepted");
          }
        } catch (e) {
          print("Exception $e");
        }
      }
      else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static negotiateOffer(BuildContext context, String offerid, String price, {workshopId}) async {
    print(price);
    request(
      requestType: "PUT",
      feedUrl: "$_NegotiateOffer$offerid?price=$price",
    ).then((value) async{
      if (value != null) {
        print(value);
        try {
          if (Get.isDialogOpen) {
            Get.back();
          }

          if (value.toString().contains("successful")) {
            dashboardProvider.hitWorkshopForOfferNegotiation(offerid,price,workshopId.toString());
            await  getOffersAndOderAtOnce();

            Get.back();
            Get.snackbar(strSuccessful, strRequestsuccessful);
            analytics.logEvent(name: "negotiateOffer");

          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static Future<void> rejectOffer(BuildContext context, String offerid, int index, workshopId) async {
  await   request(
      requestType: "PUT",
      feedUrl: "$_REJECT_OFFER$offerid",
    ).then((value) async{
      if (value != null) {
        logger.i(value);
        logger.e(offerid);
        try {
          if (Get.isDialogOpen) {
            Get.back();
          }

          if (value.toString().contains("successful")) {
            dashboardProvider.hitSpecificWorkshopForOfferRejected(workshopId);
            Get.snackbar(strSuccessful, strRequestsuccessful);
            analytics.logEvent(name: "rejectOffer");

          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static Future<void> getInProgressOrders(BuildContext context, String userID) async {
    await request(
      requestType: "GET",
      feedUrl:
          "$_GET_INPROGRESSORDER$userID?sortBy=${orderScreenProvider.sortOrderForApi}&sortDir=desc",
    ).then((value) {
      if (value != null) {
        // logger.e("getInProgressOrders $value");
        try {
          if (Get.isDialogOpen) {
            Get.back();
          }

          if (value.toString().contains("successful")) {
            var provider =
                Provider.of<OrderScreenProvider>(context, listen: false);
            provider.setIsInprogressCompletedOrderDataLoaded(true,getCompletedOrInProgressOrderByUserIdFromJson(
                    value.toString()));

            // orderScreenProvider.getSetOfferAndOrderAtOnce(
            //     null, value.toString());

            // Get.back();
          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static getInProgressHomeOrders(BuildContext context, String userID) {
    request(
      requestType: "GET",
      feedUrl: "$_GET_FRESH_HOME_ORDER_BY_USER_ID$userID?sortDir=desc",
    ).then((value) {
      if (value != null) {
        // print(value);
        // logger.e("_GET_FRESH_HOME_ORDER_BY_USER_ID $value");
        try {
          if (Get.isDialogOpen) {
            Get.back();
          }

          if (value.toString().contains("successful")) {
            var provider =
                Provider.of<OrderScreenProvider>(context, listen: false);
            provider.setIsInprogressCompletedHomeOrderDataLoaded(
                true,
                getCompletedOrInProgressOrderByUserIdFromJson(
                    value.toString()));
          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static getMyCarsById(BuildContext context, String userID) {
    request(
      requestType: "GET",
      feedUrl: "$_GET_MY_CARS_BY_ID$userID",
    ).then((value) {
      if (value != null) {
        print(value);
        try {
          if (Get.isDialogOpen) {
            Get.back();
          }

          if (value.toString().contains("successful")) {
            var provider =
                Provider.of<MyCarsScreenProvider>(context, listen: false);
            provider.setMyCars(
                true, getMyCarsByUserIdFromJson(value.toString()));
          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static getSignleOrderByUserID(String orderID) {
    // logger.i(_GET_SINGLE_ORDER_BY_ID + orderID);
    request(
      requestType: "GET",
      feedUrl: "$_GET_SINGLE_ORDER_BY_ID$orderID",
    ).then((value) {
      if (Get.isDialogOpen) {
        Get.back();
      }

      if (value != null) {
        // logger.e(value);
        // try {
          if (value.toString().contains("successful")) {
            var provider =
                Provider.of<OrderScreenProvider>(Get.context, listen: false);
            provider.setSignleOrder(
                true, getSingleOrderByUserIdFromJson(value.toString()));
          }
        // } catch (e) {
        //   print("Exception $e");
        // }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static getSignleOrderByUserIDForPaymentHistory(String orderID) {
    request(
      requestType: "GET",
      feedUrl: "$_GET_SINGLE_ORDER_BY_ID$orderID",
    ).then((value) {
      if (Get.isDialogOpen) {
        Get.back();
      }

      if (value != null) {
        print(value);
        // try {

        if (value.toString().contains("successful")) {
          // var provider =Provider.of<OrderScreenProvider>(Get.context, listen: false);
          // provider.setSignleOrder(true, getSingleOrderByUserIdFromJson(value.toString()));
          var orderByUserId = getSingleOrderByUserIdFromJson(value.toString());

          Get.to(OrderPaymentHistoryDetailsCompleted(orderByUserId.result));
        }
        // } catch (e) {
        //   print("Exception $e");
        // }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void orderCarPickUp(orderId, String comments, String workshopId, int carPickupTypeId) {

    String body = '{"workshopOrderId": $orderId,"comment": "$comments ","CarPickupTypeId":$carPickupTypeId}';

    ApiServices.request(requestType: "POST", feedUrl: _ORDER_CAR_PICKUP, body: body)
        .then((value) async {
      if (value != null) {
        print("Value of data is::::: $value");
        try {
          if (!value.toString().contains('isError": true')) {
            dashboardProvider.hitAllCarPickups(workshopId,orderId.toString());
            if (Get.isDialogOpen) {
              Get.back();
            }
            Get.dialog(Center(
              child: CircularProgressIndicator(
                backgroundColor: themeColor,
              ),
            ));
            getSignleOrderByUserID(orderId.toString());
            await  getOffersAndOderAtOnce();

            analytics.logEvent(name: "orderCarPickUp");

          }
        } catch (e) {
          print(e);
        }
      }
      else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void orderFromReport(String reportID) {
    Get.dialog(Center(
      child: CircularProgressIndicator(
        backgroundColor: themeColor,
      ),
    ));

    String body = '{"reportId": $reportID}';
    print(body);
    ApiServices.request(
            requestType: "POST", feedUrl: _ORDER_FROM_REPORT, body: body)
        .then((value) async {
      if (Get.isDialogOpen) {
        Get.back();
      }
      if (value != null) {
        print("Value of data is::::: $value");
        try {
          if (!value.toString().contains('"isError": true')) {
            Get.bottomSheet(serviceCostBottomSheet());
            await  getOffersAndOderAtOnce();

            analytics.logEvent(name: "orderFromReport");

          } else {
            Get.snackbar(strError, strSomethingwentwrong);
          }
        } catch (e) {
          print(e);
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void getAllReportsByUserID(String userID) {
    // logger.i('dashboardProvider.userID $userID');
    ApiServices.request(
            requestType: "GET", feedUrl: "$_GET_ALL_REPORTS_USER_ID" + userID)
        .then((value) async {
      if (Get.isDialogOpen) {
        Get.back();
      }
      try {
        // logger.e("getAllReportsByUserID ${value}");
        // Get.bottomSheet(OrderNowBottomSheet());
        await    getOffersAndOderAtOnce();

        orderScreenProvider.setORderFromReortsData(true, getReportsByUserIdFromJson(value.toString()));

      } catch (e) {}

      if (value != null) {
        print("Value of data is: $value");
        if (!value.toString().contains("isError")) {
          try {} catch (e) {
            print(e);
          }
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static serviceCostBottomSheet() {
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
                  thickness: 6,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: Get.height * .01),
              Text(
                strSWorkshopService,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.height * .022,
                  color: headingTextColor,
                ),
              ),
              SizedBox(height: Get.height * .01),
              SizedBox(height: Get.height * .01),
              Text(
                strYourorderhasbeenbooked,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.height * .019,
                  color: headingTextColor.withOpacity(.50),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.back();
                },
                child: Container(
                  width: Get.width,
                  height: Get.height * .065,
                  margin: EdgeInsets.only(
                    top: Get.height * .03,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.13),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Text(
                    '$strOK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Get.height * .02,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void loadUserProfile(String userID) {
    Future.delayed(Duration.zero, () {
      Get.dialog(Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ));
    });
    ApiServices.request(
            requestType: "GET", feedUrl: "$_GET_USERPROFILE${userID}")
        .then((value) async {
          logger.e(value);
      if (Get.isDialogOpen) {
        Get.back();
      }

      if (value != null) {
        print("Value of data is: $value");
        if (!value.toString().contains("isError")) {
          try {

            dashboardProvider.setUserProfileData(getUserProfileFromJson(value.toString()), true);

          }
          catch (e) {
            print(e);
          }
        }
      }
      else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }

    });
  }

  static void updateUserSettings(String firstname, String lastNAme,String email, String mobileNumber, File image) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    ));

    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            'https://muapi.deeps.info/api/usersettings/user-profile-update/${dashboardProvider.userID}'));

    request.fields.addAll({
      'Name': '$firstname $lastNAme',
      'Email': '$email',
      'Phone': '$mobileNumber'
    });
    if (image.path.length > 4) {
      request.files
          .add(await http.MultipartFile.fromPath('DisplayPicture', image.path));
    }

    http.StreamedResponse response = await request.send();

    response.stream.bytesToString().then((value) {
      if (Get.isDialogOpen) {
        Get.back();
      }
      if (value.toString().contains("successful")) {
        loadUserProfile(dashboardProvider.userID);
        Get.back();
        Get.snackbar(strProfileUpdated, strProfilehasbeenupdatedsuccessfully);
      }
    });
  }

  static void getNotifications() {
    request(
            requestType: "GET",
            feedUrl: _GET_NOTIFICATION + dashboardProvider.userID)
        .then((value) {
      print(value);
      if (Get.isDialogOpen) {
        Get.back();
      }

      if (value != null) {
        dashboardProvider.setNotificationsData(
            getNotificationFromJson(value.toString()), true);
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void markAsReadNotification(int id) {
    Get.dialog(Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    ));
    request(
            requestType: "PUT",
            feedUrl: _MARK_AS_READ_NOTIFICATION + id.toString(),
            body: null)
        .then((value) {
      print(value);
      if (Get.isDialogOpen) {
        Get.back();
      }

      if (value != null) {
        Get.dialog(Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ));
        getNotifications();
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void getDiscountOffers() {
    request(feedUrl: _GET_DISCOUNT_OFFERS, requestType: "GET").then((value) {
      print(value);
      if (Get.isDialogOpen) {
        Get.back();
      }

      if (value != null) {
        dashboardProvider.setDiscountOffers(
            getDiscountOffersFromJson(value.toString()), true);
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void rejectDownPayment(String orderID, workshopId) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    ));

    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            'https://muapi.deeps.info/api/orders/reject-down-payment/$orderID'));

    http.StreamedResponse response = await request.send();

    response.stream.bytesToString().then((value) async {
      print(value);
      // if(Get.isDialogOpen){
      // Get.back();
      // }
      if (value.toString().contains("successful")) {
        dashboardProvider.hitWorkshopForOrderProgressed(workshopId,orderID);
        ApiServices.getSignleOrderByUserID(orderID);
        await   getOffersAndOderAtOnce();

      }
    });
  }

  static void acceptEditInTimeAndCost(String orderID, String workshopId) async {
    var request = http.MultipartRequest('PUT',
        Uri.parse('https://muapi.deeps.info/api/orders/accept-edits/$orderID'));

    http.StreamedResponse response = await request.send();

    response.stream.bytesToString().then((value)async {
      print(value);
      if (Get.isDialogOpen) {
        Get.back();
      }
      if (value.toString().contains("successful")) {
        dashboardProvider.hitWorkshopForOrderProgressed(workshopId, orderID);
        await  getOffersAndOderAtOnce();
        ApiServices.getSignleOrderByUserID(orderID);
      } else {
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void rejectEditInTimeAndCost(String orderID, String workshopId) async {
    var request = http.Request('PUT',
        Uri.parse('https://muapi.deeps.info/api/orders/reject-edits/$orderID'));

    http.StreamedResponse response = await request.send();

    response.stream.bytesToString().then((value) async {
      if (Get.isDialogOpen) {
        Get.back();
      }

      print("valureactive $value");
      if (value != null) {
        try {
          if (value.toString().contains("successful")) {
            dashboardProvider.hitWorkshopForOrderProgressed(workshopId, orderID);
            ApiServices.getSignleOrderByUserID(orderID);
            await    getOffersAndOderAtOnce();

            var decode = json.decode(value.toString());
            // TOASTS(decode['result']);
          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void getCarPickTypeCosts(ord.Result result) {
    request(requestType: "GET", feedUrl: _GET_CARTYPE_PICKUP).then((value) {
      if (Get.isDialogOpen) {
        Get.back();
      }

      print(value);
      if (value != null) {
        try {
          if (value.toString().contains("successful")) {
            CarPickUpType upType = carPickUpTypeFromJson(value.toString());
            _showBottomSheetForCarPickupPayment(result, upType);
          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static _showBottomSheetForCarPickupPayment(ord.Result result, CarPickUpType upType) {
    if (upType == null) {
      return;
    }

    dashboardProvider.setcarpickCost(upType.result[0].cost.toString(),0);

    Get.bottomSheet(
        Consumer<DashboardProvider>(builder: (builder, data, child) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 35,
              ),
              Text(
                "Do you need to pick up your car?".tr,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    Expanded(
                        child: Center(
                            child: InkWell(
                              onTap: () {
                                data.setcarpickCost(upType.result[0].cost.toString(), 0);
                                print(upType.result[0].cost.toString());
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: data.cardTypeGroupNumber == 0
                                            ? Colors.blue
                                            : Colors.grey),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/images/Hydraulic.svg",
                                        fit: BoxFit.fill,
                                        height: 28,
                                        color: data.cardTypeGroupNumber == 0
                                            ? Colors.blue
                                            : Colors.grey),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${upType.result[0].type}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: data.cardTypeGroupNumber == 0
                                              ? Colors.blue
                                              : Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ))),
                    Expanded(
                        child: Center(
                            child: InkWell(
                              onTap: () {
                                data.setcarpickCost(upType.result[1].cost.toString(), 1);
                                print(upType.result[1].cost.toString());
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: data.cardTypeGroupNumber == 1
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/images/regular.svg",
                                        fit: BoxFit.fill,
                                        height: 22,
                                        color: data.cardTypeGroupNumber == 1
                                            ? Colors.blue
                                            : Colors.grey),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${upType.result[1].type} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: data.cardTypeGroupNumber == 1
                                              ? Colors.blue
                                              : Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ))),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Center(
                            child: InkWell(
                              onTap: () {
                                data.setcarpickCost(upType.result[2].cost.toString(), 2);
                                print(upType.result[2].cost.toString());
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: data.cardTypeGroupNumber == 2
                                          ? Colors.blue
                                          : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/images/regular.svg",
                                        fit: BoxFit.fill,
                                        height: 22,
                                        color: data.cardTypeGroupNumber == 2
                                            ? Colors.blue
                                            : Colors.grey),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${upType.result[2].type} ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: data.cardTypeGroupNumber == 2
                                              ? Colors.blue
                                              : Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ))),
                    Expanded(
                        child: Center(
                            child: InkWell(
                              onTap: () {
                                data.setcarpickCost(upType.result[3].cost.toString(), 3);
                                print(upType.result[3].cost.toString());
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: data.cardTypeGroupNumber == 3
                                            ? Colors.blue
                                            : Colors.grey),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/images/Hydraulic.svg",
                                        fit: BoxFit.fill,
                                        height: 28,
                                        color: data.cardTypeGroupNumber == 3
                                            ? Colors.blue
                                            : Colors.grey),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${upType.result[3].type}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: data.cardTypeGroupNumber == 3
                                              ? Colors.blue
                                              : Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ))),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                  onTap: () {
                    Get.back();
                    Get.dialog(Center(
                      child: CircularProgressIndicator(),
                    ));
                    ApiServices.orderCarPickUp(result.orderId.toString(), result.comments,result.workshopId.toString(),data.cardTypeGroupNumber);
                  },
                  child: Container(
                    height: 50,
                    child: Center(
                      child:
                          Text(strConfirm, style: TextStyle(color: Colors.white)),
                    ),
                    decoration: BoxDecoration(
                        color: blue, borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      );
    }),


    );
  }

  static void rejectOrderParts(int orderPartId, orderId, workshopId) async {
    print(orderPartId);
    var request = http.Request(
        'PUT',
        Uri.parse(
            'https://muapi.deeps.info/api/OrderPart/reject-part/$orderPartId'));

    http.StreamedResponse response = await request.send();
    response.stream.bytesToString().then((value)async {
      print(value);
      if (value != null) {
        try {
          if (value.toString().contains("successful")) {
            provider.hitWorkshopForOrderProgressed(workshopId, orderId);
            TOASTS("Request successful");
            await  getOffersAndOderAtOnce();
            getSignleOrderByUserID(orderId.toString());
          }
        } catch (e) {
          print("Exception $e");
          TOASTS("Error".tr);
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static Future<bool> acceptPart({bool isPaid, int partID, orderId, String workshopId,isCashBack=false}) async {
    var request = http.Request(
        'PUT',
        Uri.parse('https://muapi.deeps.info/api/OrderPart/approve-part/$partID?isPaid=$isPaid&isWallet=$isCashBack'));

    http.StreamedResponse response = await request.send();

    response.stream.bytesToString().then((value) async{
      print(value);

      if (value != null) {
        dashboardProvider.hitWorkshopForOrderProgressed(workshopId, orderId.toString());
        await  getOffersAndOderAtOnce();

        getSignleOrderByUserID(orderId.toString());
        return true;


      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
        return false;

      }
    });
  }

  static  Future<bool> acceptAndPayDownPayment(orderId, {bool isCashback=false}) async {
    var request = http.Request('PUT',
        Uri.parse('https://muapi.deeps.info/api/orders/down-payment/$orderId?isWallet=$isCashback'));
    http.StreamedResponse response = await request.send();
    response.stream.bytesToString().then((value) async{
      print(value);

      if (value != null) {
        await  getOffersAndOderAtOnce();
        getSignleOrderByUserID(orderId.toString());
        return true;
      }
      else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
        return false;

      }
    });
  }

  static Future<void> payFinalBill(String orderId, {  bool isCash: false,  bool isWallet=false }) async {
    var request = http.Request('PUT',
        Uri.parse('https://muapi.deeps.info/api/orders/pay-order/$orderId?isCash=$isCash&isWallet=$isWallet'));
    // request.body='{"isCash":$isCash}';

    http.StreamedResponse response = await request.send();
    response.stream.bytesToString().then((value) async{
      print(value);
      if (value != null) {

        await  getOffersAndOderAtOnce();

        getSignleOrderByUserID(orderId.toString());
      }
      else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void getPaymentHistory() {
    request(
            requestType: "GET",
            feedUrl: _PAYMENT_HISTORY + dashboardProvider.userID)
        .then((value) {
      if (Get.isDialogOpen) {
        Get.back();
      }

      print("valureactive $value");
      if (value != null) {
        try {
          if (value.toString().contains("successful")) {
            dashboardProvider.setPaymentHistory(
                true, paymentHistoryResponseFromJson(value.toString()));
          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void giveFeedBack(orderId, String rating, String feedback, {bool isRefreshHomeScreenData}) async{
    String body = '{"review": "$feedback","rating": $rating}';
    request(
            requestType: "PUT",
            feedUrl: "orders/client-review/$orderId",
            body: body)
        .then((value) async{
      if (Get.isDialogOpen) {
        Get.back();
      }
      print("value giveFeedBack $value");
      if (value != null) {
        try {
          if (value.toString().contains("successful")) {
            // Get.offAll(DashboardScreen());
            Get.back();
            dashboardProvider.onTabbedBar(0);

            if (!isRefreshHomeScreenData) {
              await getOffersAndOderAtOnce();
              getSignleOrderByUserID(orderId.toString());
            } else {
              getInProgressHomeOrders(Get.context, dashboardProvider.userID);
            }
          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void hitNotificationForChat(String body) {
    print("body $body");
    request(requestType: "POST", feedUrl: _NOTIFICATION_TEST, body: body)
        .then((value) {
      print("_NOTIFICATION_TEST $_NOTIFICATION_TEST");
      print("value $value");
    });
  }

  static void cancelOrder(String orderId, String workshopId) async{
    request(requestType: "PUT", feedUrl: _CANCEL_ORDER + orderId).then((value) async{
      print("valureactive $value");
      if (value != null) {
        try {
          if (value.toString().contains("successful")) {
            dashboardProvider.hitWorkshopForOrderProgressed(workshopId, orderId,data:"OrderCancelled");

            if (Get.isDialogOpen) {
              Get.back();
            }
            await  getOffersAndOderAtOnce();

          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void payCarPickUpFinalBill(String carPickIDOrderID, String carPickUpId) async {
    request(
      requestType: "PUT",
      feedUrl: _PAY_CAR_PICK_FINAL_BILL + carPickIDOrderID,
    ).then((value) async{

      print("payCarPickUpFinalBill $value");
      if (value != null) {
        try {
          if (value.toString().contains("successful")) {

            ///I need car pick up id here for notify car pick about change in order progressed...
            logger.wtf(dashboardProvider.carPickUpId);
            dashboardProvider.hitCarPickUpForFInalPaymenDone(carPickIDOrderID,dashboardProvider.orderId.toString(),dashboardProvider.carPickUpId);
            await getOffersAndOderAtOnce();

            getSignleOrderByUserID(dashboardProvider.orderId.toString());
          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void getSingleOfferByOfferID(String offerID) {
    request(requestType: "GET", feedUrl: _GET_SINGLE_OFFER_BY_ID + offerID)
        .then((value) {
      print("payCarPickUpFinalBill $value");
      if (value != null) {
        try {
          if (value.toString().contains("successful")) {
            var offerByOfferId = getSinlgeOfferByOfferIdFromJson(value.toString());
            var result = offerByOfferId.result;
            for (int i = 0; i < orderScreenProvider.offers.length; i++) {
              if (offerID.contains(orderScreenProvider.offers[i].offerId.toString())) {
                orderScreenProvider.offers.removeAt(i);
                orderScreenProvider.offers.insert(
                    i,
                    WorkshopOffer.Offer(
                      offerId: result.offerId,
                      price: result.price,
                      timeInDays: result.timeInDays,
                      offerDate: result.offerDate,
                      isNegotiable: result.isNegotiable,
                      isAccepted: result.isAccepted,
                      isRejected: result.isRejected,
                      workshopName: result.workshopName,
                      workshopRating: result.workshopRating,
                      customerOfferedPrice: result.customerOfferedPrice,
                      negotiationPendingCustomer:
                          result.negotiationPendingCustomer,
                      negotiationPendingWorkshop:
                          result.negotiationPendingWorkshop,
                      views: result.views,
                      warrantyProvided: result.warrantyProvided,
                      workshopId: result.workshopId,
                      offerStatus: result.offerStatus,
                    ));
              }
            }
            orderScreenProvider.notifyListeners();

          }
        } catch (e) {
          print("Exception $e");
        }
      } else {
        Get.snackbar(strError, strSomethingwentwrong);
        if (Get.isDialogOpen) {
          Get.back();
        }
      }
    });
  }

  static void hitNotificationAfterPaymentMade(String orderID)async {
    await request(requestType: "GET",feedUrl: _HIT_NOTIFICATION_AFTER_PAYEMENT_DONE+orderID).then((value) {

    });

  }

  static Future<bool> getCashBack() async {

    dashboardProvider.isCashBackLoaded=false;
    dashboardProvider.notifyListeners();
      print("dashboardProvider.userID ${dashboardProvider.userID}");
    var request = http.MultipartRequest('POST', Uri.parse('https://muapi.deeps.info/api/orders/client-wallet'));
    request.fields.addAll({
      'userId': '${dashboardProvider.userID}'
    });


    http.StreamedResponse response = await request.send();

    var body = await response.stream.bytesToString();

    logger.e(body);

    if (response.statusCode == 200) {
      dashboardProvider.setCashback(true,promotionCashBackFromJson(body));
      return true;
    }
    else if(response.statusCode==404){
      return false;
    }
    else {
      print(await response.stream.bytesToString());
      print(response.reasonPhrase);
      return false;
    }

  }

  static Future<String> getCashBackValueOfCoupon()async {

    // return await request(requestType: "POST",feedUrl: _GET_COUPON_VALUE,body: null);
    var request = http.Request('POST', Uri.parse('https://muapi.deeps.info/api/orders/coupon-value'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      return response.reasonPhrase;
    }
  }

  static void applyCouponCode(String code,String orderId) async {
    var request = http.Request('POST', Uri.parse('https://muapi.deeps.info/api/orders/coupon-validity?couponCode=$code&userId=${dashboardProvider.userID}&OrderId=$orderId'));


    http.StreamedResponse response = await request.send();

     String body = await response.stream.bytesToString();
     logger.e(body);
     var decode = json.decode(body);
      TOASTS(decode['result']);

  }

}

showProgress(){
  Get.dialog(Center(child: CircularProgressIndicator(),));
}