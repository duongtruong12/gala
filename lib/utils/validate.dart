import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

import 'global/globals_functions.dart';

class Validate {
  static String? phoneValidate(String? phone) {
    final phoneString = phone.toString().trim();
    if (phoneString.isEmpty) {
      return "msg_phone_empty".tr;
    } else if (phoneString.length < 10) {
      return "msg_phone_minLength".tr;
    } else if (!isNumeric(phoneString)) {
      return "msg_phone_number_only".tr;
    }
    return null;
  }

  static String? nameValidate(String? address) {
    if (address == null || address.isEmpty) {
      return sprintf('error_empty'.tr, ['name'.tr]);
    }
    return null;
  }

  static String? emptyValidate({required String? str, required String field}) {
    if (str == null || str.isEmpty) {
      return sprintf('error_empty'.tr, [field]);
    }

    return null;
  }

  static String? validateUserId(String? str) {
    if (str == null || str.isEmpty) {
      return sprintf('error_empty'.tr, ['user_id'.tr]);
    }

    const userIdPattern =
        r'^(?=[a-zA-Z0-9._]{3,20}$)(?!.*[_.]{2})[^_.].*[^_.]$';
    RegExp regExp = RegExp(userIdPattern);

    if (!regExp.hasMatch(str)) {
      return "msg_userId_format".tr;
    }
    return null;
  }

  // validate confirm password
  static String? passwordConfirmValidate(
      {required String password, required String? confPass}) {
    final confPassString = confPass.toString();

    if (confPassString.isEmpty) {
      return "msg_pass_empty".tr;
    } else if (confPassString.length < 6) {
      return "msg_pass_minLength".tr;
    } else if (password != confPass) {
      return "msg_confirm_new_password_not_match".tr;
    }
    return null;
  }

  // validate password
  static String? oldPasswordValidate(String? newPassword, String oldPassword) {
    final passwordString = newPassword.toString();
    if (passwordString.isEmpty) {
      return "msg_pass_empty".tr;
    } else if (passwordString.length < 6) {
      return "msg_pass_minLength".tr;
    } else if (generateMd5(passwordString) != oldPassword) {
      return "msg_old_pass_new_pass".tr;
    }
    return null;
  }

  // validate password
  static String? passwordValidate(String? password) {
    final passwordString = password.toString();
    if (passwordString.isEmpty) {
      return "msg_pass_empty".tr;
    } else if (passwordString.length < 6) {
      return "msg_pass_minLength".tr;
    }
    return null;
  }

  static String? emailValidate(String? email, {bool checkEmpty = true}) {
    final emailString = email.toString().trim();
    const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}';
    RegExp regExp = RegExp(emailPattern);

    if (checkEmpty) {
      if (emailString.isEmpty) {
        return "msg_email_empty".tr;
      } else if (!regExp.hasMatch(emailString)) {
        return "msg_email_format".tr;
      }
    } else {
      if (emailString.isNotEmpty && !regExp.hasMatch(emailString)) {
        return "msg_email_format".tr;
      }
    }
    return null;
  }

  static String? numberValidate(String? str, String name) {
    if (str == null || str.isEmpty) {
      return sprintf('error_empty'.tr, [name]);
    } else if (!isNumeric(str)) {
      return sprintf('error_number_validate'.tr, [name]);
    }
    return null;
  }

  static String? pointWithdrawal(String? str) {
    if (str == null || str.isEmpty) {
      return sprintf('error_empty'.tr, ['attendance_point'.tr]);
    } else if (!isNumeric(str)) {
      return sprintf('error_number_validate'.tr, ['attendance_point'.tr]);
    } else if ((num.parse(str) + DefaultFee.transfer) >
        (user.value?.currentPoint ?? 0)) {
      return 'point_bigger'.tr;
    }
    return null;
  }
}
