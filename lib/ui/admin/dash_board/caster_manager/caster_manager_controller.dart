import 'dart:async';

import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/ui/admin/components/register_user_dialog.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CasterManagerController extends GetxController {
  static CasterManagerController get to => Get.find();
  final list = <UserModel>[].obs;
  int page = 1;
  StreamSubscription? streamSubscription;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) => getData());
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }

  bool checkEmpty() {
    return list.length > page * kPagingSize;
  }

  Future<void> getData() async {
    streamSubscription?.cancel();
    streamSubscription = fireStoreProvider.listenerListUser(
        sort: TypeAccount.caster,
        page: page,
        valueChanged: (query) {
          list.clear();
          final listDoc = query.docs;
          if (listDoc.isNotEmpty) {
            for (var value in listDoc) {
              try {
                final userModel = UserModel.fromJson(value.data());
                list.add(userModel);
              } catch (e) {
                logger.e(e);
              }
            }
          }
          list.refresh();
        });
  }

  Future<void> scrollDown(int i) async {
    page = i;
    await getData();
  }

  Future<void> registerUser() async {
    showCustomDialog(
        minWidth: true,
        widget: RegisterUserDialog(
          setter: (UserModel value) async {
            Get.back(closeOverlays: true);
            final user = await fireStoreProvider.createUser(
              email: value.email!,
              password: value.password!,
            );
            if (user != null) {
              final success = await fireStoreProvider.createUserFireStore(
                  email: value.email,
                  displayName: value.displayName,
                  realName: value.realName,
                  typeAccount: TypeAccount.caster,
                  id: user.uid,
                  userId: value.userId);
              if (success) {
                value.id = user.uid;
                list.add(value);
                showInfo('create_user_success'.tr);
              }
            }
          },
          typeAccount: TypeAccount.caster,
        ));
  }
}
