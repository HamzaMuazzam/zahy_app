// To parse this JSON data, do
//
//     final getCompletedOrInProgressOrderByUserId = getCompletedOrInProgressOrderByUserIdFromJson(jsonString);

import 'dart:convert';

GetCompletedOrInProgressOrderByUserId getCompletedOrInProgressOrderByUserIdFromJson(String str) => GetCompletedOrInProgressOrderByUserId.fromJson(json.decode(str));

String getCompletedOrInProgressOrderByUserIdToJson(GetCompletedOrInProgressOrderByUserId data) => json.encode(data.toJson());

class GetCompletedOrInProgressOrderByUserId {
  GetCompletedOrInProgressOrderByUserId({
    this.message,
    this.result,
  });

  String message;
  List<Result> result;

  factory GetCompletedOrInProgressOrderByUserId.fromJson(Map<String, dynamic> json) => GetCompletedOrInProgressOrderByUserId(
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
    this.googleRatings,
    this.addressLocation,
    this.workshopAddress,
    this.workshopRating,
    this.carInformationId,
    this.carName,
    this.displayImage,
    this.comments,
    this.completionDate,
    this.creationDate,
    this.estimatedPrice,
    this.expectedCompletionDate,
    this.orderNumber,
    this.isElite,
    this.orderRating,
    this.orderStatusId,
    this.workshopId,
    this.clientReview,
    this.musanFee,
    this.vatCost,
    this.vatPercent,
    this.isCash,
    this.pendingEditedCost,
    this.pendingEditedDays,
    this.carPickupOrderId,
    this.carPickupOrderAmount,
    this.isCarPickupPaid,
    this.carPickUpId,
    this.technicianComments,
    this.workshopLocation,
    this.phoneNumber,
    this.workshopPhoneNumber,
    this.workCost,
    this.totalCost,
    this.editsPending,
    this.downPayment,
    this.isDownPaymentRequested,
    this.isDownPaymentCompleted,
    this.isTechnicianOrder,
    this.isFinalPaymentCleared,
    this.orderSteps,
    this.isCompleted,
    this.isCarPickupOrdered,
    this.isCarPickupComplete,
    this.carType,
    this.clientName,
    this.distance,
    this.timeInDays,
    this.workshopName,
    this.orderAttachments,
    this.orderParts,
    this.userId,
    this.faults,
    this.offers,
  });

  dynamic orderId;
  dynamic googleRatings;
  dynamic workshopRating;
  String addressLocation;
  dynamic carInformationId;
  String carName;
  String displayImage;
  String comments;
  String workshopAddress;
  dynamic completionDate;
  String creationDate;
  dynamic estimatedPrice;
  String expectedCompletionDate;
  String orderNumber;
  dynamic orderRating;
  dynamic orderStatusId;
  dynamic workshopId;
  String clientReview;
  dynamic musanFee;
  dynamic vatCost;
  dynamic vatPercent;
  bool isCash;
  bool isElite;
  dynamic pendingEditedCost;
  dynamic pendingEditedDays;
  dynamic carPickupOrderId;
  dynamic carPickupOrderAmount;
  bool isCarPickupPaid;
  dynamic carPickUpId;
  String technicianComments;
  WorkshopLocation workshopLocation;
  String phoneNumber;
  String workshopPhoneNumber;
  dynamic workCost;
  dynamic totalCost;
  bool editsPending;
  dynamic downPayment;
  bool isDownPaymentRequested;
  bool isDownPaymentCompleted;
  bool isTechnicianOrder;
  bool isFinalPaymentCleared;
  List<OrderStep> orderSteps;
  bool isCompleted;
  bool isCarPickupOrdered;
  bool isCarPickupComplete;
  String carType;
  String clientName;
  dynamic distance;
  dynamic timeInDays;
  WorkshopName workshopName;
  List<OrderAttachment> orderAttachments;
  List<OrderPart> orderParts;
  dynamic userId;
  List<Fault> faults;
  List<Offer> offers;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    orderId: json["orderId"],
    googleRatings: json["googleRatings"],
    addressLocation: json["addressLocation"],
    isElite: json["isElite"],
    carInformationId: json["carInformationId"],
    workshopRating: json["workshopRating"],
    workshopAddress: json["workshopAddress"],
    displayImage: json["displayImage"],
    carName: json["carName"],
    comments: json["comments"],
    completionDate: json["completionDate"],
    creationDate: json["creationDate"],
    estimatedPrice: json["estimatedPrice"],
    expectedCompletionDate: json["expectedCompletionDate"],
    orderNumber: json["orderNumber"],
    orderRating: json["orderRating"] == null ? null : json["orderRating"],
    orderStatusId: json["orderStatusId"],
    workshopId: json["workshopId"],
    clientReview: json["clientReview"] == null ? null : json["clientReview"],
    musanFee: json["musanFee"],
    vatCost: json["vatCost"]??json["vatValue"],
    vatPercent: json["vatPercent"],
    isCash: json["isCash"],
    pendingEditedCost: json["pendingEditedCost"],
    pendingEditedDays: json["pendingEditedDays"],
    carPickupOrderId: json["carPickupOrderId"],
    carPickupOrderAmount: json["carPickupOrderAmount"],
    isCarPickupPaid: json["isCarPickupPaid"],
    carPickUpId: json["carPickUpId"] == null ? null : json["carPickUpId"],
    technicianComments: json["technicianComments"] == null ? null : json["technicianComments"],
    workshopLocation: WorkshopLocation.fromJson(json["workshopLocation"]),
    phoneNumber: json["phoneNumber"],
    workshopPhoneNumber: json["workshopPhoneNumber"],
    workCost: json["workCost"],
    totalCost: json["totalCost"],
    editsPending: json["editsPending"],
    downPayment: json["downPayment"],
    isDownPaymentRequested: json["isDownPaymentRequested"],
    isDownPaymentCompleted: json["isDownPaymentCompleted"],
    isTechnicianOrder: json["isTechnicianOrder"],
    isFinalPaymentCleared: json["isFinalPaymentCleared"],
    orderSteps: List<OrderStep>.from(json["orderSteps"].map((x) => OrderStep.fromJson(x))),
    isCompleted: json["isCompleted"],
    isCarPickupOrdered: json["isCarPickupOrdered"],
    isCarPickupComplete: json["isCarPickupComplete"],
    carType: json["carType"],
    clientName: json["clientName"],
    distance: json["distance"],
    timeInDays: json["timeInDays"],
    workshopName: WorkshopName.fromJson(json["workshopName"]),
    orderAttachments: List<OrderAttachment>.from(json["orderAttachments"].map((x) => OrderAttachment.fromJson(x))),
    orderParts: List<OrderPart>.from(json["orderParts"].map((x) => OrderPart.fromJson(x))),
    userId: json["userId"],
    faults: List<Fault>.from(json["faults"].map((x) => Fault.fromJson(x))),
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "googleRatings": googleRatings,
    "workshopRating": workshopRating,
    "addressLocation": addressLocation,
    "isElite": isElite,
    "workshopAddress": workshopAddress,
    "carInformationId": carInformationId,
    "carName": carName,
    "comments": comments,
    "displayImage": displayImage,
    "completionDate": completionDate,
    "creationDate": creationDate,
    "estimatedPrice": estimatedPrice,
    "expectedCompletionDate": expectedCompletionDate,
    "orderNumber": orderNumber,
    "orderRating": orderRating == null ? null : orderRating,
    "orderStatusId": orderStatusId,
    "workshopId": workshopId,
    "clientReview": clientReview == null ? null : clientReview,
    "musanFee": musanFee,
    "vatCost": vatCost,
    "vatPercent": vatPercent,
    "isCash": isCash,
    "pendingEditedCost": pendingEditedCost,
    "pendingEditedDays": pendingEditedDays,
    "carPickupOrderId": carPickupOrderId,
    "carPickupOrderAmount": carPickupOrderAmount,
    "isCarPickupPaid": isCarPickupPaid,
    "carPickUpId": carPickUpId == null ? null : carPickUpId,
    "technicianComments": technicianComments == null ? null : technicianComments,
    "workshopLocation": workshopLocation.toJson(),
    "phoneNumber": phoneNumber,
    "workshopPhoneNumber": workshopPhoneNumber,
    "workCost": workCost,
    "totalCost": totalCost,
    "editsPending": editsPending,
    "downPayment": downPayment,
    "isDownPaymentRequested": isDownPaymentRequested,
    "isDownPaymentCompleted": isDownPaymentCompleted,
    "isTechnicianOrder": isTechnicianOrder,
    "isFinalPaymentCleared": isFinalPaymentCleared,
    "orderSteps": List<dynamic>.from(orderSteps.map((x) => x.toJson())),
    "isCompleted": isCompleted,
    "isCarPickupOrdered": isCarPickupOrdered,
    "isCarPickupComplete": isCarPickupComplete,
    "carType": carType,
    "clientName": clientName,
    "distance": distance,
    "timeInDays": timeInDays,
    "workshopName": workshopName.toJson(),
    "orderAttachments": List<dynamic>.from(orderAttachments.map((x) => x.toJson())),
    "orderParts": List<dynamic>.from(orderParts.map((x) => x.toJson())),
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
    this.price,
    this.timeInDays,
    this.offerDate,
    this.isNegotiable,
    this.distance,
  });

  dynamic offerId;
  dynamic price;
  dynamic timeInDays;
  String offerDate;
  bool isNegotiable;
  String distance;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    offerId: json["offerId"],
    price: json["price"],
    timeInDays: json["timeInDays"],
    offerDate: json["offerDate"],
    isNegotiable: json["isNegotiable"],
    distance: json["distance"] == null ? null : json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "offerId": offerId,
    "price": price,
    "timeInDays": timeInDays,
    "offerDate": offerDate,
    "isNegotiable": isNegotiable,
    "distance": distance == null ? null : distance,
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

