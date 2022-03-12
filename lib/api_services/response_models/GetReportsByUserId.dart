// To parse this JSON data, do
//
//     final getReportsByUserId = getReportsByUserIdFromJson(jsonString);

import 'dart:convert';

GetReportsByUserId getReportsByUserIdFromJson(String str) => GetReportsByUserId.fromJson(json.decode(str));

String getReportsByUserIdToJson(GetReportsByUserId data) => json.encode(data.toJson());

class GetReportsByUserId {
  GetReportsByUserId({
    this.message,
    this.result,
  });

  String message;
  List<Result> result;

  factory GetReportsByUserId.fromJson(Map<String, dynamic> json) => GetReportsByUserId(
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
    this.reportId,
    this.comment,
    this.creationDate,
    this.attachments,
    this.issues,
    this.technician,
    this.client,
    this.clientAddress,
    this.carType,
  });

  dynamic reportId;
  String clientAddress;
  String comment;
  DateTime creationDate;
  List<dynamic> attachments;
  List<Issue> issues;
  Client technician;
  Client client;
  String carType;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    reportId: json["reportId"],
    clientAddress: json["clientAddress"],
    comment: json["comment"],
    creationDate: DateTime.parse(json["creationDate"]),
    attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
    issues: List<Issue>.from(json["issues"].map((x) => Issue.fromJson(x))),
    technician: Client.fromJson(json["technician"]),
    client: Client.fromJson(json["client"]),
    carType: json["carType"],
  );

  Map<String, dynamic> toJson() => {
    "reportId": reportId,
    "comment": comment,
    "clientAddress": clientAddress,
    "creationDate": creationDate.toIso8601String(),
    "attachments": List<dynamic>.from(attachments.map((x) => x)),
    "issues": List<dynamic>.from(issues.map((x) => x.toJson())),
    "technician": technician.toJson(),
    "client": client.toJson(),
    "carType": carType,
  };
}

class Client {
  Client({
    this.userTypeId,
    this.name,
    this.created,
    this.isActive,
    this.verificationToken,
    this.resetToken,
    this.resetTokenExpires,
    this.fcmToken,
    this.industryId,
    this.industry,
    this.city,
    this.cityId,
    this.address,
    this.latitude,
    this.longitude,
    this.vatEnabled,
    this.vatNumber,
    this.vatValue,
    this.musanPercentage,
    this.isAvailable,
    this.allowNotifications,
    this.hiddenOrdersList,
    this.unpaidMusanFees,
    this.nextScheduledWithdrawal,
    this.workShopInfo,
    this.userCardInfo,
    this.userSetting,
    this.report,
    this.carPickupTypeId,
    this.carPickupType,
    this.bankDetailId,
    this.bankDetails,
    this.userRoles,
    this.userLogins,
    this.userClaims,
    this.userTokens,
    this.refreshTokens,
    this.announcements,
    this.services,
    this.orders,
    this.workShopImages,
    this.senderChats,
    this.receiverChats,
    this.userPaymentMethods,
    this.notifications,
    this.questions,
    this.answers,
    this.discountOffers,
    this.carPickupOrders,
    this.paymentDetails,
    this.workshopSpecializations,
    this.withdrawalRequests,
    this.commercialRegistration,
    this.displayPicture,
    this.id,
    this.userName,
    this.normalizedUserName,
    this.email,
    this.normalizedEmail,
    this.emailConfirmed,
    this.passwordHash,
    this.securityStamp,
    this.concurrencyStamp,
    this.phoneNumber,
    this.phoneNumberConfirmed,
    this.twoFactorEnabled,
    this.lockoutEnd,
    this.lockoutEnabled,
    this.accessFailedCount,
  });

