import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/components/paging_list.dart';
import 'package:base_flutter/model/purchase_model.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/point_history/components/point_widget.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'purchase_point_controller.dart';

class PurchasePointPage extends GetView<PurchasePointController> {
  const PurchasePointPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: PurchasePointMobilePage(controller: controller),
      desktop: PurchasePointMobilePage(controller: controller),
    ));
  }
}

class PurchasePointMobilePage extends StatelessWidget {
  const PurchasePointMobilePage({super.key, required this.controller});

  final PurchasePointController controller;

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

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          const SizedBox(height: kDefaultPadding),
          Obx(() {
            return PointWidget(
              point: user.value?.currentPoint,
              onPressed: null,
            );
          }),
          const SizedBox(height: kDefaultPadding),
          Expanded(child: Obx(() {
            return PagingListCustom(
                childWidget: controller.listPurchase
                    .map((element) => _buildItemPurchase(element))
                    .toList());
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
