// To parse this JSON data, do
//
//     final carInformationReponse = carInformationReponseFromJson(jsonString);

import 'dart:convert';

CarInformationReponse carInformationReponseFromJson(String str) => CarInformationReponse.fromJson(json.decode(str));

String carInformationReponseToJson(CarInformationReponse data) => json.encode(data.toJson());

class CarInformationReponse {
  CarInformationReponse({
    this.message,
    this.result,
  });

  String message;
  List<Result> result;

  factory CarInformationReponse.fromJson(Map<String, dynamic> json) => CarInformationReponse(
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
    this.carInformationId,
    this.modelId,
    this.carName,
    this.model,
    this.colorId,
    this.color,
    this.companyId,
    this.company,
    this.carTransmission,
    this.userId,
    this.user,
  });

  int carInformationId;
  int modelId;
  String carName;
  String model;
  int colorId;
  String color;
  int companyId;
  String company;
  String carTransmission;
  int userId;
  String user;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    carInformationId: json["carInformationId"],
    modelId: json["modelId"],
    carName: json["carName"] == null ? null : json["carName"],
    model: json["model"],
    colorId: json["colorId"],
    color: json["color"],
    companyId: json["companyId"],
    company: json["company"],
    carTransmission: json["carTransmission"],
    userId: json["userId"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "carInformationId": carInformationId,
    "modelId": modelId,
    "carName": carName == null ? null : carName,
    "model": model,
    "colorId": colorId,
    "color": color,
    "companyId": companyId,
    "company": company,
    "carTransmission": carTransmission,
    "userId": userId,
    "user": user,
  };
}
