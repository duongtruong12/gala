// To parse this JSON data, do
//
//     final femaleModel = femaleModelFromJson(jsonString);

import 'dart:convert';

FemaleModel femaleModelFromJson(String str) =>
    FemaleModel.fromJson(json.decode(str));

String femaleModelToJson(FemaleModel data) => json.encode(data.toJson());

class FemaleModel {
  FemaleModel({
    this.id,
    this.age,
    this.displayName,
    this.point,
    this.avatar,
    this.previewImages,
    this.tags,
    this.description,
    this.height,
    this.address,
    this.birthPlace,
    this.education,
    this.job,
    this.canDrink,
    this.canSmoke,
    this.siblings,
    this.liveFamily,
    this.hairStyle,
    this.hairColor,
  });

  String? id;
  int? age;
  String? displayName;
  int? point;
  String? avatar;
  List<String>? previewImages;
  List<String>? tags;
  String? description;
  int? height;
  String? address;
  String? birthPlace;
  String? education;
  String? job;
  bool? canDrink;
  bool? canSmoke;
  String? siblings;
  bool? liveFamily;
  String? hairStyle;
  String? hairColor;

  factory FemaleModel.fromJson(Map<String, dynamic> json) => FemaleModel(
        id: json["id"],
        age: json["age"],
        displayName: json["display_name"],
        point: json["point"],
        avatar: json["avatar"],
        previewImages: json["preview_images"] == null
            ? []
            : List<String>.from(json["preview_images"]!.map((x) => x)),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        description: json["description"],
        height: json["height"],
        address: json["address"],
        birthPlace: json["birth_place"],
        education: json["education"],
        job: json["job"],
        canDrink: json["can_drink"],
        canSmoke: json["can_smoke"],
        siblings: json["siblings"],
        liveFamily: json["live_family"],
        hairStyle: json["hair_style"],
        hairColor: json["hair_color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "age": age,
        "display_name": displayName,
        "point": point,
        "avatar": avatar,
        "preview_images": previewImages == null
            ? []
            : List<dynamic>.from(previewImages!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "description": description,
        "height": height,
        "address": address,
        "birth_place": birthPlace,
        "education": education,
        "job": job,
        "can_drink": canDrink,
        "can_smoke": canSmoke,
        "siblings": siblings,
        "live_family": liveFamily,
        "hair_style": hairStyle,
        "hair_color": hairColor,
      };
}
