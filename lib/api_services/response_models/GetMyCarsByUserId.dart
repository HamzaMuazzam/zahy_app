// To parse this JSON data, do
//
//     final getMyCarsByUserId = getMyCarsByUserIdFromJson(jsonString);

import 'dart:convert';

GetMyCarsByUserId getMyCarsByUserIdFromJson(String str) => GetMyCarsByUserId.fromJson(json.decode(str));

String getMyCarsByUserIdToJson(GetMyCarsByUserId data) => json.encode(data.toJson());

class GetMyCarsByUserId {
  GetMyCarsByUserId({
    this.message,
    this.result,
  });

  String message;
  List<Result> result;

  factory GetMyCarsByUserId.fromJson(Map<String, dynamic> json) => GetMyCarsByUserId(
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
    this.carName,
    this.modelId,
    this.model,
    this.colorId,
    this.color,
    this.companyId,
    this.company,
    this.carTransmission,
    this.carType,
    this.userId,
    this.user,
    this.orderHistory,
    this.report,
  });

  dynamic carInformationId;
  String carName;
  dynamic modelId;
  String model;
  dynamic colorId;
  String color;
  dynamic companyId;
  String company;
  String carTransmission;
  String carType;
  dynamic userId;
  String user;
  List<OrderHistory> orderHistory;
  List<Report> report;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    carInformationId: json["carInformationId"],
    carName: json["carName"] == null ? null : json["carName"],
    modelId: json["modelId"],
    model: json["model"],
    colorId: json["colorId"],
    color: json["color"],
    companyId: json["companyId"],
    company: json["company"],
    carTransmission: json["carTransmission"],
    carType: json["carType"],
    userId: json["userId"],
    user: json["user"],
    orderHistory: List<OrderHistory>.from(json["orderHistory"].map((x) => OrderHistory.fromJson(x))),
    report: List<Report>.from(json["report"].map((x) => Report.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "carInformationId": carInformationId,
    "carName": carName == null ? null : carName,
    "modelId": modelId,
    "model": model,
    "colorId": colorId,
    "color": color,
    "companyId": companyId,
    "company": company,
    "carTransmission": carTransmission,
    "carType": carType,
    "userId": userId,
    "user": user,
    "orderHistory": List<dynamic>.from(orderHistory.map((x) => x.toJson())),
    "report": List<dynamic>.from(report.map((x) => x.toJson())),
  };
}

class OrderHistory {
  OrderHistory({
    this.orderId,
    this.creationDate,
    this.expectedCompletionDate,
    this.comments,
    this.completionDate,
    this.totalCost,
    this.addressLocation,
    this.issues,
    this.orderNumber,
    this.orderStatusId,
    this.workshopName,
    this.workshopId,
    this.workshopRating,
    this.musanFee,
    this.vatValue,
    this.workCost,
  });

  dynamic workCost;
  dynamic workshopRating;
  dynamic musanFee;
  dynamic orderId;
  dynamic vatValue;
  dynamic workshopName;
  String creationDate;
  String expectedCompletionDate;
  String comments;
  dynamic completionDate;
  dynamic totalCost;
  String addressLocation;
  List<Issue> issues;
  String orderNumber;
  dynamic orderStatusId;
  dynamic workshopId;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
    workshopRating: json["workshopRating"],
    workCost: json["workCost"],
    musanFee: json["musanFee"],
    workshopName: json["workshopName"],
    vatValue: json["vatValue"],
    orderId: json["orderId"],
    creationDate: json["creationDate"],
    expectedCompletionDate: json["expectedCompletionDate"],
    comments: json["comments"],
    completionDate: json["completionDate"],
    totalCost: json["totalCost"],
    addressLocation: json["addressLocation"] == null ? null : json["addressLocation"],
    issues: List<Issue>.from(json["issues"].map((x) => Issue.fromJson(x))),
    orderNumber: json["orderNumber"] == null ? null : json["orderNumber"],
    orderStatusId: json["orderStatusId"],
    workshopId: json["workshopId"],
  );

  Map<String, dynamic> toJson() => {
    "workshopRating": workshopRating,
    "musanFee": musanFee,
    "workCost": workCost,
    "vatValue": vatValue,
    "workshopName": workshopName,
    "orderId": orderId,
    "creationDate": creationDate,
    "expectedCompletionDate": expectedCompletionDate,
    "comments": comments,
    "completionDate": completionDate,
    "totalCost": totalCost,
    "addressLocation": addressLocation == null ? null : addressLocation,
    "issues": List<dynamic>.from(issues.map((x) => x.toJson())),
    "orderNumber": orderNumber == null ? null : orderNumber,
    "orderStatusId": orderStatusId,
    "workshopId": workshopId,
  };
}

class Issue {
  Issue({
    this.name,
    this.faultId,
  });

  String name;
  dynamic faultId;

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
    name: json["name"],
    faultId: json["faultId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "faultId": faultId,
  };
}

class Report {
  Report({
    this.reportId,
    this.technicianId,
    this.addressLocation,
    this.attachments,
    this.comment,
    this.creationDate,
    this.issueTypes,
  });

  dynamic reportId;
  dynamic technicianId;
  String addressLocation;
  List<Attachment> attachments;
  String comment;
  String creationDate;
  List<IssueType> issueTypes;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    reportId: json["reportId"],
    technicianId: json["technicianId"],
    addressLocation: json["addressLocation"],
    attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
    comment: json["comment"],
    creationDate: json["creationDate"],
    issueTypes: List<IssueType>.from(json["issueTypes"].map((x) => IssueType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "reportId": reportId,
    "technicianId": technicianId,
    "addressLocation": addressLocation,
    "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
    "comment": comment,
    "creationDate": creationDate,
    "issueTypes": List<dynamic>.from(issueTypes.map((x) => x.toJson())),
  };
}

class Attachment {
  Attachment({
    this.attachmentLink,
  });

  String attachmentLink;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    attachmentLink: json["attachmentLink"],
  );

  Map<String, dynamic> toJson() => {
    "attachmentLink": attachmentLink,
  };
}

class IssueType {
  IssueType({
    this.faultId,
    this.faultName,
  });

  dynamic faultId;
  String faultName;

  factory IssueType.fromJson(Map<String, dynamic> json) => IssueType(
    faultId: json["faultId"],
    faultName: json["faultName"],
  );

  Map<String, dynamic> toJson() => {
    "faultId": faultId,
    "faultName": faultName,
  };
}
