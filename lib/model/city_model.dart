// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

StateModel stateModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    this.id,
    this.cityId,
    this.name,
  });

  int? id;
  int? cityId;
  String? name;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
        id: json["id"],
        cityId: json["cityId"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cityId": cityId,
        "name": name,
      };
}
