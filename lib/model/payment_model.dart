// To parse this JSON data, do
//
//     final PaymentModel = PaymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  PaymentModel({
    this.id,
    this.cardExpiredDate,
    this.cardNumber,
    this.cardCVV,
  });

  String? id;
  String? cardNumber;
  String? cardExpiredDate;
  String? cardCVV;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        cardNumber: json["cardNumber"],
        cardExpiredDate: json["cardExpiredDate"],
        cardCVV: json["cardCVV"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cardCVV": cardCVV,
        "cardExpiredDate": cardExpiredDate,
        "cardNumber": cardNumber,
      };
}
