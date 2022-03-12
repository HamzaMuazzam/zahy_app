import 'package:assets_audio_player/assets_audio_player.dart' as AssetPlayer;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:musan_client/api_services/ApiServices.dart';
import 'package:musan_client/api_services/response_models/OpenScreenForNotifications.dart';
import 'package:musan_client/src/provider/OrderScreenProvider.dart';
import 'package:musan_client/src/provider/dashboard_provider.dart';
import 'package:musan_client/src/ui/dashboard/dashboard_screen.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_tracking.dart';
import 'package:musan_client/src/ui/dashboard/orders/order_tracking_new.dart';
import 'package:musan_client/utils/common_classes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ChatRoom.dart';
import 'api_services/Finals.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
///


var provider = Provider.of<DashboardProvider>(Get.context, listen: false);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage event) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
/*  // print('Handling a background message ${message.messageId}');


  if (message.data.toString().contains("MethodName") ) {
    logger.e(message.data);
    logger.e(Get.currentRoute);
    logger.i(Get.context);

    if(message.data.toString().contains("NewOfferRecieved")){

      // _listenNewOfferReceived(message.data);
    }

  }


  if(message.data.toString().contains("NewOfferRecieved")){

    logger.e(message.data);
    // print(message.data);
    //

  }*/


/*
  if (event.notification != null) {
    FlutterRingtonePlayer.playNotification();
  }
  else {
    ///play custom shound here
    playCustomSound();
  }
*/
  //
  // await fltrNotification.show(
  //     provider.notificationNumber,
  //     "New Offer Received",
  //     "A workshop recently sent you an offer on your order.",
  //     generalNotificationDetails,
  //     payload: "event.data.toString()");
  // provider.increamentNotificationNumber();
  listenFcm(event);


}


Future<void> getOffersAndOderAtOnce() async {
  var orderScreenProvider =Provider.of<OrderScreenProvider>(Get.context, listen: false);
  orderScreenProvider.setIsInprogressCompletedOrderDataLoaded2();
  // orderScreenProvider.setIsOrderDataLoaded(false);
  await ApiServices.getFreshOrderByUserId(Get.context, provider.userID);
  await ApiServices.getInProgressOrders(Get.context,  provider.userID);
  // orderScreenProvider.notifyListeners();
  // logger.i("HAMZA MUAZZAM");

}



playCustomSound() {
  AssetPlayer.AssetsAudioPlayer.newPlayer().open(
    AssetPlayer.Audio("assets/audios/notification_sound.mp3"),
  );
}

class FCM {
  FirebaseMessaging _messaging;

  String userID;

  String userTypeId;

  FCM({this.userID, this.userTypeId}) {
    FlutterLocalNotificationsPlugin fltrNotification;

    var androidInitilize = new AndroidInitializationSettings('logo');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: onLocalNotificationSelected);

