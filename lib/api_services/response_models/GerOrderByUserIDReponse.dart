// To parse this JSON data, do
//
//     final getFreshOrderByUserIdReponse = getFreshOrderByUserIdReponseFromJson(jsonString);

import 'dart:convert';

GetFreshOrderByUserIdReponse getFreshOrderByUserIdReponseFromJson(String str) => GetFreshOrderByUserIdReponse.fromJson(json.decode(str));

String getFreshOrderByUserIdReponseToJson(GetFreshOrderByUserIdReponse data) => json.encode(data.toJson());

class GetFreshOrderByUserIdReponse {
  GetFreshOrderByUserIdReponse({
    this.message,
    this.result,
  });

  String message;
  List<Result> result=[];

  factory GetFreshOrderByUserIdReponse.fromJson(Map<String, dynamic> json) => GetFreshOrderByUserIdReponse(
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
    this.orderId,
    this.addressLocation,
    this.carInformationId,
    this.carName,
    this.comments,
    this.completionDate,
    this.creationDate,
    this.estimatedPrice,
    this.expectedCompletionDate,
    this.orderNumber,
    this.orderRating,
    this.orderStatusId,
    this.workshopId,
    this.phoneNumber,
    this.averagePrice,
    this.totalCost,
    this.editsPending,
    this.downPayment,
    this.isDownPaymentRequested,
    this.isDownPaymentCompleted,
    this.isCarPickupOrdered,
    this.isCarPickupComplete,
    this.isTechnicianOrder,
    this.isFinalPaymentCleared,
    this.orderSteps,
    this.distance,
    this.workshopName,
    this.timeInDays,
    this.orderParts,
    this.orderAttachments,
    this.userId,
    this.faults,
    this.offers,
  });

  dynamic orderId;
  String addressLocation;
  dynamic carInformationId;
  String carName;
  String comments;
  dynamic completionDate;
  String creationDate;
  dynamic estimatedPrice;
  String expectedCompletionDate;
  String orderNumber;
  dynamic orderRating;
  dynamic orderStatusId;
  dynamic workshopId;
  String phoneNumber;
  dynamic averagePrice;
  dynamic totalCost;
  bool editsPending;
  dynamic downPayment;
  bool isDownPaymentRequested;
  bool isDownPaymentCompleted;
  bool isCarPickupOrdered;
  bool isCarPickupComplete;
  bool isTechnicianOrder;
  bool isFinalPaymentCleared;
  List<dynamic> orderSteps;
  dynamic distance;
  WorkshopName workshopName;
  dynamic timeInDays;
  List<dynamic> orderParts;
  List<OrderAttachment> orderAttachments;
  dynamic userId;
  List<Fault> faults;
  List<Offer> offers;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    orderId: json["orderId"],
    addressLocation: json["addressLocation"],
    carInformationId: json["carInformationId"],
    carName: json["carName"],
    comments: json["comments"],
    completionDate: json["completionDate"],
    creationDate: json["creationDate"],
    estimatedPrice: json["estimatedPrice"],
    expectedCompletionDate: json["expectedCompletionDate"],
    orderNumber: json["orderNumber"],
    orderRating: json["orderRating"],
    orderStatusId: json["orderStatusId"],
    workshopId: json["workshopId"],
    phoneNumber: json["phoneNumber"],
    averagePrice: json["averagePrice"],
    totalCost: json["totalCost"],
    editsPending: json["editsPending"],
    downPayment: json["downPayment"],
    isDownPaymentRequested: json["isDownPaymentRequested"],
    isDownPaymentCompleted: json["isDownPaymentCompleted"],
    isCarPickupOrdered: json["isCarPickupOrdered"],
    isCarPickupComplete: json["isCarPickupComplete"],
    isTechnicianOrder: json["isTechnicianOrder"],
    isFinalPaymentCleared: json["isFinalPaymentCleared"],
    orderSteps: List<dynamic>.from(json["orderSteps"].map((x) => x)),
    distance: json["distance"],
    workshopName: WorkshopName.fromJson(json["workshopName"]),
    timeInDays: json["timeInDays"],
    orderParts: List<dynamic>.from(json["orderParts"].map((x) => x)),
    orderAttachments: List<OrderAttachment>.from(json["orderAttachments"].map((x) => OrderAttachment.fromJson(x))),
    userId: json["userId"],
    faults: List<Fault>.from(json["faults"].map((x) => Fault.fromJson(x))),
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "addressLocation": addressLocation,
    "carInformationId": carInformationId,
    "carName": carName,
    "comments": comments,
    "completionDate": completionDate,
    "creationDate": creationDate,
    "estimatedPrice": estimatedPrice,
    "expectedCompletionDate": expectedCompletionDate,
    "orderNumber": orderNumber,
    "orderAttachments": List<dynamic>.from(orderAttachments.map((x) => x.toJson())),
    "orderRating": orderRating,
    "orderStatusId": orderStatusId,
    "workshopId": workshopId,
    "phoneNumber": phoneNumber,
    "averagePrice": averagePrice,
    "totalCost": totalCost,
    "editsPending": editsPending,
    "downPayment": downPayment,
    "isDownPaymentRequested": isDownPaymentRequested,
    "isDownPaymentCompleted": isDownPaymentCompleted,
    "isCarPickupOrdered": isCarPickupOrdered,
    "isCarPickupComplete": isCarPickupComplete,
    "isTechnicianOrder": isTechnicianOrder,
    "isFinalPaymentCleared": isFinalPaymentCleared,
    "orderSteps": List<dynamic>.from(orderSteps.map((x) => x)),
    "distance": distance,
    "workshopName": workshopName.toJson(),
    "timeInDays": timeInDays,
    "orderParts": List<dynamic>.from(orderParts.map((x) => x)),
    "userId": userId,
    "faults": List<dynamic>.from(faults.map((x) => x.toJson())),
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
  };
}

