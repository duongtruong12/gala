import 'package:base_flutter/model/point_cost_model.dart';
import 'package:base_flutter/model/purchase_model.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:get/get.dart';

class PointHistoryController extends GetxController {
  static PointHistoryController get to => Get.find();
  final list = <PointCostModel>[].obs;
  final listPurchase = <PurchaseModel>[].obs;
  final loading = true.obs;
  final purchase = false.obs;

  @override
  void onInit() {
    super.onInit();
    _installList();
  }

  Future<void> _installList() async {
    loading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    listPurchase.add(PurchaseModel(id: '1000', point: 1000, cost: 1200));
    listPurchase.add(PurchaseModel(id: '3000', point: 3000, cost: 3600));
    listPurchase.add(PurchaseModel(id: '5000', point: 5000, cost: 6000));
    listPurchase.add(PurchaseModel(id: '10000', point: 10000, cost: 12000));
    listPurchase.add(PurchaseModel(id: '30000', point: 30000, cost: 36000));
    listPurchase.add(PurchaseModel(id: '50000', point: 50000, cost: 60000));
    listPurchase.add(PurchaseModel(id: '100000', point: 100000, cost: 120000));
    listPurchase.add(PurchaseModel(id: '200000', point: 200000, cost: 240000));
    listPurchase.add(PurchaseModel(id: '300000', point: 300000, cost: 360000));
    listPurchase.add(PurchaseModel(id: '400000', point: 400000, cost: 480000));
    loading.value = false;
  }

  void switchPurchase() {
    purchase.value = !purchase.value;
  }

  void onPressedBack() {
    if (purchase.value) {
      purchase.value = false;
    } else {
      Get.back(id: getRouteMyPage());
    }
  }
}
