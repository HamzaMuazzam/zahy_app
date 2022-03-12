// To parse this JSON data, do
//
//     final loginReponse = loginReponseFromJson(jsonString);

import 'dart:convert';

LoginReponse loginReponseFromJson(String str) => LoginReponse.fromJson(json.decode(str));

String loginReponseToJson(LoginReponse data) => json.encode(data.toJson());

class LoginReponse {
  LoginReponse({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory LoginReponse.fromJson(Map<String, dynamic> json) => LoginReponse(
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
    this.token,
    this.refreshToken,
    this.user,
  });

  String token;
  String refreshToken;
  User user;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    token: json["token"],
    refreshToken: json["refreshToken"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "refreshToken": refreshToken,
    "user": user.toJson(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.created,
    this.phoneNumber,
    this.userTypeId,
  });

  int id;
  String name;
  String email;
  DateTime created;
  String phoneNumber;
  int userTypeId;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    created: DateTime.parse(json["created"]),
    phoneNumber: json["phoneNumber"],
    userTypeId: json["userTypeId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "created": created.toIso8601String(),
    "phoneNumber": phoneNumber,
    "userTypeId": userTypeId,
  };
}
