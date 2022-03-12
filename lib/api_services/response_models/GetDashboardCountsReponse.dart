// To parse this JSON data, do
//
//     final getDashboardCountsReponse = getDashboardCountsReponseFromJson(jsonString);

import 'dart:convert';

GetDashboardCountsReponse getDashboardCountsReponseFromJson(String str) => GetDashboardCountsReponse.fromJson(json.decode(str));

String getDashboardCountsReponseToJson(GetDashboardCountsReponse data) => json.encode(data.toJson());

class GetDashboardCountsReponse {
  GetDashboardCountsReponse({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory GetDashboardCountsReponse.fromJson(Map<String, dynamic> json) => GetDashboardCountsReponse(
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
    this.workshopCount,
    this.technicianCount,
    this.pickupCarCount,
  });

  int workshopCount=0;
  int technicianCount=0;
  int pickupCarCount=0;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    workshopCount: json["workshopCount"],
    technicianCount: json["technicianCount"],
    pickupCarCount: json["pickupCarCount"],
  );

  Map<String, dynamic> toJson() => {
    "workshopCount": workshopCount,
    "technicianCount": technicianCount,
    "pickupCarCount": pickupCarCount,
  };
}
