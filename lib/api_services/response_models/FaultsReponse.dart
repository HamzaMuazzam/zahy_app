// To parse this JSON data, do
//
//     final faultsReponse = faultsReponseFromJson(jsonString);

import 'dart:convert';

FaultsReponse faultsReponseFromJson(String str) => FaultsReponse.fromJson(json.decode(str));

String faultsReponseToJson(FaultsReponse data) => json.encode(data.toJson());

class FaultsReponse {
  FaultsReponse({
    this.message,
    this.result,
  });

  String message;
  List<Result> result;

  factory FaultsReponse.fromJson(Map<String, dynamic> json) => FaultsReponse(
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
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
