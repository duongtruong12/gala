// To parse this JSON data, do
//
//     final ticket = ticketFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Ticket ticketFromJson(String str) => Ticket.fromJson(json.decode(str));

String ticketToJson(Ticket data) => json.encode(data.toJson());

class Ticket {
  Ticket({
    this.id,
    this.createdUser,
    this.startTime,
    this.area,
    this.numberPeople,
    this.createdDate,
    this.requiredTime,
    this.expectedPoint,
    this.extension,
    this.peopleApply,
  });

  String? id;
  String? createdUser;
  Timestamp? startTime;
  String? area;
  int? numberPeople;
  Timestamp? createdDate;
  int? requiredTime;
  int? expectedPoint;
  int? extension;
  List? peopleApply;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        createdUser: json["created_user"],
        startTime: json["start_time"],
        area: json["area"],
        numberPeople: json["number_people"],
        createdDate: json["created_date"],
        requiredTime: json["required_time"],
        expectedPoint: json["expected_point"],
        extension: json["extension"],
        peopleApply: json["people_apply"] == null
            ? []
            : List<dynamic>.from(json["people_apply"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_user": createdUser,
        "start_time": startTime,
        "area": area,
        "number_people": numberPeople,
        "created_date": createdDate,
        "required_time": requiredTime,
        "expected_point": expectedPoint,
        "extension": extension,
        "people_apply": peopleApply == null
            ? []
            : List<dynamic>.from(peopleApply!.map((x) => x)),
      };
}
