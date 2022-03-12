// To parse this JSON data, do
//
//     final carPickUpType = carPickUpTypeFromJson(jsonString);

import 'dart:convert';

CarPickUpType carPickUpTypeFromJson(String str) => CarPickUpType.fromJson(json.decode(str));

String carPickUpTypeToJson(CarPickUpType data) => json.encode(data.toJson());

class CarPickUpType {
  CarPickUpType({
    this.message,
    this.result,
  });

  String message;
  List<Result> result;

  factory CarPickUpType.fromJson(Map<String, dynamic> json) => CarPickUpType(
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
    this.carPickupTypeId,
    this.type,
    this.cost,
  });

  dynamic carPickupTypeId;
  String type;
  dynamic cost;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    carPickupTypeId: json["carPickupTypeId"],
    type: json["type"],
    cost: json["cost"],
  );

  Map<String, dynamic> toJson() => {
    "carPickupTypeId": carPickupTypeId,
    "type": type,
    "cost": cost,
  };
}
