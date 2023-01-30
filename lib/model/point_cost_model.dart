// To parse this JSON data, do
//
//     final pointCostModel = pointCostModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

PointCostModel pointCostModelFromJson(String str) =>
    PointCostModel.fromJson(json.decode(str));

String pointCostModelToJson(PointCostModel data) => json.encode(data.toJson());

class PointCostModel {
  PointCostModel({
    this.id,
    this.point,
    this.reason,
    this.createTime,
  });

  String? id;
  int? point;
  String? reason;
  Timestamp? createTime;

  factory PointCostModel.fromJson(Map<String, dynamic> json) => PointCostModel(
        id: json["id"],
        point: json["point"],
        reason: json["reason"],
        createTime: json["createTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "point": point,
        "reason": reason,
        "createTime": createTime,
      };
}
