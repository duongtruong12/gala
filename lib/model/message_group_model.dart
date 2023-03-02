import 'dart:convert';

import 'package:base_flutter/model/json_parse/date_to_string.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';

MessageGroupModel messageGroupModelFromJson(String str) =>
    MessageGroupModel.fromJson(json.decode(str));

String messageGroupModelToJson(MessageGroupModel data) =>
    json.encode(data.toJson());

class MessageGroupModel {
  MessageGroupModel({
    this.id,
    this.title,
    this.ticketId,
    this.avatar,
    this.createdTime,
    this.lastUpdatedTime,
    this.messageGroupType,
    required this.userIds,
    required this.seenMessage,
    this.lastMessage,
  });

  String? id;
  String? title;
  String? ticketId;
  String? avatar;
  String? messageGroupType;
  DateTime? createdTime;
  DateTime? lastUpdatedTime;
  List userIds;
  MessageModel? lastMessage;
  Map seenMessage;

  factory MessageGroupModel.fromJson(Map<String, dynamic> json) =>
      MessageGroupModel(
        id: json["id"],
        title: json["title"],
        ticketId: json["ticketId"],
        createdTime: fromJsonDate(json["createdTime"]),
        lastUpdatedTime: fromJsonDate(json["lastUpdatedTime"]),
        avatar: json['avatar'],
        messageGroupType: json['messageGroupType'],
        lastMessage: json['lastMessage'] != null
            ? MessageModel.fromJson(json['lastMessage'])
            : null,
        userIds: json["userIds"] == null
            ? []
            : List.from(json["userIds"].map((x) => x)),
        seenMessage: json["seenMessage"] ?? {},
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "ticketId": ticketId,
        "avatar": avatar,
        "messageGroupType": messageGroupType,
        "createdTime": createdTime.toString(),
        "lastUpdatedTime": lastUpdatedTime.toString(),
        "lastMessage": lastMessage?.toJson(),
        "seenMessage": seenMessage,
        "userIds": List<dynamic>.from(userIds.map((x) => x)),
      };

  bool userNotSeen() {
    return seenMessage[user.value?.id] == null ||
        seenMessage[user.value?.id]?.toDate().isAfter(lastUpdatedTime!) != true;
  }
}

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    this.id,
    this.content,
    this.userId,
    this.ticketId,
    this.delete,
    this.createdTime,
    this.type,
  });

  String? id;
  String? content;
  String? userId;
  String? ticketId;
  bool? delete;
  DateTime? createdTime;
  String? type;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        content: json["content"],
        userId: json["userId"],
        ticketId: json["ticketId"],
        delete: json["delete"],
        createdTime: fromJsonDate(json["createdTime"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "userId": userId,
        "ticketId": ticketId,
        "delete": delete,
        "createdTime": createdTime.toString(),
        "type": type,
      };
}

CountTimeModel countTimeModelFromJson(String str) =>
    CountTimeModel.fromJson(json.decode(str));

String countTimeModelToJson(CountTimeModel data) => json.encode(data.toJson());

class CountTimeModel {
  CountTimeModel({
    this.id,
    this.startDate,
    this.endDate,
    this.point,
  });

  String? id;
  DateTime? startDate;
  DateTime? endDate;
  int? point;

  factory CountTimeModel.fromJson(Map<String, dynamic> json) => CountTimeModel(
        id: json["id"],
        startDate: fromJsonTimeStamp(json["startDate"]),
        endDate: fromJsonTimeStamp(json["endDate"]),
        point: json["point"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "startDate": startDate,
        "endDate": endDate,
        "point": point,
      };
}
