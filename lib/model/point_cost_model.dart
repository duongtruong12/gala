// To parse this JSON data, do
//
//     final pointCostModel = pointCostModelFromJson(jsonString);

import 'dart:convert';

import 'package:base_flutter/model/json_parse/date_to_string.dart';

PointCostModel pointCostModelFromJson(String str) =>
    PointCostModel.fromJson(json.decode(str));

String pointCostModelToJson(PointCostModel data) => json.encode(data.toJson());

class PointCostModel {
  PointCostModel({
    this.id,
    this.point,
    this.reason,
    this.status,
    this.createTime,
  });

  String? id;
  String? status;
  int? point;
  String? reason;
  DateTime? createTime;

  factory PointCostModel.fromJson(Map<String, dynamic> json) => PointCostModel(
        id: json["id"],
        point: json["point"],
        reason: json["reason"],
        status: json["status"],
        createTime: fromJsonTimeStamp(json["createTime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "point": point,
        "reason": reason,
        "status": status,
        "createTime": createTime,
      };
}
