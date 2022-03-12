// To parse this JSON data, do
//
//     final getNotification = getNotificationFromJson(jsonString);

import 'dart:convert';

GetNotification getNotificationFromJson(String str) => GetNotification.fromJson(json.decode(str));

String getNotificationToJson(GetNotification data) => json.encode(data.toJson());

class GetNotification {
  GetNotification({
    this.message,
    this.result,
  });

  String message;
  List<Result> result;

  factory GetNotification.fromJson(Map<String, dynamic> json) => GetNotification(
    message: json["message"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.title,
    this.message,
    this.notificationTime,
    this.userId,
    this.isViewed,
    this.expiryDate,
  });

  int id;
  String title;
  String message;
  String notificationTime;
  int userId;
  bool isViewed;
  String expiryDate;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    title: json["title"],
    message: json["message"],
    notificationTime: json["notificationTime"],
    userId: json["userId"],
    isViewed: json["isViewed"],
    expiryDate: json["expiryDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "message": message,
    "notificationTime": notificationTime,
    "userId": userId,
    "isViewed": isViewed,
    "expiryDate": expiryDate,
  };
}
