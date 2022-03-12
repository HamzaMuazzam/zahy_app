// To parse this JSON data, do
//
//     final promotionCashBack = promotionCashBackFromJson(jsonString);

import 'dart:convert';

PromotionCashBack promotionCashBackFromJson(String str) => PromotionCashBack.fromJson(json.decode(str));

String promotionCashBackToJson(PromotionCashBack data) => json.encode(data.toJson());

class PromotionCashBack {
  PromotionCashBack({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory PromotionCashBack.fromJson(Map<String, dynamic> json) => PromotionCashBack(
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
    this.id,
    this.promotionId,
    this.userId,
    this.amount,
  });

  int id;
  int promotionId;
  int userId;
  String amount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    promotionId: json["promotionId"],
    userId: json["userId"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "promotionId": promotionId,
    "userId": userId,
    "amount": amount,
  };
}
