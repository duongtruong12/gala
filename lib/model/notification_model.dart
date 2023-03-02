// To parse this JSON data, do
//
//     final NotificationModel = NotificationModelFromJson(jsonString);

import 'dart:convert';

import 'package:base_flutter/utils/global/globals_functions.dart';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.createdDate,
    required this.listToken,
  });

  String? id;
  String? title;
  String? body;
  DateTime? createdDate;
  List listToken;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        listToken: json["listToken"] == null
            ? []
            : List.from(json["listToken"].map((x) => x)),
        createdDate: dateTimeFromTimestamp(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "listToken": List<dynamic>.from(listToken.map((x) => x)),
        "createdDate": createdDate,
      };
}
