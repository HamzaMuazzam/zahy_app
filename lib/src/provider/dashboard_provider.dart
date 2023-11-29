import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:musan_client/PaymentWebView.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/Finals.dart';
import 'package:musan_client/api_services/response_models/GetDashboardCountsReponse.dart';
import 'package:musan_client/api_services/response_models/GetDiscountOffers.dart';
import 'package:musan_client/api_services/response_models/GetNotification.dart';
import 'package:musan_client/api_services/response_models/GetUserProfile.dart';
import 'package:musan_client/api_services/response_models/InitPaymentResponse.dart';
import 'package:musan_client/api_services/response_models/PaymentHistoryResponse.dart';
import 'package:musan_client/api_services/response_models/PromotionCashBack.dart';
import 'package:musan_client/api_services/response_models/UserAllPaymentMethod.dart';
import 'package:musan_client/lib/my_cars_screens.dart';
import 'package:musan_client/src/ui/dashboard/home/home_screen.dart';
import 'package:musan_client/src/ui/dashboard/notification_screen.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_list_screen.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_tracking_new.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:musan_client/utils/images.dart';
import 'package:musan_client/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../FCM.dart';
import 'OrderScreenProvider.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;

class DashboardProvider extends ChangeNotifier {
  var couponAmount = "";

  initAnalytics() {
    analytics.logAppOpen();
    // analytics.logLogin()
    // analytics.logEvent(name: name)
    // analytics.logScreenView()
    //  analytics.logSignUp(signUpMethod: signUpMethod)
  }

  bool isUserProfileLoaded = false;

  bool isNotiDataLoaded = false;

  bool isDicountOffersLaoded = false;

  bool isHomeWidgetDataAvailable = false;

  bool notificaionSetting = true;

  bool autoValidate = false;

  bool isPaymentHistoryLoaded = false;

  DateTime currentBackPressTime;

  int inviteScreenInviteSelection;

  File profileImage;

  int notificationNumber = 0;

  int bottomBarCurrentIndex = 0;

  int cardTypeGroupNumber = 0;

  var homePagePicture = 0;

  String carpickCost = "0";

  String userID = " ";
  String userName = " ";

  GetUserProfile userProfileFromJson;

  GetNotification notificationFromJson;

  GetDiscountOffers discountOffersFromJson;

  UserPaymentMethod userAllPaymentMethodFromJson;

  var logger = Logger();

  int cardDefualtPAymentGroupValue = -1;

  int setCardID;

  String cardCompany;

  int isTechnicianOrder = 0;

  void setcardDefualtPAymentGroupValue(value) {
    this.cardDefualtPAymentGroupValue = value;
    notifyListeners();
  }

