// To parse this JSON data, do
//
//     final paymentHistoryResponse = paymentHistoryResponseFromJson(jsonString);

import 'dart:convert';

PaymentHistoryResponse paymentHistoryResponseFromJson(String str) => PaymentHistoryResponse.fromJson(json.decode(str));

String paymentHistoryResponseToJson(PaymentHistoryResponse data) => json.encode(data.toJson());

class PaymentHistoryResponse {
  PaymentHistoryResponse({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) => PaymentHistoryResponse(
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
    this.pending,
    this.spent,
  });

  List<Pending> pending;
  List<Pending> spent;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    pending: List<Pending>.from(json["pending"].map((x) => Pending.fromJson(x))),
    spent: List<Pending>.from(json["spent"].map((x) => Pending.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pending": List<dynamic>.from(pending.map((x) => x.toJson())),
    "spent": List<dynamic>.from(spent.map((x) => x.toJson())),
  };
}

class Pending {
  Pending({
    this.orderId,
    this.orderNumber,
    this.orderDate,
    this.carName,
    this.totalCost,
    this.workshopId,
    this.userId,
  });

  dynamic orderId;
  String orderNumber;
  String orderDate;
  String carName;
  dynamic totalCost;
  dynamic workshopId;
  dynamic userId;

  factory Pending.fromJson(Map<String, dynamic> json) => Pending(
    orderId: json["orderId"],
    orderNumber: json["orderNumber"],
    orderDate: json["orderDate"],
    carName: json["carName"],
    totalCost: json["totalCost"],
    workshopId: json["workshopId"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "orderNumber": orderNumber,
    "orderDate": orderDate,
    "carName": carName,
    "totalCost": totalCost,
    "workshopId": workshopId,
    "userId": userId,
  };
}
