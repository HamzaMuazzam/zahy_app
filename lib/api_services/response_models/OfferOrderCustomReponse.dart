// // To parse this JSON data, do
// //
// //     final offerOrderCustomReponse = offerOrderCustomReponseFromJson(jsonString);
//
// import 'dart:convert';
//
// OfferOrderCustomReponse offerOrderCustomReponseFromJson(String str) => OfferOrderCustomReponse.fromJson(json.decode(str));
//
// String offerOrderCustomReponseToJson(OfferOrderCustomReponse data) => json.encode(data.toJson());
//
// class OfferOrderCustomReponse {
//   OfferOrderCustomReponse({
//     this.offerCustomObject,
//     this.orderCustomObject,
//   });
//
//   OfferCustomObject offerCustomObject;
//   OrderCustomObject orderCustomObject;
//
//   factory OfferOrderCustomReponse.fromJson(Map<String, dynamic> json) => OfferOrderCustomReponse(
//     offerCustomObject: OfferCustomObject.fromJson(json["OfferCustomObject"]),
//     orderCustomObject: OrderCustomObject.fromJson(json["OrderCustomObject"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "OfferCustomObject": offerCustomObject.toJson(),
//     "OrderCustomObject": orderCustomObject.toJson(),
//   };
// }
//
// class OfferCustomObject {
//   OfferCustomObject({
//     this.message,
//     this.result,
//   });
//
//   String message;
//   List<OfferCustomObjectResult> result;
//
//   factory OfferCustomObject.fromJson(Map<String, dynamic> json) => OfferCustomObject(
//     message: json["message"],
//     result: List<OfferCustomObjectResult>.from(json["result"].map((x) => OfferCustomObjectResult.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "result": List<dynamic>.from(result.map((x) => x.toJson())),
//   };
// }
//
// class OfferCustomObjectResult {
//   OfferCustomObjectResult({
//     this.orderId,
//     this.addressLocation,
//     this.carInformationId,
//     this.carName,
//     this.comments,
//     this.completionDate,
//     this.creationDate,
//     this.estimatedPrice,
//     this.expectedCompletionDate,
//     this.orderNumber,
//     this.orderRating,
//     this.orderStatusId,
//     this.workshopId,
//     this.phoneNumber,
//     this.averagePrice,
//     this.totalCost,
//     this.editsPending,
//     this.downPayment,
//     this.vatValue,
//     this.vatPercent,
//     this.isDownPaymentRequested,
//     this.isDownPaymentCompleted,
//     this.isFinalPaymentCleared,
//     this.isCarPickupOrdered,
//     this.isCarPickupComplete,
//     this.isTechnicianOrder,
//     this.orderSteps,
//     this.distance,
//     this.workshopName,
//     this.orderParts,
//     this.orderAttachments,
//     this.timeInDays,
//     this.userId,
//     this.faults,
//     this.offers,
//   });
//
//   dynamic orderId;
//   String addressLocation;
//   dynamic carInformationId;
//   String carName;
//   String comments;
//   dynamic completionDate;
//   DateTime creationDate;
//   dynamic estimatedPrice;
//   DateTime expectedCompletionDate;
//   String orderNumber;
//   dynamic orderRating;
//   dynamic orderStatusId;
//   dynamic workshopId;
//   String phoneNumber;
//   dynamic averagePrice;
//   dynamic totalCost;
//   bool editsPending;
//   dynamic downPayment;
//   dynamic vatValue;
//   dynamic vatPercent;
//   bool isDownPaymentRequested;
//   bool isDownPaymentCompleted;
//   bool isFinalPaymentCleared;
//   bool isCarPickupOrdered;
//   bool isCarPickupComplete;
//   bool isTechnicianOrder;
//   List<dynamic> orderSteps;
//   dynamic distance;
//   WorkshopName workshopName;
//   List<dynamic> orderParts;
//   List<OrderAttachment> orderAttachments;
//
//   dynamic timeInDays;
//   dynamic userId;
//   List<Fault> faults;
//   List<PurpleOffer> offers;
//
//   factory OfferCustomObjectResult.fromJson(Map<String, dynamic> json) => OfferCustomObjectResult(
//     orderId: json["orderId"],
//     addressLocation: json["addressLocation"],
//     carInformationId: json["carInformationId"],
//     carName: json["carName"],
//     comments: json["comments"],
//     completionDate: json["completionDate"],
//     creationDate: DateTime.parse(json["creationDate"]),
//     estimatedPrice: json["estimatedPrice"],
//     expectedCompletionDate: DateTime.parse(json["expectedCompletionDate"]),
//     orderNumber: json["orderNumber"],
//     orderRating: json["orderRating"],
//     orderStatusId: json["orderStatusId"],
//     workshopId: json["workshopId"],
//     phoneNumber: json["phoneNumber"],
//     averagePrice: json["averagePrice"],
//     totalCost: json["totalCost"],
//     editsPending: json["editsPending"],
//     downPayment: json["downPayment"],
//     vatValue: json["vatValue"],
//     vatPercent: json["vatPercent"],
//     isDownPaymentRequested: json["isDownPaymentRequested"],
//     isDownPaymentCompleted: json["isDownPaymentCompleted"],
//     isFinalPaymentCleared: json["isFinalPaymentCleared"],
//     isCarPickupOrdered: json["isCarPickupOrdered"],
//     isCarPickupComplete: json["isCarPickupComplete"],
//     isTechnicianOrder: json["isTechnicianOrder"],
//     orderSteps: List<dynamic>.from(json["orderSteps"].map((x) => x)),
//     distance: json["distance"],
//     workshopName: WorkshopName.fromJson(json["workshopName"]),
//     orderParts: List<dynamic>.from(json["orderParts"].map((x) => x)),
//     orderAttachments: List<OrderAttachment>.from(json["orderAttachments"].map((x) => OrderAttachment.fromJson(x))),
//     timeInDays: json["timeInDays"],
//     userId: json["userId"],
//     faults: List<Fault>.from(json["faults"].map((x) => Fault.fromJson(x))),
//     offers: List<PurpleOffer>.from(json["offers"].map((x) => PurpleOffer.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "orderId": orderId,
//     "addressLocation": addressLocation,
//     "carInformationId": carInformationId,
//     "carName": carName,
//     "comments": comments,
//     "completionDate": completionDate,
//     "creationDate": creationDate.toIso8601String(),
//     "estimatedPrice": estimatedPrice,
//     "expectedCompletionDate": expectedCompletionDate.toIso8601String(),
//     "orderNumber": orderNumber,
//     "orderRating": orderRating,
//     "orderStatusId": orderStatusId,
//     "workshopId": workshopId,
//     "phoneNumber": phoneNumber,
//     "averagePrice": averagePrice,
//     "totalCost": totalCost,
//     "editsPending": editsPending,
//     "downPayment": downPayment,
//     "vatValue": vatValue,
//     "vatPercent": vatPercent,
//     "isDownPaymentRequested": isDownPaymentRequested,
//     "isDownPaymentCompleted": isDownPaymentCompleted,
//     "isFinalPaymentCleared": isFinalPaymentCleared,
//     "isCarPickupOrdered": isCarPickupOrdered,
//     "isCarPickupComplete": isCarPickupComplete,
//     "isTechnicianOrder": isTechnicianOrder,
//     "orderSteps": List<dynamic>.from(orderSteps.map((x) => x)),
//     "distance": distance,
//     "workshopName": workshopName.toJson(),
//     "orderParts": List<dynamic>.from(orderParts.map((x) => x)),
//     "orderAttachments": List<dynamic>.from(orderAttachments.map((x) => x.toJson())),
//     "timeInDays": timeInDays,
//     "userId": userId,
//     "faults": List<dynamic>.from(faults.map((x) => x.toJson())),
//     "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
//   };
// }
//
// class Fault {
//   Fault({
//     this.faultId,
//     this.name,
//   });
//
//   dynamic faultId;
//   String name;
//
//   factory Fault.fromJson(Map<String, dynamic> json) => Fault(
//     faultId: json["faultId"],
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "faultId": faultId,
//     "name": name,
//   };
// }
//
// class PurpleOffer {
//   PurpleOffer({
//     this.offerId,
//     this.price,
//     this.timeInDays,
//     this.offerDate,
//     this.isNegotiable,
//     this.isAccepted,
//     this.isRejected,
//     this.workshopName,
//     this.workshopRating,
//     this.customerOfferedPrice,
//     this.negotiationPendingCustomer,
//     this.negotiationPendingWorkshop,
//     this.views,
//     this.warrantyProvided,
//     this.workshopId,
//     this.offerStatus,
//   });
//
//   dynamic offerId;
//   dynamic price;
//   dynamic timeInDays;
//   DateTime offerDate;
//   bool isNegotiable;
//   bool isAccepted;
//   bool isRejected;
//   String workshopName;
//   dynamic workshopRating;
//   dynamic customerOfferedPrice;
//   bool negotiationPendingCustomer;
//   bool negotiationPendingWorkshop;
//   dynamic views;
//   bool warrantyProvided;
//   dynamic workshopId;
//   dynamic offerStatus;
//
//   factory PurpleOffer.fromJson(Map<String, dynamic> json) => PurpleOffer(
//     offerId: json["offerId"],
//     price: json["price"],
//     timeInDays: json["timeInDays"],
//     offerDate: DateTime.parse(json["offerDate"]),
//     isNegotiable: json["isNegotiable"],
//     isAccepted: json["isAccepted"],
//     isRejected: json["isRejected"],
//     workshopName: json["workshopName"],
//     workshopRating: json["workshopRating"],
//     customerOfferedPrice: json["customerOfferedPrice"],
//     negotiationPendingCustomer: json["negotiationPendingCustomer"],
//     negotiationPendingWorkshop: json["negotiationPendingWorkshop"],
//     views: json["views"],
//     warrantyProvided: json["warrantyProvided"],
//     workshopId: json["workshopId"],
//     offerStatus: json["offerStatus"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "offerId": offerId,
//     "price": price,
//     "timeInDays": timeInDays,
//     "offerDate": offerDate.toIso8601String(),
//     "isNegotiable": isNegotiable,
//     "isAccepted": isAccepted,
//     "isRejected": isRejected,
//     "workshopName": workshopName,
//     "workshopRating": workshopRating,
//     "customerOfferedPrice": customerOfferedPrice,
//     "negotiationPendingCustomer": negotiationPendingCustomer,
//     "negotiationPendingWorkshop": negotiationPendingWorkshop,
//     "views": views,
//     "warrantyProvided": warrantyProvided,
//     "workshopId": workshopId,
//     "offerStatus": offerStatus,
//   };
// }
//
// class WorkshopName {
//   WorkshopName({
//     this.name,
//   });
//
//   String name;
//
//   factory WorkshopName.fromJson(Map<String, dynamic> json) => WorkshopName(
//     name: json["name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//   };
// }
//
// class OrderCustomObject {
//   OrderCustomObject({
//     this.message,
//     this.result,
//   });
//
//   String message;
//   List<OrderCustomObjectResult> result;
//
//   factory OrderCustomObject.fromJson(Map<String, dynamic> json) => OrderCustomObject(
//     message: json["message"],
//     result: List<OrderCustomObjectResult>.from(json["result"].map((x) => OrderCustomObjectResult.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "result": List<dynamic>.from(result.map((x) => x.toJson())),
//   };
// }
//
// class OrderCustomObjectResult {
//   OrderCustomObjectResult({
//     this.orderId,
//     this.addressLocation,
//     this.carInformationId,
//     this.carName,
//     this.comments,
//     this.completionDate,
//     this.creationDate,
//     this.estimatedPrice,
//     this.expectedCompletionDate,
//     this.orderNumber,
//     this.orderRating,
//     this.orderStatusId,
//     this.workshopId,
//     this.workshopLocation,
//     this.phoneNumber,
//     this.workshopPhoneNumber,
//     this.workCost,
//     this.totalCost,
//     this.editsPending,
//     this.downPayment,
//     this.isDownPaymentRequested,
//     this.isDownPaymentCompleted,
//     this.isTechnicianOrder,
//     this.isFinalPaymentCleared,
//     this.orderSteps,
//     this.isCompleted,
//     this.isCarPickupOrdered,
//     this.isCarPickupComplete,
//     this.carType,
//     this.clientName,
//     this.distance,
//     this.timeInDays,
//     this.workshopName,
//     this.orderAttachments,
//     this.orderParts,
//     this.userId,
//     this.faults,
//     this.offers,
//   });
//
//   dynamic orderId;
//   String addressLocation;
//   dynamic carInformationId;
//   String carName;
//   String comments;
//   dynamic completionDate;
//   DateTime creationDate;
//   dynamic estimatedPrice;
//   DateTime expectedCompletionDate;
//   String orderNumber;
//   dynamic orderRating;
//   dynamic orderStatusId;
//   dynamic workshopId;
//   WorkshopLocation workshopLocation;
//   String phoneNumber;
//   String workshopPhoneNumber;
//   dynamic workCost;
//   dynamic totalCost;
//   bool editsPending;
//   dynamic downPayment;
//   bool isDownPaymentRequested;
//   bool isDownPaymentCompleted;
//   bool isTechnicianOrder;
//   bool isFinalPaymentCleared;
//   List<OrderStep> orderSteps;
//   bool isCompleted;
//   bool isCarPickupOrdered;
//   bool isCarPickupComplete;
//   String carType;
//   String clientName;
//   dynamic distance;
//   dynamic timeInDays;
//   WorkshopName workshopName;
//   List<OrderAttachment> orderAttachments;
//   List<OrderPart> orderParts;
//   dynamic userId;
//   List<Fault> faults;
//   List<FluffyOffer> offers;
//
//   factory OrderCustomObjectResult.fromJson(Map<String, dynamic> json) => OrderCustomObjectResult(
//     orderId: json["orderId"],
//     addressLocation: json["addressLocation"],
//     carInformationId: json["carInformationId"],
//     carName: json["carName"],
//     comments: json["comments"],
//     completionDate: json["completionDate"],
//     creationDate: DateTime.parse(json["creationDate"]),
//     estimatedPrice: json["estimatedPrice"],
//     expectedCompletionDate: DateTime.parse(json["expectedCompletionDate"]),
//     orderNumber: json["orderNumber"],
//     orderRating: json["orderRating"] == null ? null : json["orderRating"],
//     orderStatusId: json["orderStatusId"],
//     workshopId: json["workshopId"],
//     workshopLocation: WorkshopLocation.fromJson(json["workshopLocation"]),
//     phoneNumber: json["phoneNumber"],
//     workshopPhoneNumber: json["workshopPhoneNumber"],
//     workCost: json["workCost"],
//     totalCost: json["totalCost"].toDouble(),
//     editsPending: json["editsPending"],
//     downPayment: json["downPayment"],
//     isDownPaymentRequested: json["isDownPaymentRequested"],
//     isDownPaymentCompleted: json["isDownPaymentCompleted"],
//     isTechnicianOrder: json["isTechnicianOrder"],
//     isFinalPaymentCleared: json["isFinalPaymentCleared"],
//     orderSteps: List<OrderStep>.from(json["orderSteps"].map((x) => OrderStep.fromJson(x))),
//     isCompleted: json["isCompleted"],
//     isCarPickupOrdered: json["isCarPickupOrdered"],
//     isCarPickupComplete: json["isCarPickupComplete"],
//     carType: json["carType"],
//     clientName: json["clientName"],
//     distance: json["distance"].toDouble(),
//     timeInDays: json["timeInDays"],
//     workshopName: WorkshopName.fromJson(json["workshopName"]),
//     orderAttachments: List<OrderAttachment>.from(json["orderAttachments"].map((x) => OrderAttachment.fromJson(x))),
//     orderParts: List<OrderPart>.from(json["orderParts"].map((x) => OrderPart.fromJson(x))),
//     userId: json["userId"],
//     faults: List<Fault>.from(json["faults"].map((x) => Fault.fromJson(x))),
//     offers: List<FluffyOffer>.from(json["offers"].map((x) => FluffyOffer.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "orderId": orderId,
//     "addressLocation": addressLocation,
//     "carInformationId": carInformationId,
//     "carName": carName,
//     "comments": comments,
//     "completionDate": completionDate,
//     "creationDate": creationDate.toIso8601String(),
//     "estimatedPrice": estimatedPrice,
//     "expectedCompletionDate": expectedCompletionDate.toIso8601String(),
//     "orderNumber": orderNumber,
//     "orderRating": orderRating == null ? null : orderRating,
//     "orderStatusId": orderStatusId,
//     "workshopId": workshopId,
//     "workshopLocation": workshopLocation.toJson(),
//     "phoneNumber": phoneNumber,
//     "workshopPhoneNumber": workshopPhoneNumber,
//     "workCost": workCost,
//     "totalCost": totalCost,
//     "editsPending": editsPending,
//     "downPayment": downPayment,
//     "isDownPaymentRequested": isDownPaymentRequested,
//     "isDownPaymentCompleted": isDownPaymentCompleted,
//     "isTechnicianOrder": isTechnicianOrder,
//     "isFinalPaymentCleared": isFinalPaymentCleared,
//     "orderSteps": List<dynamic>.from(orderSteps.map((x) => x.toJson())),
//     "isCompleted": isCompleted,
//     "isCarPickupOrdered": isCarPickupOrdered,
//     "isCarPickupComplete": isCarPickupComplete,
//     "carType": carType,
//     "clientName": clientName,
//     "distance": distance,
//     "timeInDays": timeInDays,
//     "workshopName": workshopName.toJson(),
//     "orderAttachments": List<dynamic>.from(orderAttachments.map((x) => x.toJson())),
//     "orderParts": List<dynamic>.from(orderParts.map((x) => x.toJson())),
//     "userId": userId,
//     "faults": List<dynamic>.from(faults.map((x) => x.toJson())),
//     "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
//   };
// }
//
// class FluffyOffer {
//   FluffyOffer({
//     this.offerId,
//     this.price,
//     this.timeInDays,
//     this.offerDate,
//     this.isNegotiable,
//   });
//
//   dynamic offerId;
//   dynamic price;
//   dynamic timeInDays;
//   DateTime offerDate;
//   bool isNegotiable;
//
//   factory FluffyOffer.fromJson(Map<String, dynamic> json) => FluffyOffer(
//     offerId: json["offerId"],
//     price: json["price"],
//     timeInDays: json["timeInDays"],
//     offerDate: DateTime.parse(json["offerDate"]),
//     isNegotiable: json["isNegotiable"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "offerId": offerId,
//     "price": price,
//     "timeInDays": timeInDays,
//     "offerDate": offerDate.toIso8601String(),
//     "isNegotiable": isNegotiable,
//   };
// }
//
// class OrderAttachment {
//   OrderAttachment({
//     this.attachmentLink,
//   });
//
//   String attachmentLink;
//
//   factory OrderAttachment.fromJson(Map<String, dynamic> json) => OrderAttachment(
//     attachmentLink: json["attachmentLink"],
//   );
//
//   Map<String, String> toJson() => {
//     "attachmentLink": attachmentLink,
//   };
// }
//
// class OrderPart {
//   OrderPart({
//     this.orderPartId,
//     this.isPaid,
//     this.partName,
//     this.partCost,
//     this.isApproved,
//     this.pendingApproval,
//     this.pictures,
//   });
//
//   dynamic orderPartId;
//   bool isPaid;
//   String partName;
//   dynamic partCost;
//   bool isApproved;
//   bool pendingApproval;
//   List<Picture> pictures;
//
//   factory OrderPart.fromJson(Map<String, dynamic> json) => OrderPart(
//     orderPartId: json["orderPartId"],
//     isPaid: json["isPaid"],
//     partName: json["partName"],
//     partCost: json["partCost"],
//     isApproved: json["isApproved"],
//     pendingApproval: json["pendingApproval"],
//     pictures: List<Picture>.from(json["pictures"].map((x) => Picture.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "orderPartId": orderPartId,
//     "isPaid": isPaid,
//     "partName": partName,
//     "partCost": partCost,
//     "isApproved": isApproved,
//     "pendingApproval": pendingApproval,
//     "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
//   };
// }
//
// class Picture {
//   Picture({
//     this.imageUrl,
//   });
//
//   String imageUrl;
//
//   factory Picture.fromJson(Map<String, dynamic> json) => Picture(
//     imageUrl: json["imageURL"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "imageURL": imageUrl,
//   };
// }
//
// class OrderStep {
//   OrderStep({
//     this.title,
//     this.orderStepStatus,
//   });
//
//   String title;
//   dynamic orderStepStatus;
//
//   factory OrderStep.fromJson(Map<String, dynamic> json) => OrderStep(
//     title: json["title"],
//     orderStepStatus: json["orderStepStatus"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "orderStepStatus": orderStepStatus,
//   };
// }
//
// class WorkshopLocation {
//   WorkshopLocation({
//     this.longitude,
//     this.latitude,
//   });
//
//   dynamic longitude;
//   dynamic latitude;
//
//   factory WorkshopLocation.fromJson(Map<String, dynamic> json) => WorkshopLocation(
//     longitude: json["longitude"].toDouble(),
//     latitude: json["latitude"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "longitude": longitude,
//     "latitude": latitude,
//   };
// }
