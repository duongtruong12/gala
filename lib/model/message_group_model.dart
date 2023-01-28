import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

MessageGroupModel messageGroupModelFromJson(String str) =>
    MessageGroupModel.fromJson(json.decode(str));

String messageGroupModelToJson(MessageGroupModel data) =>
    json.encode(data.toJson());

class MessageGroupModel {
  MessageGroupModel({
    this.id,
    this.title,
    this.avatar,
    this.createTime,
    this.messageGroupType,
    required this.userIds,
    this.lastMessage,
  });

  String? id;
  String? title;
  String? avatar;
  String? messageGroupType;
  Timestamp? createTime;
  List userIds;
  MessageModel? lastMessage;

  factory MessageGroupModel.fromJson(Map<String, dynamic> json) =>
      MessageGroupModel(
        id: json["id"],
        createTime: json['createTime'],
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
        "createTime": createTime,
        "lastMessage": lastMessage?.toJson(),
        "userIds": List<dynamic>.from(userIds.map((x) => x)),
      };
}

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    this.content,
    this.userId,
    this.delete,
    this.createdTime,
    this.type,
  });

  String? content;
  String? userId;
  bool? delete;
  Timestamp? createdTime;
  String? type;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        content: json["content"],
        userId: json["userId"],
        delete: json["delete"],
        createdTime: json["createdTime"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "userId": userId,
        "delete": delete,
        "createdTime": createdTime,
        "type": type,
      };
}