  dynamic userTypeId;
  String name;
  DateTime created;
  bool isActive;
  String verificationToken;
  dynamic resetToken;
  dynamic resetTokenExpires;
  String fcmToken;
  dynamic industryId;
  dynamic industry;
  dynamic city;
  dynamic cityId;
  String address;
  dynamic latitude;
  dynamic longitude;
  bool vatEnabled;
  dynamic vatNumber;
  dynamic vatValue;
  dynamic musanPercentage;
  bool isAvailable;
  bool allowNotifications;
  dynamic hiddenOrdersList;
  dynamic unpaidMusanFees;
  DateTime nextScheduledWithdrawal;
  dynamic workShopInfo;
  dynamic userCardInfo;
  dynamic userSetting;
  dynamic report;
  dynamic carPickupTypeId;
  dynamic carPickupType;
  dynamic bankDetailId;
  dynamic bankDetails;
  List<dynamic> userRoles;
  List<dynamic> userLogins;
  List<dynamic> userClaims;
  List<dynamic> userTokens;
  List<dynamic> refreshTokens;
  List<dynamic> announcements;
  List<dynamic> services;
  List<dynamic> orders;
  List<dynamic> workShopImages;
  List<dynamic> senderChats;
  List<dynamic> receiverChats;
  List<dynamic> userPaymentMethods;
  List<dynamic> notifications;
  List<dynamic> questions;
  List<dynamic> answers;
  dynamic discountOffers;
  List<dynamic> carPickupOrders;
  dynamic paymentDetails;
  dynamic workshopSpecializations;
  dynamic withdrawalRequests;
  dynamic commercialRegistration;
  dynamic displayPicture;
  dynamic id;
  String userName;
  String normalizedUserName;
  String email;
  String normalizedEmail;
  bool emailConfirmed;
  String passwordHash;
  String securityStamp;
  String concurrencyStamp;
  String phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  dynamic lockoutEnd;
  bool lockoutEnabled;
  dynamic accessFailedCount;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    userTypeId: json["userTypeId"],
    name: json["name"],
    created: DateTime.parse(json["created"]),
    isActive: json["isActive"],
    verificationToken: json["verificationToken"],
    resetToken: json["resetToken"],
    resetTokenExpires: json["resetTokenExpires"],
    fcmToken: json["fcmToken"] == null ? null : json["fcmToken"],
    industryId: json["industryId"],
    industry: json["industry"],
    city: json["city"],
    cityId: json["cityId"],
    address: json["address"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    vatEnabled: json["vatEnabled"],
    vatNumber: json["vatNumber"],
    vatValue: json["vatValue"],
    musanPercentage: json["musanPercentage"],
    isAvailable: json["isAvailable"],
    allowNotifications: json["allowNotifications"],
    hiddenOrdersList: json["hiddenOrdersList"],
    unpaidMusanFees: json["unpaidMusanFees"],
    nextScheduledWithdrawal: DateTime.parse(json["nextScheduledWithdrawal"]),
    workShopInfo: json["workShopInfo"],
    userCardInfo: json["userCardInfo"],
    userSetting: json["userSetting"],
    report: json["report"],
    carPickupTypeId: json["carPickupTypeId"],
    carPickupType: json["carPickupType"],
    bankDetailId: json["bankDetailId"],
    bankDetails: json["bankDetails"],
    userRoles: List<dynamic>.from(json["userRoles"].map((x) => x)),
    userLogins: List<dynamic>.from(json["userLogins"].map((x) => x)),
    userClaims: List<dynamic>.from(json["userClaims"].map((x) => x)),
    userTokens: List<dynamic>.from(json["userTokens"].map((x) => x)),
    refreshTokens: List<dynamic>.from(json["refreshTokens"].map((x) => x)),
    announcements: List<dynamic>.from(json["announcements"].map((x) => x)),
    services: List<dynamic>.from(json["services"].map((x) => x)),
    orders: List<dynamic>.from(json["orders"].map((x) => x)),
    workShopImages: List<dynamic>.from(json["workShopImages"].map((x) => x)),
    senderChats: List<dynamic>.from(json["senderChats"].map((x) => x)),
    receiverChats: List<dynamic>.from(json["receiverChats"].map((x) => x)),
    userPaymentMethods: List<dynamic>.from(json["userPaymentMethods"].map((x) => x)),
    notifications: List<dynamic>.from(json["notifications"].map((x) => x)),
    questions: List<dynamic>.from(json["questions"].map((x) => x)),
    answers: List<dynamic>.from(json["answers"].map((x) => x)),
    discountOffers: json["discountOffers"],
    carPickupOrders: List<dynamic>.from(json["carPickupOrders"].map((x) => x)),
    paymentDetails: json["paymentDetails"],
    workshopSpecializations: json["workshopSpecializations"],
    withdrawalRequests: json["withdrawalRequests"],
    commercialRegistration: json["commercialRegistration"],
    displayPicture: json["displayPicture"],
    id: json["id"],
    userName: json["userName"],
    normalizedUserName: json["normalizedUserName"],
    email: json["email"],
    normalizedEmail: json["normalizedEmail"],
    emailConfirmed: json["emailConfirmed"],
    passwordHash: json["passwordHash"],
    securityStamp: json["securityStamp"],
    concurrencyStamp: json["concurrencyStamp"],
    phoneNumber: json["phoneNumber"],
    phoneNumberConfirmed: json["phoneNumberConfirmed"],
    twoFactorEnabled: json["twoFactorEnabled"],
    lockoutEnd: json["lockoutEnd"],
    lockoutEnabled: json["lockoutEnabled"],
    accessFailedCount: json["accessFailedCount"],
  );

