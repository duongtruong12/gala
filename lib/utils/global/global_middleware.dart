import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GlobalMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (route == Routes.login) {
      return null;
    }

    if (user.value != null) {
      return null;
    }

    final box = GetStorage();
    final str = box.read(SharedPrefKey.user);
    if (str?.isNotEmpty == true) {
      user.value = userModelFromJsonSaveValue(str!);
    } else {
      return const RouteSettings(name: Routes.login);
    }
    return null;
  }
}
