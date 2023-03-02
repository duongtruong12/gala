import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/ui/admin/components/register_user_dialog.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CasterManagerController extends GetxController {
  static CasterManagerController get to => Get.find();
  final list = <UserModel>[].obs;
  final isEmpty = false.obs;
  DocumentSnapshot? lastDoc;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) => getData());
  }

  Future<void> getData() async {
    final listDoc = await fireStoreProvider.getListUser(
        lastDocument: lastDoc, sort: TypeAccount.caster);
    if (listDoc.isNotEmpty) {
      lastDoc = listDoc.last;
      for (var value in listDoc) {
        try {
          if (value.data() != null) {
            final userModel = UserModel.fromJson(value.data()!);
            list.add(userModel);
          }
        } catch (e) {
          logger.e(e);
        }
      }
    } else {
      isEmpty.value = true;
    }
    list.refresh();
  }

  Future<void> scrollDown(int i) async {
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
