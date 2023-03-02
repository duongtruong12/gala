// To parse this JSON data, do
//
//     final TransferInformationModel = TransferInformationModelFromJson(jsonString);

import 'dart:convert';

TransferInformationModel transferInformationModelFromJson(String str) =>
    TransferInformationModel.fromJson(json.decode(str));

String transferInformationModelToJson(TransferInformationModel data) =>
    json.encode(data.toJson());

class TransferInformationModel {
  TransferInformationModel({
    this.id,
    this.bankName,
    this.branchCode,
    this.bankNumber,
    this.lastName,
    this.firstName,
    this.bankType,
  });

  String? id;
  String? bankName;
  String? branchCode;
  String? bankNumber;
  String? lastName;
  String? firstName;
  String? bankType;

  factory TransferInformationModel.fromJson(Map<String, dynamic> json) =>
      TransferInformationModel(
        id: json["id"],
        bankName: json["bankName"],
        branchCode: json["branchCode"],
        bankNumber: json["bankNumber"],
        lastName: json["lastName"],
        firstName: json["firstName"],
        bankType: json["bankType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bankName": bankName,
        "branchCode": branchCode,
        "bankNumber": bankNumber,
        "lastName": lastName,
        "firstName": firstName,
        "bankType": bankType,
      };
}
