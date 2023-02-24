import 'package:base_flutter/model/point_cost_model.dart';
import 'package:base_flutter/model/purchase_model.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'components/payment_dialog.dart';

class PointHistoryController extends GetxController {
  static PointHistoryController get to => Get.find();
  final list = <PointCostModel>[].obs;
  final listPurchase = <PurchaseModel>[].obs;
  final loading = true.obs;
  final purchase = false.obs;
  final isEmpty = false.obs;

  DocumentSnapshot? lastDoc;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  void installDataListPurchase() {
    listPurchase.add(PurchaseModel(point: 1200, cost: 1000));
    listPurchase.add(PurchaseModel(point: 3600, cost: 3000));
    listPurchase.add(PurchaseModel(point: 6000, cost: 5000));
    listPurchase.add(PurchaseModel(point: 12000, cost: 10000));
    listPurchase.add(PurchaseModel(point: 36000, cost: 30000));
    listPurchase.add(PurchaseModel(point: 60000, cost: 50000));
    listPurchase.add(PurchaseModel(point: 120000, cost: 100000));
    listPurchase.add(PurchaseModel(point: 240000, cost: 200000));
    listPurchase.add(PurchaseModel(point: 360000, cost: 300000));
    listPurchase.add(PurchaseModel(point: 480000, cost: 400000));
  }

  Future<void> getData() async {
    installDataListPurchase();
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

  void switchPurchase() {
    purchase.value = !purchase.value;
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
    if (purchase.value) {
      purchase.value = false;
    } else {
      Get.back(id: getRouteMyPage());
    }
  }

  Future<void> requestPayment(int? cost, int? point) async {
    if (cost == null) return;
    await showCustomDialog(
      widget: PaymentDialog(cost: cost, point: point),
    );
  }
}
