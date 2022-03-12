// To parse this JSON data, do
//
//     final getUserProfile = getUserProfileFromJson(jsonString);

import 'dart:convert';

GetUserProfile getUserProfileFromJson(String str) => GetUserProfile.fromJson(json.decode(str));

String getUserProfileToJson(GetUserProfile data) => json.encode(data.toJson());

class GetUserProfile {
  GetUserProfile({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory GetUserProfile.fromJson(Map<String, dynamic> json) => GetUserProfile(
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
    this.phoneNumber,
    this.email,
    this.commercialRegistration,
    this.displayPicture,
  });

  int id;
  String name;
  String phoneNumber;
  String email;
  String commercialRegistration;
  String displayPicture;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    commercialRegistration: json["commercialRegistration"],
    displayPicture: json["displayPicture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phoneNumber": phoneNumber,
    "email": email,
    "commercialRegistration": commercialRegistration,
    "displayPicture": displayPicture,
  };
}
