// To parse this JSON data, do
//
//     final getDiscountOffers = getDiscountOffersFromJson(jsonString);

import 'dart:convert';

GetDiscountOffers getDiscountOffersFromJson(String str) => GetDiscountOffers.fromJson(json.decode(str));

String getDiscountOffersToJson(GetDiscountOffers data) => json.encode(data.toJson());

class GetDiscountOffers {
  GetDiscountOffers({
    this.message,
    this.result,
  });

  String message;
  List<Result> result;

  factory GetDiscountOffers.fromJson(Map<String, dynamic> json) => GetDiscountOffers(
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
    this.discountOfferId,
    this.workshopId,
    this.discountValue,
    this.isActive,
    this.expiryDate,
    this.isApproved,
    this.isPercentDiscount,
    this.offerDescription,
    this.offerName,
    this.offerTitle,
    this.views,
    this.workshop,
    this.discountCostPerDay,
  });

  int discountOfferId;
  dynamic workshopId;
  double discountValue;
  bool isActive;
  String expiryDate;
  bool isApproved;
  bool isPercentDiscount;
  String offerDescription;
  String offerName;
  String offerTitle;
  dynamic views;
  Workshop workshop;
  dynamic discountCostPerDay;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    discountOfferId: json["discountOfferId"],
    workshopId: json["workshopId"],
    discountValue: json["discountValue"],
    isActive: json["isActive"],
    expiryDate: json["expiryDate"],
    isApproved: json["isApproved"],
    isPercentDiscount: json["isPercentDiscount"],
    offerDescription: json["offerDescription"],
    offerName: json["offerName"],
    offerTitle: json["offerTitle"] == null ? null : json["offerTitle"],
    views: json["views"],
    workshop: Workshop.fromJson(json["workshop"]),
    discountCostPerDay: json["discountCostPerDay"],
  );

  Map<String, dynamic> toJson() => {
    "discountOfferId": discountOfferId,
    "workshopId": workshopId,
    "discountValue": discountValue,
    "isActive": isActive,
    "expiryDate": expiryDate,
    "isApproved": isApproved,
    "isPercentDiscount": isPercentDiscount,
    "offerDescription": offerDescription,
    "offerName": offerName,
    "offerTitle": offerTitle == null ? null : offerTitle,
    "views": views,
    "workshop": workshop.toJson(),
    "discountCostPerDay": discountCostPerDay,
  };
}

class Workshop {
  Workshop({
    this.name,
    this.rating,
    this.displayPicture,
  });

  String name;
  dynamic rating;
  String displayPicture;

  factory Workshop.fromJson(Map<String, dynamic> json) => Workshop(
    name: json["name"],
    rating: json["rating"],
    displayPicture: json["displayPicture"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "rating": rating,
    "displayPicture": displayPicture,
  };
}
