// To parse this JSON data, do
//
//     final carRelatedInfoReponse = carRelatedInfoReponseFromJson(jsonString);

import 'dart:convert';

CarRelatedInfoReponse carRelatedInfoReponseFromJson(String str) => CarRelatedInfoReponse.fromJson(json.decode(str));

String carRelatedInfoReponseToJson(CarRelatedInfoReponse data) => json.encode(data.toJson());

class CarRelatedInfoReponse {
  CarRelatedInfoReponse({
    this.message,
    this.result,
  });

  String message;
  Result result;

  factory CarRelatedInfoReponse.fromJson(Map<String, dynamic> json) => CarRelatedInfoReponse(
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
    this.carTypes,
    this.models,
    this.carCompanies,
    this.colors,
  });

  List<CarType> carTypes;
  List<Model> models;
  List<CarCompany> carCompanies;
  List<Color> colors;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    carTypes: List<CarType>.from(json["carTypes"].map((x) => CarType.fromJson(x))),
    models: List<Model>.from(json["models"].map((x) => Model.fromJson(x))),
    carCompanies: List<CarCompany>.from(json["carCompanies"].map((x) => CarCompany.fromJson(x))),
    colors: List<Color>.from(json["colors"].map((x) => Color.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "carTypes": List<dynamic>.from(carTypes.map((x) => x.toJson())),
    "models": List<dynamic>.from(models.map((x) => x.toJson())),
    "carCompanies": List<dynamic>.from(carCompanies.map((x) => x.toJson())),
    "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
  };
}

class CarCompany {
  CarCompany({
    this.carModelId,
    this.companyId,
    this.companyName,
    this.carModelNames,
  });

  int carModelId;
  int companyId;
  String companyName;
  List<String> carModelNames;

  factory CarCompany.fromJson(Map<String, dynamic> json) => CarCompany(
    carModelId: json["carModelId"],
    companyId: json["companyId"],
    companyName: json["companyName"],
    carModelNames: List<String>.from(json["carModelNames"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "carModelId": carModelId,
    "companyId": companyId,
    "companyName": companyName,
    "carModelNames": List<dynamic>.from(carModelNames.map((x) => x)),
  };
}

class CarType {
  CarType({
    this.carTypeId,
    this.typeName,
  });

  int carTypeId;
  String typeName;

  factory CarType.fromJson(Map<String, dynamic> json) => CarType(
    carTypeId: json["carTypeId"],
    typeName: json["typeName"],
  );

  Map<String, dynamic> toJson() => {
    "carTypeId": carTypeId,
    "typeName": typeName,
  };
}

class Color {
  Color({
    this.colorId,
    this.colorName,
  });

  int colorId;
  String colorName;

  factory Color.fromJson(Map<String, dynamic> json) => Color(
    colorId: json["colorId"],
    colorName: json["colorName"],
  );

  Map<String, dynamic> toJson() => {
    "colorId": colorId,
    "colorName": colorName,
  };
}

class Model {
  Model({
    this.modelId,
    this.modelName,
  });

  int modelId;
  String modelName;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    modelId: json["modelId"],
    modelName: json["modelName"],
  );

  Map<String, dynamic> toJson() => {
    "modelId": modelId,
    "modelName": modelName,
  };
}
