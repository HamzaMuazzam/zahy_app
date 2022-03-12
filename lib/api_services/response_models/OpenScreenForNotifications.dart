// To parse this JSON data, do
//
//     final openScreenForNotifications = openScreenForNotificationsFromJson(jsonString);

import 'dart:convert';

OpenScreenForNotifications openScreenForNotificationsFromJson(String str) => OpenScreenForNotifications.fromJson(json.decode(str));

String openScreenForNotificationsToJson(OpenScreenForNotifications data) => json.encode(data.toJson());

class OpenScreenForNotifications {
  OpenScreenForNotifications({
    this.userTypeId,
    this.orderId,
    this.offerId,
    this.workshopId,
    this.userId,
    this.routeName,
    this.chatID,
  });

  String userTypeId;
  String chatID;
  String orderId;
  String offerId;
  String workshopId;
  String userId;
  String routeName;

  factory OpenScreenForNotifications.fromJson(Map<String, dynamic> json) => OpenScreenForNotifications(
    userTypeId: json["userTypeId"],
    orderId: json["orderId"],
    offerId: json["offerId"],
    workshopId: json["workshopId"],
    userId: json["userId"],
    routeName: json["routeName"],
    chatID: json["chatID"],
  );

  Map<String, dynamic> toJson() => {
    "userTypeId": userTypeId,
    "chatID": chatID,
    "orderId": orderId,
    "offerId": offerId,
    "workshopId": workshopId,
    "userId": userId,
    "routeName": routeName,
  };
}
