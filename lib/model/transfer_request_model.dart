// To parse this JSON data, do
//
//     final TransferRequestModel = TransferRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:base_flutter/model/transfer_information_model.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';

TransferRequestModel transferRequestModelFromJson(String str) =>
    TransferRequestModel.fromJson(json.decode(str));

String transferRequestModelToJson(TransferRequestModel data) =>
    json.encode(data.toJson());

class TransferRequestModel {
  TransferRequestModel({
    this.id,
    this.createdDate,
    this.status,
    this.createdId,
    this.totalPrice,
    this.requestPoint,
    this.transferFee,
    this.transferInformationModel,
  });

  String? id;
  String? status;
  String? createdId;
  TransferInformationModel? transferInformationModel;
  num? totalPrice;
  num? requestPoint;
  num? transferFee;
  DateTime? createdDate;

  factory TransferRequestModel.fromJson(Map<String, dynamic> json) =>
      TransferRequestModel(
        id: json["id"],
        status: json["status"],
        createdId: json["createdId"],
        transferInformationModel: json["transferInformationModel"] != null
            ? TransferInformationModel.fromJson(
                json["transferInformationModel"])
            : null,
        totalPrice: json["totalPrice"],
        requestPoint: json["requestPoint"],
        transferFee: json["transferFee"],
        createdDate: dateTimeFromTimestamp(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "createdId": createdId,
        "transferInformationModel": transferInformationModel?.toJson(),
        "totalPrice": totalPrice,
        "requestPoint": requestPoint,
        "transferFee": transferFee,
        "createdDate": createdDate,
      };
}
