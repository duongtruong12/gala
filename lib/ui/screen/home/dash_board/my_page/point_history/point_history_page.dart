import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/components/paging_list.dart';
import 'package:base_flutter/model/purchase_model.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/item_point_history.dart';
import 'components/point_widget.dart';
import 'point_history_controller.dart';

class PointHistory extends GetView<PointHistoryController> {
  const PointHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: PointHistoryMobilePage(controller: controller),
      desktop: PointHistoryMobilePage(controller: controller),
    ));
  }
}

class PointHistoryMobilePage extends StatelessWidget {
  const PointHistoryMobilePage({super.key, required this.controller});

  final PointHistoryController controller;

  Widget _buildItemPurchase(PurchaseModel model) {
    return InkWell(
      onTap: () {
        controller.requestPayment(model.cost, model.point);
      },
      child: Column(
        children: [
          const SizedBox(height: kSmallPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  formatCurrency(model.point, symbol: CurrencySymbol.pointFull),
                  style: tNormalTextStyle.copyWith(
                    color: kTextColorSecond,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: 30,
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                decoration: const BoxDecoration(color: kPurchaseColor),
                child: Text(
                  formatCurrency(model.cost, symbol: CurrencySymbol.japan),
                  style: tNormalTextStyle.copyWith(
                    color: kTextColorSecond,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: kSmallPadding),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildListPurchase() {
    return PagingListCustom(
        childWidget: controller.listPurchase
            .map((element) => _buildItemPurchase(element))
            .toList());
  }

  Widget _buildList() {
    if (controller.list.isEmpty) {
      return textEmpty();
    }
    return PagingListCustom(
      onScrollDown: controller.onScrollDown,
      onRefresh: controller.onRefresh,
      isEmpty: controller.isEmpty.value,
      childWidget: controller.list
          .map((element) => ItemPointHistory(model: element))
          .toList(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          const SizedBox(height: kDefaultPadding),
          Obx(() {
            return PointWidget(
              point: user.value?.currentPoint,
              onPressed:
                  controller.purchase.value ? null : controller.switchPurchase,
            );
          }),
          const SizedBox(height: kDefaultPadding),
          Expanded(child: Obx(() {
            return controller.purchase.value
                ? _buildListPurchase()
                : _buildList();
          })),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
          title: Text('point_history'.tr),
          leadingWidth: 100,
          leading: backButtonText(callback: controller.onPressedBack)),
      body: _buildBody(),
    );
  }
}