  void setUserProfileData(
      GetUserProfile userProfileFromJson, bool isUserProfileLoaded) {
    this.userProfileFromJson = userProfileFromJson;
    this.isUserProfileLoaded = isUserProfileLoaded;

    editProfileNumberController.text =
        userProfileFromJson.result.phoneNumber.toString();
    editProfileEmailController.text = userProfileFromJson.result.email;
    try {
      var split = userProfileFromJson.result.name.split(" ");
      editProfileFirstNameController.text = split[0].toString();
      editProfileLastNameController.text = split[1].toString();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setcarpickCost(String carpickCost, int i) {
    this.cardTypeGroupNumber = i;
    this.carpickCost = carpickCost;
    notifyListeners();
  }

  increamentNotificationNumber() {
    notificationNumber++;
  }

  GetDashboardCountsReponse countsReponseFromJson;

  sethomePagePicture(int value) {
    homePagePicture = value;
    // TOASTS(value.toString());
    notifyListeners();
  }

  final GlobalKey<ScaffoldState> dashboardBoardScaffoldKey =
      new GlobalKey<ScaffoldState>();

  String negotiatePrioce = " ";

  PageController homePagePictureIndicatorController = new PageController();

  final GlobalKey<FormState> addACarFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> inviteFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> negotitateFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  TextEditingController inviteMobileNumberController = TextEditingController();

  TextEditingController negotitateSetPriceController = TextEditingController();

  TextEditingController addACarCarTypeController = TextEditingController();

  TextEditingController addACarCompanyNameController = TextEditingController();

  TextEditingController addACarModelController = TextEditingController();

  TextEditingController addACarColorController = TextEditingController();

  TextEditingController addACarGearTransmissionController =
      TextEditingController();

  TextEditingController workShopOrderFreeCommentController =
      TextEditingController();

  TextEditingController editProfileFirstNameController =
      TextEditingController();

  TextEditingController editProfileLastNameController = TextEditingController();

  TextEditingController editProfileEmailController = TextEditingController();

  TextEditingController editProfileNumberController = TextEditingController();

  InitPaymentResponse initPaymentResponseFromJson;

  DateTime negotaiteTime;

  List imagesList = [
    pic1,
    pic2,
  ];

  @override
  void dispose() {
    homePagePictureIndicatorController.dispose();
    super.dispose();
  }

  final List<Widget> childrens = [
    HomeScreen(),
    OrderListScreen(),
    // OrderScreen(),
    MyCarsScreenNewDesign()
    // MyCarScreen(screenChecked: 0),

    // HelpScreen(),
    ,
    NotificationScreen(),
    // NotificationScreen(),
    // NotificationScreen(),
  ];

  void onTabbedBar(int index) {
    bottomBarCurrentIndex = index;
    notifyListeners();
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      AppRoutes.toast("Press again to Exit".tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future addACarOnButtonTapped() {
    if (addACarFormKey.currentState.validate()) {
      Get.back();
    } else {
      autoValidate = true;
      notifyListeners();
    }
  }

  Future inviteScreenOnInviteTapped() {
    if (inviteFormKey.currentState.validate()) {
      if (inviteScreenInviteSelection == null) {
        AppRoutes.getSnackbar(
            'Invite Selection'.tr, 'Please select Provider or client'.tr);
      } else {
        // inviteMobileNumberController.clear();
        // inviteScreenInviteSelection = null;
        // Get.back();

        launch(
            'sms:${inviteMobileNumberController.text}?body=Hello, this is Musan we are lucky to have a chance to invited you by our customer, please check the link below to download the app… enjoy 😉 \n Musan.net');
      }
    } else {
      autoValidate = true;
      notifyListeners();
    }
  }

  Future<File> getGallery() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    return profileImage = File(pickedFile.path);

    notifyListeners();
  }

  callDashboardData(BuildContext context) {
    ApiServices.getDashboardWidgetData(context);
  }

  setDashBoardWidgetData(bool isHomeWidgetDataAvailable,
      GetDashboardCountsReponse countsReponseFromJson) {
    this.isHomeWidgetDataAvailable = isHomeWidgetDataAvailable;
    this.countsReponseFromJson = countsReponseFromJson;
    notifyListeners();
  }

  void getNotificaionValue() {
    SharedPreferences.getInstance().then((value) {
      var notify = value.getBool(Finals.USER_NOTIFICATION);
      if (notify == null) {
        value.setBool(Finals.USER_NOTIFICATION, true);
        getNotificaionValue();
      } else {
        this.notificaionSetting = notify;
      }

      if (Get.isDialogOpen) {
        Get.back();
      }
      notifyListeners();
    });
  }

  void updateNotificationSetting(bool settingValue) {
    SharedPreferences.getInstance().then((value) {
      value.setBool(Finals.USER_NOTIFICATION, settingValue).then((value) {
        getNotificaionValue();
      });
    });
  }

  void sub_unsub_topic(bool settingValue) {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    SharedPreferences.getInstance().then((shared) {
      Firebase.initializeApp().then((value) async {
        if (settingValue) {
          await FirebaseMessaging.instance
              .unsubscribeFromTopic(shared.getString(Finals.USER_ID));
          await FirebaseMessaging.instance
              .unsubscribeFromTopic(shared.getString(Finals.USER_TYPE_ID));
          print("Topic Un-Subscribed");
          updateNotificationSetting(settingValue);
        } else {
          await FirebaseMessaging.instance
              .subscribeToTopic(shared.getString(Finals.USER_ID));
          await FirebaseMessaging.instance
              .subscribeToTopic(shared.getString(Finals.USER_TYPE_ID));
          print("Topic Subscribed");

          updateNotificationSetting(settingValue);
        }
      });
    });
  }

  void setUserId(String userID) {
    this.userID = userID;
    notifyListeners();
  }

  void setNotificationsData(GetNotification notificationFromJson, bool value) {
    isNotiDataLoaded = value;
    this.notificationFromJson = notificationFromJson;
    notifyListeners();
  }

  void setDiscountOffers(GetDiscountOffers discountOffersFromJson, bool value) {
    this.discountOffersFromJson = discountOffersFromJson;
    this.isDicountOffersLaoded = value;
    notifyListeners();
  }

  String cardNumber = "";

  String cardCVC = "";

  TextEditingController cardDate = TextEditingController(text: "");

  int partID, orderId;

  var workshopId;

  void setPartIdAndORderId({int partID, orderId, var workshopId}) {
    this.partID = partID;
    this.orderId = orderId;
    this.workshopId = workshopId;
  }

  PaymentHistoryResponse paymentHistoryResponseFromJson;

  void setPaymentHistory(bool isPaymentHistoryLoaded,
      PaymentHistoryResponse paymentHistoryResponseFromJson) {
    this.isPaymentHistoryLoaded = isPaymentHistoryLoaded;
    this.paymentHistoryResponseFromJson = paymentHistoryResponseFromJson;
    notifyListeners();
  }

  String carPickupOrderId;
  String carPickUpId;

  void setCarPickOrderID(
      String carPickupOrderId, String carPickUpId, String workshopID) {
    this.carPickupOrderId = carPickupOrderId;
    this.carPickUpId = carPickUpId;
    this.workshopId = workshopID;
  }

  FirebaseFirestore collectionReference = FirebaseFirestore.instance;

  ///TODO: for Realtime using Firebase firestore Database
  ///TODO: We are creating SingleTon Class because listen method will registered if we call listen many times.

  void initlizeRealTimeDatabase() async {
    RealTimeSingleton(collectionReference);
  }

  ///TODO: hit Workshop or Technician

  hitWorkshopOrTechnician(bool isWorkShop) async {
    if (isWorkShop) {
      await collectionReference.collection("userTypes").doc('workshop').set({
        'WhatUpdated': "Workshop_NewOfferReceived_${DateTime.now().toString()}"
      });
    } else if (!isWorkShop) {
      // await ref.child("/userTypes/technician").set({'WhatUpdated': "Technician_NewOfferReceived_${DateTime.now().toString()}"});
      await collectionReference.collection("userTypes").doc('technician').set({
        'WhatUpdated':
            "Technician_NewOfferReceived_${DateTime.now().toString()}"
      });
    }
  }

  hitAllCarPickups(String workshopId, String orderId) async {
    await collectionReference
        .collection('users')
        .doc(workshopId ?? "")
        .set({"WhatUpdated": "OrderProgressed", "OrderId": orderId});

    await collectionReference.collection("userTypes").doc('carpickup').set({
      'WhatUpdated': "CarPickUp_NewOfferReceived_${DateTime.now().toString()}"
    });
  }

  void hitWorkshopForOfferNegotiation(
      String offerid, String price, String workshopId) async {
    await collectionReference.collection('users').doc(workshopId ?? "").set({
      "WhatUpdated": "OfferNegotiationFromClient",
      "OfferId": offerid,
      "ClientId": userID
    });
  }

  void hitSpecificWorkshop(String workshopId, String orderId) async {
    await collectionReference.collection("userTypes").doc('workshop').set({
      'WhatUpdated': "Workshop_NewOfferReceived_${DateTime.now().toString()}"
    });
    await collectionReference.collection('users').doc(workshopId ?? "").set({
      "WhatUpdated": "OfferAccepted",
      "ClientId": userID,
      "OrderId": orderId
    });
  }

  void hitSpecificWorkshopForOfferRejected(String workshopId) async {
    await collectionReference
        .collection('users')
        .doc(workshopId ?? "demo")
        .set({"WhatUpdated": "OfferRejected", "workshopId": workshopId});
  }

  void hitWorkshopForOrderProgressed(workshopId, orderId,
      {String data: "OrderProgressed"}) async {
    collectionReference
        .collection("users")
        .doc(workshopId.toString())
        .set({"WhatUpdated": data, "OrderId": orderId.toString()});
  }

  void hitCarPickUpForFInalPaymenDone(
      String carPickIDOrderID, String orderId, String carpickId) async {
    await collectionReference
        .collection('users')
        .doc(carpickId)
        .set({"WhatUpdated": "OrderProgressed"});
  }

  Future startPayingPayment(
    String paymentType,
    String paymentAmount,
  ) async {
    await Get.to(() => PaymentWebView(
            url: 'https://mucp.deeps.info/Home/Payment?userId=$userID&orderId='
                '$orderId&amount=${(double.parse(paymentAmount) * 100).toInt()}'))
        .then((value) {
      print(value);
      if (value != null) {
        logger.e("paymentType ${paymentType}");
        if (value) {
          analytics.logEvent(name: "PaymentMade");
          Get.dialog(Center(
            child: CircularProgressIndicator(),
          ));
          hitWorkshopForOrderProgressed(workshopId ?? "0", orderId ?? "0");

          if (paymentType == "OrderPart".tr) {
            ApiServices.acceptPart(
                isPaid: true,
                partID: partID,
                orderId: orderId,
                workshopId: workshopId);
            ApiServices.hitNotificationAfterPaymentMade(orderId.toString());
          } else if (paymentType == "CarPickUp".tr) {
            ApiServices.payCarPickUpFinalBill(
                dashboardProvider.carPickupOrderId,
                dashboardProvider.carPickUpId);
            ApiServices.hitNotificationAfterPaymentMade(
                carPickupOrderId.toString());
          } else if (paymentType == "DownPayment".tr) {
            ApiServices.acceptAndPayDownPayment(orderId.toString());
            ApiServices.hitNotificationAfterPaymentMade(orderId.toString());
          } else if (paymentType == 'Final Bill'.tr) {
            ApiServices.hitNotificationAfterPaymentMade(orderId.toString());
            ApiServices.payFinalBill(orderId.toString(), isCash: false);
          } else if (paymentType == 'Cash'.tr) {}
        }
      }
    });
  }

  bool isCashBackLoaded = false;

  PromotionCashBack promotionCashBackFromJson;

  void setCashback(
      bool isCashBackLoaded, PromotionCashBack promotionCashBackFromJson) {
    this.isCashBackLoaded = isCashBackLoaded;
    this.promotionCashBackFromJson = promotionCashBackFromJson;
    notifyListeners();
  }
}

var dashboardProvider =
    Provider.of<DashboardProvider>(Get.context, listen: false);
var orderScreenProvider =
    Provider.of<OrderScreenProvider>(Get.context, listen: false);

class RealTimeSingleton {
  static RealTimeSingleton _instance;
  RealTimeSingleton._internal();
  factory RealTimeSingleton(FirebaseFirestore collectionReference) {
    if (_instance == null) {
      collectionReference
          .collection("clients")
          .doc(dashboardProvider.userID)
          .snapshots()
          .listen((event) async {
        if (event.data() == null) return;
        logger.i("event.data() ${event.data() as Map<String, dynamic>}");

        await getOffersAndOderAtOnce();

        if (event.data().toString().contains("NewOfferReceived")) {
          playCustomSound();
          listenNewOfferReceived(event.data);

          // getHomeScreenDataAll();

          collectionReference
              .collection("clients")
              .doc(dashboardProvider.userID)
              .delete();
        } else if (event
            .data()
            .toString()
            .contains("OfferReNegotiatedFromWorkShop")) {
          _listenOfferNegotiateFromWorkshop(event.data());
          collectionReference
              .collection("clients")
              .doc(dashboardProvider.userID)
              .delete();
        } else if (event.data().toString().contains("WorkShopAcceptedOffer")) {
          _listenOfferNegotiateSuccess(event.data());
          collectionReference
              .collection("clients")
              .doc(dashboardProvider.userID)
              .delete();
        } else if (event.data().toString().contains("OrderProgressed")) {
          _listenOrderProgressed(event.data());
          collectionReference
              .collection("clients")
              .doc(dashboardProvider.userID)
              .delete();
        } else if (event
            .data()
            .toString()
            .contains("TechnicianOrderAccepted")) {
          _listenOrderProgressed(event.data());
          collectionReference
              .collection("clients")
              .doc(dashboardProvider.userID)
              .delete();
        }
      });
      _instance = RealTimeSingleton._internal();
    }
    return _instance;
  }
}

listenNewOfferReceived(arguments) {
  orderProvider.getOfferrdersList();
  // TOASTS("New Offer Received".tr);
  //
  // logger.i("NewOfferReceived $arguments");
  //
  // if(Get.currentRoute.toString().contains("WorkShopOffer")){
  //
  // }
  // else{
  //   provider.onTabbedBar(1);
  // }
}

_listenOfferNegotiateFromWorkshop(Map<String, dynamic> data) {
  orderProvider.getOfferrdersList();
  // if(Get.currentRoute.contains("WorkShopOffer")){
  //   ApiServices.getSingleOfferByOfferID(data["OfferId"].toString());
  // }
}

_listenOfferNegotiateSuccess(Map<String, dynamic> data) {
  if (Get.currentRoute.contains('OrderOfferScreen')) {
    Get.back();
  }

  if (!Get.currentRoute.contains('OrderTracking')) {
    // Get.to(OrderTracking(int.parse(data['OrderId'].toString())));
    Get.to(OrderTracking(null, true, int.parse(data['OrderId'].toString())));

    // Get.to(OrderTracking(int.parse(data['OrderId'].toString())));
  }
}

_listenOrderProgressed(Map<String, dynamic> data) {
  logger.e('_listenOrderProgressed ${Get.currentRoute}');

  ApiServices.getInProgressHomeOrders(Get.context, provider.userID);

  var orderId = data['OrderId'];

  var whatUpdated = data['WhatUpdated'];

  if (whatUpdated.toString().contains("CarPickupPaid")) {
    return;
  }

  if (Get.currentRoute.contains("OrderTracking") &&
      orderScreenProvider.singalOrderId == orderId.toString()) {
    if (data.toString().contains("OrderFinished")) {
      while (Get.isDialogOpen) {
        Get.back();
      }

      while (Get.isBottomSheetOpen) {
        Get.back();
      }
    }
    ApiServices.getSignleOrderByUserID(orderScreenProvider.singalOrderId);
  } else if (!Get.currentRoute.contains("OrderTracking")) {
    Get.to(OrderTracking(null, true, int.parse(orderId.toString())));
  }
}
