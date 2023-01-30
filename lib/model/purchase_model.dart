// To parse this JSON data, do
//
//     final PurchaseModel = PurchaseModelFromJson(jsonString);

import 'dart:convert';

PurchaseModel purchaseModelFromJson(String str) =>
    PurchaseModel.fromJson(json.decode(str));

String purchaseModelToJson(PurchaseModel data) => json.encode(data.toJson());

class PurchaseModel {
  PurchaseModel({
    this.id,
    this.point,
    this.cost,
  });

  String? id;
  int? point;
  int? cost;

  factory PurchaseModel.fromJson(Map<String, dynamic> json) => PurchaseModel(
        id: json["id"],
        point: json["point"],
        cost: json["cost"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "point": point,
        "cost": cost,
      };
}