class Fault {
  Fault({
    this.faultId,
    this.name,
  });

  dynamic faultId;
  String name;

  factory Fault.fromJson(Map<String, dynamic> json) => Fault(
    faultId: json["faultId"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "faultId": faultId,
    "name": name,
  };
}

class Offer {
  Offer({
    this.offerId,
    this.googleRatings,
    this.isElite,
    this.workShopContact,
    this.price,
    this.timeInDays,
    this.offerDate,
    this.isNegotiable,
    this.isAccepted,
    this.isRejected,
    this.workshopName,
    this.workshopRating,
    this.customerOfferedPrice,
    this.negotiationPendingCustomer,
    this.negotiationPendingWorkshop,
    this.views,
    this.warrantyProvided,
    this.workshopId,
    this.offerStatus,
    this.distance,
  });

  dynamic offerId;
  dynamic isElite;
  dynamic googleRatings;
  dynamic price;
  dynamic timeInDays;
  String offerDate;
  String workShopContact;
  String distance;
  bool isNegotiable;
  bool isAccepted;
  bool isRejected;
  String workshopName;
  dynamic workshopRating;
  dynamic customerOfferedPrice;
  bool negotiationPendingCustomer;
  bool negotiationPendingWorkshop;
  dynamic views;
  bool warrantyProvided;
  dynamic workshopId;
  dynamic offerStatus;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    offerId: json["offerId"],
    distance: json["distance"],
    googleRatings: json["googleRatings"],
    workShopContact: json["workShopContact"],
    price: json["price"],
    timeInDays: json["timeInDays"],
    offerDate: json["offerDate"],
    isNegotiable: json["isNegotiable"],
    isAccepted: json["isAccepted"],
    isRejected: json["isRejected"],
    isElite: json["isElite"],
    workshopName: json["workshopName"],
    workshopRating: json["workshopRating"],
    customerOfferedPrice: json["customerOfferedPrice"],
    negotiationPendingCustomer: json["negotiationPendingCustomer"],
    negotiationPendingWorkshop: json["negotiationPendingWorkshop"],
    views: json["views"],
    warrantyProvided: json["warrantyProvided"],
    workshopId: json["workshopId"],
    offerStatus: json["offerStatus"],
  );

  Map<String, dynamic> toJson() => {
    "offerId": offerId,
    "googleRatings": googleRatings,
    "price": price,
    "isElite": isElite,
    "distance": distance,
    "workShopContact": workShopContact,
    "timeInDays": timeInDays,
    "offerDate": offerDate,
    "isNegotiable": isNegotiable,
    "isAccepted": isAccepted,
    "isRejected": isRejected,
    "workshopName": workshopName,
    "workshopRating": workshopRating,
    "customerOfferedPrice": customerOfferedPrice,
    "negotiationPendingCustomer": negotiationPendingCustomer,
    "negotiationPendingWorkshop": negotiationPendingWorkshop,
    "views": views,
    "warrantyProvided": warrantyProvided,
    "workshopId": workshopId,
    "offerStatus": offerStatus,
  };
}

class WorkshopName {
  WorkshopName({
    this.name,
  });

  String name;

  factory WorkshopName.fromJson(Map<String, dynamic> json) => WorkshopName(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}


class OrderAttachment {
  OrderAttachment({
    this.attachmentLink,
  });

  String attachmentLink;

  factory OrderAttachment.fromJson(Map<String, dynamic> json) => OrderAttachment(
    attachmentLink: json["attachmentLink"],
  );

  Map<String, dynamic> toJson() => {
    "attachmentLink": attachmentLink,
  };
}
