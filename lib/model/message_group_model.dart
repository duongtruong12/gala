import 'dart:convert';

import 'package:base_flutter/model/json_parse/date_to_string.dart';

MessageGroupModel messageGroupModelFromJson(String str) =>
    MessageGroupModel.fromJson(json.decode(str));

String messageGroupModelToJson(MessageGroupModel data) =>
    json.encode(data.toJson());

class MessageGroupModel {
  MessageGroupModel({
    this.id,
    this.title,
    this.avatar,
    this.createdTime,
    this.lastUpdatedTime,
    this.messageGroupType,
    required this.userIds,
    this.lastMessage,
  });

  String? id;
  String? title;
  String? avatar;
  String? messageGroupType;
  DateTime? createdTime;
  DateTime? lastUpdatedTime;
  List userIds;
  MessageModel? lastMessage;

  factory MessageGroupModel.fromJson(Map<String, dynamic> json) =>
      MessageGroupModel(
        id: json["id"],
        title: json["title"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "avatar": avatar,
        "messageGroupType": messageGroupType,
        "createdTime": createdTime.toString(),
        "lastUpdatedTime": lastUpdatedTime.toString(),
        "lastMessage": lastMessage?.toJson(),
        "userIds": List<dynamic>.from(userIds.map((x) => x)),
      };
}

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    this.id,
    this.content,
    this.userId,
    this.delete,
    this.createdTime,
    this.type,
  });

  String? id;
  String? content;
  String? userId;
  bool? delete;
  DateTime? createdTime;
  String? type;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        content: json["content"],
        userId: json["userId"],
        delete: json["delete"],
        createdTime: fromJsonDate(json["createdTime"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "userId": userId,
        "delete": delete,
        "createdTime": createdTime.toString(),
        "type": type,
      };
}
