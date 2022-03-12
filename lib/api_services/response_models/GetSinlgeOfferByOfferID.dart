// To parse this JSON data, do
//
//     final getSinlgeOfferByOfferId = getSinlgeOfferByOfferIdFromJson(jsonString);

import 'dart:convert';

GetSinlgeOfferByOfferId getSinlgeOfferByOfferIdFromJson(String str) => GetSinlgeOfferByOfferId.fromJson(json.decode(str));

String getSinlgeOfferByOfferIdToJson(GetSinlgeOfferByOfferId data) => json.encode(data.toJson());

class GetSinlgeOfferByOfferId {
  GetSinlgeOfferByOfferId({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory GetSinlgeOfferByOfferId.fromJson(Map<String, dynamic> json) => GetSinlgeOfferByOfferId(
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.offerId,
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
  });

  dynamic offerId;
  dynamic price;
  dynamic timeInDays;
  String offerDate;
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    offerId: json["offerId"],
    price: json["price"],
    timeInDays: json["timeInDays"],
    offerDate: json["offerDate"],
    isNegotiable: json["isNegotiable"],
    isAccepted: json["isAccepted"],
    isRejected: json["isRejected"],
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
    "price": price,
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