class OrderPart {
  OrderPart({
    this.orderPartId,
    this.isPaid,
    this.partName,
    this.partCost,
    this.isApproved,
    this.pendingApproval,
    this.pictures,
  });

  dynamic orderPartId;
  bool isPaid;
  String partName;
  dynamic partCost;
  bool isApproved;
  bool pendingApproval;
  List<Picture> pictures;

  factory OrderPart.fromJson(Map<String, dynamic> json) => OrderPart(
    orderPartId: json["orderPartId"],
    isPaid: json["isPaid"],
    partName: json["partName"],
    partCost: json["partCost"],
    isApproved: json["isApproved"],
    pendingApproval: json["pendingApproval"],
    pictures: List<Picture>.from(json["pictures"].map((x) => Picture.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orderPartId": orderPartId,
    "isPaid": isPaid,
    "partName": partName,
    "partCost": partCost,
    "isApproved": isApproved,
    "pendingApproval": pendingApproval,
    "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
  };
}

class Picture {
  Picture({
    this.imageUrl,
  });

  String imageUrl;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    imageUrl: json["imageURL"],
  );

  Map<String, dynamic> toJson() => {
    "imageURL": imageUrl,
  };
}

class OrderStep {
  OrderStep({
    this.title,
    this.orderStepStatus,
  });

  String title;
  dynamic orderStepStatus;

  factory OrderStep.fromJson(Map<String, dynamic> json) => OrderStep(
    title: json["title"],
    orderStepStatus: json["orderStepStatus"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "orderStepStatus": orderStepStatus,
  };
}

class WorkshopLocation {
  WorkshopLocation({
    this.longitude,
    this.latitude,
  });

  dynamic longitude;
  dynamic latitude;

  factory WorkshopLocation.fromJson(Map<String, dynamic> json) => WorkshopLocation(
    longitude: json["longitude"].toDouble(),
    latitude: json["latitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "longitude": longitude,
    "latitude": latitude,
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


GetSingleOrderByUserId getSingleOrderByUserIdFromJson(String str) => GetSingleOrderByUserId.fromJson(json.decode(str));

String getSingleOrderByUserIdToJson(GetSingleOrderByUserId data) => json.encode(data.toJson());

class GetSingleOrderByUserId {
  GetSingleOrderByUserId({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory GetSingleOrderByUserId.fromJson(Map<String, dynamic> json) => GetSingleOrderByUserId(
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": result.toJson(),
  };
}