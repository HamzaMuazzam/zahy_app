// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
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
    this.name,
    this.email,
    this.created,
    this.phoneNumber,
    this.userTypeId,
    this.isAvailable,
  });

  int id;
  String name;
  String email;
  String created;
  String phoneNumber;
  int userTypeId;
  bool isAvailable;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    created: json["created"],
    phoneNumber: json["phoneNumber"],
    userTypeId: json["userTypeId"],
    isAvailable: json["isAvailable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "created": created,
    "phoneNumber": phoneNumber,
    "userTypeId": userTypeId,
    "isAvailable": isAvailable,
  };
}
