// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:base_flutter/utils/constant.dart';
import 'package:get/get.dart';

import 'json_parse/date_to_string.dart';

UserModel userModelFromJsonSaveValue(String str) =>
    UserModel.fromJsonSaveValue(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

String userModelToJsonSaveValue(UserModel data) =>
    json.encode(data.toJsonSaveValue());

class UserModel {
  UserModel({
    this.id,
    this.userId,
    this.realName,
    this.displayName,
    this.password,
    this.email,
    this.avatar,
    required this.previewImage,
    required this.applyTickets,
    required this.approveTickets,
    required this.tagInformation,
    this.typeAccount,
    this.createdDate,
    this.birthday,
    this.currentPoint,
    this.pointPer30Minutes,
    this.hideAge,
    this.cityId,
    this.cityName,
    this.stateId,
    this.stateName,
    this.description,
    this.height,
    this.address,
    this.birthPlace,
    this.education,
    this.annualIncome,
    this.job,
    this.sake,
    this.smoke,
    this.familyStatus,
    this.livingFamily,
    this.hairStyle,
    this.hairColor,
    this.notificationToken,
  });

  String? id;
  String? userId;
  String? realName;
  String? displayName;
  String? password;
  String? email;
  String? avatar;
  String? notificationToken;
  List<dynamic> previewImage;
  List<dynamic> applyTickets;
  List<dynamic> approveTickets;
  String? typeAccount;
  int? currentPoint;
  int? pointPer30Minutes;
  bool? hideAge;
  int? cityId;
  String? cityName;
  String? stateName;
  int? stateId;
  String? description;
  int? height;
  String? address;
  String? birthPlace;
  String? education;
  String? annualIncome;
  String? job;
  String? sake;
  String? smoke;
  String? familyStatus;
  String? livingFamily;
  String? hairStyle;
  String? hairColor;
  List<dynamic> tagInformation;
  DateTime? createdDate;
  DateTime? birthday;

  bool isAdminAccount() {
    return typeAccount == TypeAccount.admin.name;
  }

  String getDisplayName() {
    return '${displayName ?? ''} ${getAge()}';
  }

  String getAge() {
    if (hideAge == true) {
      return '';
    }

    if (birthday != null) {
      final different =
          (DateTime.now().difference(birthday!).inDays / 365).round();
      return '$different${'age'.tr}';
    }
    return 'not_entered'.tr;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        realName: json["realName"],
        displayName: json["displayName"],
        email: json["email"],
        avatar: json["avatar"],
        previewImage: json["previewImage"] == null
            ? []
            : List<dynamic>.from(json["previewImage"]!.map((x) => x)),
        applyTickets: json["applyTickets"] == null
            ? []
            : List<dynamic>.from(json["applyTickets"]!.map((x) => x)),
        approveTickets: json["approveTickets"] == null
            ? []
            : List<dynamic>.from(json["approveTickets"]!.map((x) => x)),
        typeAccount: json["typeAccount"],
        userId: json["userId"],
        createdDate: fromJsonTimeStamp(json["createdDate"]),
        birthday: fromJsonTimeStamp(json["birthday"]),
        currentPoint: json["currentPoint"],
        notificationToken: json["notificationToken"],
        hideAge: json["hideAge"],
        cityId: json["cityId"],
        stateId: json["stateId"],
        stateName: json["stateName"],
        cityName: json["cityName"],
        description: json["description"],
        height: json["height"],
        address: json["address"],
        birthPlace: json["birthPlace"],
        education: json["education"],
        annualIncome: json["annualIncome"],
        job: json["job"],
        sake: json["sake"],
        smoke: json["smoke"],
        familyStatus: json["familyStatus"],
        livingFamily: json["livingFamily"],
        hairStyle: json["hairStyle"],
        pointPer30Minutes: json["pointPer30Minutes"],
        hairColor: json["hairColor"],
        tagInformation: json["tagInformation"] == null
            ? []
            : List<dynamic>.from(json["tagInformation"]!.map((x) => x)),
      );

  factory UserModel.fromJsonSaveValue(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        realName: json["realName"],
        displayName: json["displayName"],
        email: json["email"],
        avatar: json["avatar"],
        previewImage: json["previewImage"] == null
            ? []
            : List<dynamic>.from(json["previewImage"]!.map((x) => x)),
        applyTickets: json["applyTickets"] == null
            ? []
            : List<dynamic>.from(json["applyTickets"]!.map((x) => x)),
        approveTickets: json["approveTickets"] == null
            ? []
            : List<dynamic>.from(json["approveTickets"]!.map((x) => x)),
        typeAccount: json["typeAccount"],
        userId: json["userId"],
        createdDate: fromJsonDate(json["createdDate"]),
        birthday: fromJsonDate(json["birthday"]),
        currentPoint: json["currentPoint"],
        hideAge: json["hideAge"],
        cityId: json["cityId"],
        stateId: json["stateId"],
        stateName: json["stateName"],
        cityName: json["cityName"],
        description: json["description"],
        height: json["height"],
        address: json["address"],
        birthPlace: json["birthPlace"],
        education: json["education"],
        annualIncome: json["annualIncome"],
        job: json["job"],
        sake: json["sake"],
        smoke: json["smoke"],
        familyStatus: json["familyStatus"],
        livingFamily: json["livingFamily"],
        hairStyle: json["hairStyle"],
        pointPer30Minutes: json["pointPer30Minutes"],
        hairColor: json["hairColor"],
        tagInformation: json["tagInformation"] == null
            ? []
            : List<dynamic>.from(json["tagInformation"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "realName": realName,
        "userId": userId,
        "displayName": displayName,
        "stateId": stateId,
        "cityId": cityId,
        "stateName": stateName,
        "cityName": cityName,
        "email": email,
        "avatar": avatar,
        "previewImage": List<dynamic>.from(previewImage.map((x) => x)),
        "approveTickets": List<dynamic>.from(approveTickets.map((x) => x)),
        "typeAccount": typeAccount,
        "createdDate": createdDate,
        "birthday": birthday,
        "currentPoint": currentPoint,
        "pointPer30Minutes": pointPer30Minutes,
        "hideAge": hideAge,
        "description": description,
        "height": height,
        "address": address,
        "birthPlace": birthPlace,
        "education": education,
        "annual_income": annualIncome,
        "job": job,
        "sake": sake,
        "smoke": smoke,
        "family_status": familyStatus,
        "livingFamily": livingFamily,
        "hairStyle": hairStyle,
        "hairColor": hairColor,
        "tagInformation": List<dynamic>.from(tagInformation.map((x) => x)),
        "applyTickets": List<dynamic>.from(applyTickets.map((x) => x)),
      };

  Map<String, dynamic> toJsonSaveValue() => {
        "id": id,
        "realName": realName,
        "userId": userId,
        "displayName": displayName,
        "stateId": stateId,
        "cityId": cityId,
        "stateName": stateName,
        "cityName": cityName,
        "email": email,
        "avatar": avatar,
        "previewImage": List<dynamic>.from(previewImage.map((x) => x)),
        "approveTickets": List<dynamic>.from(approveTickets.map((x) => x)),
        "typeAccount": typeAccount,
        "createdDate": createdDate.toString(),
        "birthday": birthday.toString(),
        "currentPoint": currentPoint,
        "pointPer30Minutes": pointPer30Minutes,
        "hideAge": hideAge,
        "description": description,
        "height": height,
        "address": address,
        "birthPlace": birthPlace,
        "education": education,
        "annual_income": annualIncome,
        "job": job,
        "sake": sake,
        "smoke": smoke,
        "family_status": familyStatus,
        "livingFamily": livingFamily,
        "hairStyle": hairStyle,
        "notificationToken": notificationToken,
        "hairColor": hairColor,
        "tagInformation": List<dynamic>.from(tagInformation.map((x) => x)),
        "applyTickets": List<dynamic>.from(applyTickets.map((x) => x)),
      };
}