    Firebase.initializeApp().then((fbr)async {
      _messaging = FirebaseMessaging.instance;
      await FirebaseMessaging.instance.subscribeToTopic("AllUsers").then((value) => null);

      _messaging.getToken().then((token) async {
        FirebaseMessaging.onBackgroundMessage(
            _firebaseMessagingBackgroundHandler);

        SharedPreferences.getInstance().then((shared) async {
          var noti = shared.getBool(Finals.USER_NOTIFICATION);
          if (noti == null) {
            shared
                .setBool(Finals.USER_NOTIFICATION, true)
                .then((value) => null);
            await FirebaseMessaging.instance
                .subscribeToTopic(shared.getString(Finals.USER_ID));
            await FirebaseMessaging.instance
                .subscribeToTopic(shared.getString(Finals.USER_TYPE_ID));
          }
          else if (noti) {
            // print("Topic Subscribed");
            shared
                .setBool(Finals.USER_NOTIFICATION, true)
                .then((value) => null);
            await FirebaseMessaging.instance
                .subscribeToTopic(shared.getString(Finals.USER_ID));
            await FirebaseMessaging.instance
                .subscribeToTopic(shared.getString(Finals.USER_TYPE_ID));
          }
        });

        NotificationSettings settings = await _messaging.requestPermission(
          alert: true,
          badge: true,
          provisional: false,
          sound: true,
        );

        if (settings.authorizationStatus == AuthorizationStatus.authorized) {
          /// call when app is in BG
          await Firebase.initializeApp();

          /// will call when user click on notification created by OS it self or using FCM when app was in BG
          FirebaseMessaging.onMessageOpenedApp.listen((event) {
            // print('FirebaseMessaging.onMessageOpenedApp');
            onFCMNotificationSelected(event.data.toString());
          });

          /// generate notification your self
          FirebaseMessaging.onMessage.listen((event) {
            // print('FirebaseMessaging.onMessage.listen');
            // print("event.data ${event.data.toString()}");
            if (event.data.toString().contains("chatID")) {
              var currentRoute = Get.currentRoute;
              if (!currentRoute.contains("ChatRoom")) {
                _showLocalNotification(event);
              }
            }
            else {
              _showLocalNotification(event);
            }
            // TOASTS("Local Notification  ${event.data.toString()}");
          });
        }
      });
    });
  }

  Future _showLocalNotification(RemoteMessage event) async {
/*    var iSODetails = new IOSNotificationDetails();
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer",
        // sound: event.notification==null ? RawResourceAndroidNotificationSound('alert'):null,
        sound: null,
        playSound: false,
        priority: Priority.max,
        importance: Importance.max);
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);
    var androidInitilize = new AndroidInitializationSettings('logo');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    FlutterLocalNotificationsPlugin fltrNotification;
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: onLocalNotificationSelected);*/

    logger.e("NOTIFICATION DATA => ${event.data}");
    listenFcm(event);
  }

  Future onLocalNotificationSelected(String payload) async {
    // print(payload);

    _openScreenForNotifications(payload);

    // showDialog(
    //   context: Get.context,
    //   builder: (context) => AlertDialog(
    //     content: Text("onLocalNotificationSelected PayLoad : $payload"),
    //   ),
    // );
  }

  onFCMNotificationSelected(String payload) async {
    _openScreenForNotifications(payload);
  }

  _openScreenForNotifications(String payload) {
    payload = payload.replaceAll("{", "").replaceAll("}", "");
    var dataSp = payload.split(',');
    Map<String, String> mapData = Map();
    dataSp.forEach(
        (element) => mapData[element.split(':')[0]] = element.split(':')[1]);

    Map<String, String> lastmap = {};

    mapData.forEach((key, value) {
      // print('"${key.trim()}"');
      // print('"${value.trim()}"');
      lastmap['"${key.trim()}"'] = '"${value.trim()}"';
    });
    // print("LAstMAp: $lastmap");

    Future.delayed(Duration.zero, () {
      var dashboardProvider =
          Provider.of<DashboardProvider>(Get.context, listen: false);
      var notificationsFromJson =
          openScreenForNotificationsFromJson(lastmap.toString());

      var currentRoute = Get.currentRoute;
      // TOASTS(currentRoute);

      if (notificationsFromJson.routeName == "offerScreen") {
        Get.offAll(DashboardScreen());
        Get.dialog(Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ));

        Future.delayed(Duration(seconds: 2), () {
          if (Get.isDialogOpen) {
            Get.back();
          }
          dashboardProvider.onTabbedBar(1);
        });
      } else if (notificationsFromJson.routeName == "orderScreen" ||
          notificationsFromJson.routeName == "orderScreenTechnician" ||
          notificationsFromJson.routeName == "orderScreenTech") {
        if (currentRoute.contains("OrderTracking")) {
          // TOASTS("OrderTracking is already open");
          Provider.of<OrderScreenProvider>(Get.context, listen: false)
              .setSignleOrder(false, null);
          ApiServices.getSignleOrderByUserID(notificationsFromJson.orderId);
        } else {
          // Get.to(() => OrderTracking(int.parse(notificationsFromJson.orderId)));
          Get.to(Get.to(OrderTracking(null,true,int.parse(notificationsFromJson.orderId))));

        }
      } else if (notificationsFromJson.routeName == "popUpNegotiation") {
        // Get.offAll(DashboardScreen());

        var data = Provider.of<DashboardProvider>(Get.context, listen: false);
        Get.dialog(Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ));

        Future.delayed(Duration(seconds: 3), () {
          // ApiServices.getOfferByOfferID_showDialogeToAcceptRejectNegotiatedOfferFromWorkShop(notificationsFromJson, data);
        });
      } else if (notificationsFromJson.routeName == "ChatRoom") {
        var splitIDS = notificationsFromJson.chatID.split("_");
        var clientID = splitIDS[0];
        var providerID = splitIDS[1];
        var orderID = splitIDS[2];
        // TOASTS("ChatRoom $splitIDS");
        Get.to(ChatRoom(
            chatRoomId: "${clientID}_${providerID}_$orderID",
            messageSendBy: providerID.toString()));
      } else if (notificationsFromJson.routeName == "orderScreenCarPickup") {
        if (currentRoute.contains("OrderTracking")) {
          // TOASTS("OrderTracking is already open");
          Provider.of<OrderScreenProvider>(Get.context, listen: false)
              .setSignleOrder(false, null);
          ApiServices.getSignleOrderByUserID(notificationsFromJson.orderId);
        } else {
          // Get.to(() => OrderTracking(int.parse(notificationsFromJson.orderId)));
          Get.to(Get.to(OrderTracking(null,true,int.parse(notificationsFromJson.orderId))));

        }
      }
    });
  }

}
void listenFcm(RemoteMessage event) async{
  FlutterLocalNotificationsPlugin fltrNotification;

  var androidDetails =
  new AndroidNotificationDetails("Channel ID", "Desi programmer",
      importance: Importance.max,
      // sound: RawResourceAndroidNotificationSound('alert'),
      sound: null,
      playSound: false,
      priority: Priority.max);
  var iSODetails = new IOSNotificationDetails();
  var generalNotificationDetails =   new NotificationDetails(android: androidDetails, iOS: iSODetails);
  var androidInitilize = new AndroidInitializationSettings('logo');
  var iOSinitilize = new IOSInitializationSettings();
  var initilizationsSettings = new InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
  fltrNotification = new FlutterLocalNotificationsPlugin();
  fltrNotification.initialize(initilizationsSettings);

  logger.i("event.notification != null ${event.notification} ");
  if (event.notification != null) {
    // FlutterRingtonePlayer.playNotification();
    if(event.data.toString().contains('OrderProgressed')){
      logger.e("NOTIFICATION DATA => ${event.data}");
      FlutterRingtonePlayer.playNotification();

      // _listenOrderProgressed(event.data);
    }
    else if(event.data.toString().contains('TechnicianOrderAccepted')){
      logger.e("NOTIFICATION DATA => ${event.data}");
      FlutterRingtonePlayer.playNotification();

      // _listenOrderProgressed(event.data);
    }


    else if(event.data.toString().contains('OfferNegotiateSuccess')){
      logger.e("NOTIFICATION DATA => ${event.data}");
      FlutterRingtonePlayer.playNotification();
      // _listenOfferNegotiateSuccess(event.data);
    }

    else if(event.data.toString().contains('OfferNegotiate') ) {
      logger.e("NOTIFICATION DATA => ${event.data}");
      FlutterRingtonePlayer.playNotification();
      // _listenOfferNegotiateFromWorkshop(event.data);
    }

  }

  else if(event.notification == null) {

    if(event.data.toString().contains('NewOfferRecieved')){
      logger.e("NOTIFICATION DATA => ${event.data}");

      // playCustomSound();
      // _listenNewOfferReceived(event.data);
    }

  }

  await fltrNotification.show(
      provider.notificationNumber,
      event.notification != null
          ? event.notification.title
          : "New Offer Received".tr,
      event.notification != null
          ? event.notification.body
          : "A workshop recently sent you an offer on your order.".tr,
      generalNotificationDetails,
      payload: event.data.toString());
  provider.increamentNotificationNumber();
}
