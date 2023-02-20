// To parse this JSON data, do
//
//     final ticket = ticketFromJson(jsonString);

import 'dart:convert';

import 'package:base_flutter/utils/constant.dart';

import 'json_parse/date_to_string.dart';

Ticket ticketFromJson(String str) => Ticket.fromJson(json.decode(str));

String ticketToJson(Ticket data) => json.encode(data.toJson());

class Ticket {
  Ticket({
    this.id,
    this.createdUser,
    this.startTime,
    this.startTimeAfter,
    this.cityId,
    this.cityName,
    this.stateId,
    this.stateName,
    this.numberPeople,
    this.createdDate,
    this.durationDate,
    this.expectedPoint,
    this.extension,
    this.status,
    required this.peopleApply,
    required this.tagInformation,
    required this.peopleApprove,
  });

  String? id;
  String? createdUser;
  DateTime? startTime;
  String? startTimeAfter;
  String? status;
  int? cityId;
  String? cityName;
  int? stateId;
  String? stateName;
  int? numberPeople;
  DateTime? createdDate;
  String? durationDate;
  int? expectedPoint;
  int? extension;
  List peopleApply;
  List tagInformation;
  List peopleApprove;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        createdUser: json["createdUser"],
        startTime: fromJsonTimeStamp(json["startTime"]),
        startTimeAfter: json["startTimeAfter"],
        status: json["status"],
        cityName: json["cityName"],
        cityId: json["cityId"],
        stateId: json["stateId"],
        stateName: json["stateName"],
        numberPeople: json["numberPeople"],
        createdDate: fromJsonTimeStamp(json["createdDate"]),
        durationDate: json["durationDate"],
        expectedPoint: json["expectedPoint"],
        extension: json["extension"],
        peopleApply: json["peopleApply"] == null
            ? []
            : List<dynamic>.from(json["peopleApply"]!.map((x) => x)),
        peopleApprove: json["peopleApprove"] == null
            ? []
            : List<dynamic>.from(json["peopleApprove"]!.map((x) => x)),
        tagInformation: json["tagInformation"] == null
            ? []
            : List<dynamic>.from(json["tagInformation"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdUser": createdUser,
        "status": status,
        "startTime": startTime,
        "startTimeAfter": startTimeAfter,
        "cityId": cityId,
        "cityName": cityName,
        "stateId": stateId,
        "stateName": stateName,
        "numberPeople": numberPeople,
        "createdDate": createdDate,
        "durationDate": durationDate,
        "expectedPoint": expectedPoint,
        "extension": extension,
        "peopleApply": List<dynamic>.from(peopleApply.map((x) => x)),
        "peopleApprove": List<dynamic>.from(peopleApprove.map((x) => x)),
        "tagInformation": List<dynamic>.from(tagInformation.map((x) => x)),
      };

  int calculateTotalPrice() {
    if (numberPeople != null && durationDate != null) {
      int multi = 1;
      if (durationDate == DurationDate.hour1.name) {
        multi = 2;
      } else if (durationDate == DurationDate.hour2.name) {
        multi = 4;
      } else if (durationDate == DurationDate.hour3.name) {
        multi = 6;
      } else {
        multi = 8;
      }
      return (2500 * multi) * numberPeople!;
    }
    return 0;
  }
}
