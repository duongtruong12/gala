import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

import 'global/globals_functions.dart';

class Validate {
  static const passwordPattern =
      r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])([a-zA-Z0-9!@#$%^&*()_+-=]+)$';

  // email validate
  final String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}';

  // name validate: special character, number
  final String namePattern =
      r'[ぁ-ゖ]|[ァ-ヷ]|ー|[ぁ-ゖァ-ヷ]|[ｧ-ﾝﾞﾟ]|[一-龥]|[一-龥ぁ-ゖ]|[ぁ-ゖァ-ヷ一-龥]|[a-zA-Z]|[ａ-ｚＡ-Ｚ]|ー|々|\s';

  // validate email userID
  String? emailIDValidate(String email) {
    final emailString = email.toString().trim();

    RegExp regExp = RegExp(emailPattern);

    if (emailString.isEmpty) {
      return "msg_userId_empty".tr;
    } else if (emailString.length > 255) {
      return "msg_userId_maxLength".tr;
    } else if (!regExp.hasMatch(emailString)) {
      return "msg_userId_format".tr;
    }
    return null;
  }

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

  // validate confirm password
  static String? passwordConfirmValidate(
      {required String password, required String confPass}) {
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
  static String? oldPasswordValidate(String? oldPassword, String password) {
    final passwordString = oldPassword.toString();
    if (passwordString.isEmpty) {
      return "msg_pass_empty".tr;
    } else if (passwordString.length < 6) {
      return "msg_pass_minLength".tr;
    } else if (oldPassword != password) {
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

  // validate phone number
  static String? userValidate(String? phone) {
    final phoneString = phone.toString().trim();
    RegExp regExp = RegExp(r'^[0-9\-\+]{9,15}$');
    if (phoneString.isEmpty) {
      return "msg_phone_empty".tr;
    } else if (!regExp.hasMatch(phoneString)) {
      return 'msg_phone_validate'.tr;
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
}
