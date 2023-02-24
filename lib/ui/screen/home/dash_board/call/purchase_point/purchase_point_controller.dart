import 'package:base_flutter/model/purchase_model.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/point_history/components/payment_dialog.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class PurchasePointController extends GetxController {
  static PurchasePointController get to => Get.find();
  final listPurchase = <PurchaseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      installDataListPurchase();
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

  void onPressedBack() {
    Get.back(id: RouteId.call);
  }

  Future<void> requestPayment(int? cost, int? point) async {
    if (cost == null) return;
    await showCustomDialog(
      widget: PaymentDialog(cost: cost, point: point),
    );
  }
}
