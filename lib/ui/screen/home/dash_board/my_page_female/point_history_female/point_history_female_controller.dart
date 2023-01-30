import 'package:base_flutter/model/point_cost_model.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PointHistoryFemaleController extends GetxController {
  static PointHistoryFemaleController get to => Get.find();
  final list = <PointCostModel>[].obs;
  final loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _installList();
  }

  Future<void> _installList() async {
    loading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    list.add(PointCostModel(
        id: '1',
        point: -1000,
        reason: PointReason.pay.name,
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)));
    list.add(PointCostModel(
        id: '2',
        point: -3000,
        reason: PointReason.gift.name,
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)));
    list.add(PointCostModel(
        id: '1',
        point: 10000,
        reason: PointReason.buy.name,
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)));
    list.add(PointCostModel(
        id: '1',
        point: -2300,
        reason: PointReason.remittancePayment.name,
        status: TransferStatus.waiting.name,
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)));
    list.add(PointCostModel(
        id: '1',
        point: -2300,
        reason: PointReason.remittancePayment.name,
        status: TransferStatus.received.name,
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)));
    list.add(PointCostModel(
        id: '1',
        point: -2300,
        reason: PointReason.remittancePayment.name,
        status: TransferStatus.alreadyTransfer.name,
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)));
    list.add(PointCostModel(
        id: '1',
        point: -2300,
        reason: PointReason.remittancePayment.name,
        status: TransferStatus.cancel.name,
        createTime: Timestamp.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch)));
    loading.value = false;
  }

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }
}
