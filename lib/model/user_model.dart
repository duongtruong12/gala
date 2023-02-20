// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:base_flutter/utils/constant.dart';
import 'package:get/get.dart';

import 'json_parse/date_to_string.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.realName,
    this.displayName,
    this.password,
    this.email,
    this.avatar,
    required this.previewImage,
    required this.applyTickets,
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
    this.isDrink,
    this.isSmoke,
    this.familyStatus,
    this.livingWithFamily,
    this.hairStyle,
    this.hairColor,
  });

  String? id;
  String? realName;
  String? displayName;
  String? password;
  String? email;
  String? avatar;
  List<dynamic> previewImage;
  List<dynamic> applyTickets;
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
  int? annualIncome;
  String? job;
  bool? isDrink;
  bool? isSmoke;
  String? familyStatus;
  bool? livingWithFamily;
  String? hairStyle;
  String? hairColor;
  List<dynamic> tagInformation;
  DateTime? createdDate;
  DateTime? birthday;

  bool isAdminAccount() {
    return typeAccount == TypeAccount.admin.name;
  }

  String getTextSmoke() {
    if (isSmoke != null) {
      if (isSmoke == true) {
        return 'smoke_can'.tr;
      } else {
        return 'smoke_cannot'.tr;
      }
    }
    return 'not_entered'.tr;
  }

  String getTextDrink() {
    if (isDrink != null) {
      if (isDrink == true) {
        return 'sake_can'.tr;
      } else {
        return 'sake_cannot'.tr;
      }
    }
    return 'not_entered'.tr;
  }

  String getTextLiveFamily() {
    if (livingWithFamily != null) {
      if (livingWithFamily == true) {
        return 'living_family_with'.tr;
      } else {
        return 'living_family_alone'.tr;
      }
    }
    return 'not_entered'.tr;
  }

  String getAge() {
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
        typeAccount: json["typeAccount"],
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
        isDrink: json["isDrink"],
        isSmoke: json["isSmoke"],
        familyStatus: json["familyStatus"],
        livingWithFamily: json["livingWithFamily"],
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
        "displayName": displayName,
        "stateId": stateId,
        "cityId": cityId,
        "stateName": stateName,
        "cityName": cityName,
        "email": email,
        "avatar": avatar,
        "previewImage": List<dynamic>.from(previewImage.map((x) => x)),
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
        "isDrink": isDrink,
        "isSmoke": isSmoke,
        "family_status": familyStatus,
        "livingWithFamily": livingWithFamily,
        "hairStyle": hairStyle,
        "hairColor": hairColor,
        "tagInformation": List<dynamic>.from(tagInformation.map((x) => x)),
        "applyTickets": List<dynamic>.from(applyTickets.map((x) => x)),
      };
}

extension ExtensionDateTime on DateTime {
  String? toJson() => toString();
}
