// To parse this JSON data, do
//
//     final userAllPaymentMethod = userAllPaymentMethodFromJson(jsonString);

import 'dart:convert';

UserPaymentMethod userAllPaymentMethodFromJson(String str) => UserPaymentMethod.fromJson(json.decode(str));

String userAllPaymentMethodToJson(UserPaymentMethod data) => json.encode(data.toJson());

class UserPaymentMethod {
  UserPaymentMethod({
    this.message,
    this.result,
  });

  String message;
  List<Result> result=[];

  factory UserPaymentMethod.fromJson(Map<String, dynamic> json) => UserPaymentMethod(
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
    this.userCardInfoId,
    this.number,
    this.company,
    this.isDefault,
  });

  dynamic userCardInfoId;
  String number;
  String company;
  bool isDefault;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userCardInfoId: json["userCardInfoId"],
    number: json["number"],
    company: json["company"],
    isDefault: json["isDefault"],
  );

  Map<String, dynamic> toJson() => {
    "userCardInfoId": userCardInfoId,
    "number": number,
    "company": company,
    "isDefault": isDefault,
  };
}
