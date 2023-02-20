import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find();
  final list = <UserModel>[].obs;
  final isEmpty = false.obs;
  DocumentSnapshot? lastDoc;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) => onRefresh(1));
  }

  Future<void> getData() async {
    final type = casterAccount.value ? TypeAccount.guest : TypeAccount.caster;
    final listDoc =
        await fireStoreProvider.getListUser(lastDocument: lastDoc, sort: type);
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

  Future<void> onRefresh(int index) async {
    list.clear();
    lastDoc = null;
    isEmpty.value = false;
    await getData();
  }

  Future<void> onScrollDown(int i) async {
    await getData();
  }

  void onSwitchSearchDetail() {
    Get.toNamed(Routes.searchDetail, id: getRouteSearch());
  }

  void onSwitchFemaleDetail(String? id) {
    Get.toNamed(Routes.userDetail, parameters: {'id': '$id'}, arguments: true);
  }
}