  Map<String, dynamic> toJson() => {
    "userTypeId": userTypeId,
    "name": name,
    "created": created.toIso8601String(),
    "isActive": isActive,
    "verificationToken": verificationToken,
    "resetToken": resetToken,
    "resetTokenExpires": resetTokenExpires,
    "fcmToken": fcmToken == null ? null : fcmToken,
    "industryId": industryId,
    "industry": industry,
    "city": city,
    "cityId": cityId,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "vatEnabled": vatEnabled,
    "vatNumber": vatNumber,
    "vatValue": vatValue,
    "musanPercentage": musanPercentage,
    "isAvailable": isAvailable,
    "allowNotifications": allowNotifications,
    "hiddenOrdersList": hiddenOrdersList,
    "unpaidMusanFees": unpaidMusanFees,
    "nextScheduledWithdrawal": nextScheduledWithdrawal.toIso8601String(),
    "workShopInfo": workShopInfo,
    "userCardInfo": userCardInfo,
    "userSetting": userSetting,
    "report": report,
    "carPickupTypeId": carPickupTypeId,
    "carPickupType": carPickupType,
    "bankDetailId": bankDetailId,
    "bankDetails": bankDetails,
    "userRoles": List<dynamic>.from(userRoles.map((x) => x)),
    "userLogins": List<dynamic>.from(userLogins.map((x) => x)),
    "userClaims": List<dynamic>.from(userClaims.map((x) => x)),
    "userTokens": List<dynamic>.from(userTokens.map((x) => x)),
    "refreshTokens": List<dynamic>.from(refreshTokens.map((x) => x)),
    "announcements": List<dynamic>.from(announcements.map((x) => x)),
    "services": List<dynamic>.from(services.map((x) => x)),
    "orders": List<dynamic>.from(orders.map((x) => x)),
    "workShopImages": List<dynamic>.from(workShopImages.map((x) => x)),
    "senderChats": List<dynamic>.from(senderChats.map((x) => x)),
    "receiverChats": List<dynamic>.from(receiverChats.map((x) => x)),
    "userPaymentMethods": List<dynamic>.from(userPaymentMethods.map((x) => x)),
    "notifications": List<dynamic>.from(notifications.map((x) => x)),
    "questions": List<dynamic>.from(questions.map((x) => x)),
    "answers": List<dynamic>.from(answers.map((x) => x)),
    "discountOffers": discountOffers,
    "carPickupOrders": List<dynamic>.from(carPickupOrders.map((x) => x)),
    "paymentDetails": paymentDetails,
    "workshopSpecializations": workshopSpecializations,
    "withdrawalRequests": withdrawalRequests,
    "commercialRegistration": commercialRegistration,
    "displayPicture": displayPicture,
    "id": id,
    "userName": userName,
    "normalizedUserName": normalizedUserName,
    "email": email,
    "normalizedEmail": normalizedEmail,
    "emailConfirmed": emailConfirmed,
    "passwordHash": passwordHash,
    "securityStamp": securityStamp,
    "concurrencyStamp": concurrencyStamp,
    "phoneNumber": phoneNumber,
    "phoneNumberConfirmed": phoneNumberConfirmed,
    "twoFactorEnabled": twoFactorEnabled,
    "lockoutEnd": lockoutEnd,
    "lockoutEnabled": lockoutEnabled,
    "accessFailedCount": accessFailedCount,
  };
}

class Issue {
  Issue({
    this.name,
  });

  String name;

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
