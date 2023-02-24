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
    this.brand,
    this.expiryYear,
    this.postalCode,
    this.expiryMonth,
    this.number,
    this.cvc,
  });

  String? id;
  String? brand;
  String? number;
  String? postalCode;
  int? expiryMonth;
  int? expiryYear;
  String? cvc;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        brand: json["brand"],
        number: json["number"],
        postalCode: json["postalCode"],
        expiryMonth: json["expiryMonth"],
        expiryYear: json["expiryYear"],
        cvc: json["cvc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand,
        "cvc": cvc,
        "number": number,
        "postalCode": postalCode,
        "expiryMonth": expiryMonth,
        "expiryYear": expiryYear,
      };
}
