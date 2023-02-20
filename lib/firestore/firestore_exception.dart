import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FireStoreException implements FirebaseException {
  FireStoreException(this.code, [this.message, this.stackTrace]);

  @override
  final String code;
  @override
  final String? message;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    if (code.tr == code) {
      showError('error_default'.tr);
    } else {
      showError(code.tr);
    }

    if (message == null) {
      return 'FireStoreException\n$stackTrace';
    }

    return 'FireStoreException $code: $message\n$stackTrace';
  }

  @override
  String get plugin => 'cloud_firestore';
}
