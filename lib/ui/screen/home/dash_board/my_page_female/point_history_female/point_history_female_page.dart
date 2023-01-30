import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/components/paging_list.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/point_history/components/item_point_history.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/point_history/components/point_widget.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'point_history_female_controller.dart';

class PointHistoryFemale extends GetView<PointHistoryFemaleController> {
  const PointHistoryFemale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: PointHistoryFemaleMobilePage(controller: controller),
      desktop: PointHistoryFemaleMobilePage(controller: controller),
    ));
  }
}

class PointHistoryFemaleMobilePage extends StatelessWidget {
  const PointHistoryFemaleMobilePage({super.key, required this.controller});

  final PointHistoryFemaleController controller;

  Widget _buildList() {
    return PagingListCustom(
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
          const PointWidget(
            point: 10000,
            onPressed: null,
          ),
          const SizedBox(height: kDefaultPadding),
          Expanded(child: Obx(() {
            return controller.loading.value
                ? const Center(
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator()),
                  )
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
