import 'package:base_flutter/model/point_cost_model.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class PointHistoryFemaleController extends GetxController {
  static PointHistoryFemaleController get to => Get.find();
  final list = <PointCostModel>[].obs;
  final isEmpty = false.obs;
  DocumentSnapshot? lastDoc;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  Future<void> getData() async {
    final listDoc =
        await fireStoreProvider.getPointHistory(lastDocument: lastDoc);
    if (listDoc.isNotEmpty) {
      lastDoc = listDoc.last;
      for (var value in listDoc) {
        try {
          if (value.data() != null) {
            final userModel = PointCostModel.fromJson(value.data()!);
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

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }
}
