import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/tab_bar_custom.dart';
import 'package:base_flutter/components/ticket_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'call_female_controller.dart';

class CallFemalePage extends GetView<CallFemaleController> {
  const CallFemalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: CallMobilePage(controller: controller),
      desktop: CallMobilePage(controller: controller),
    ));
  }
}

class CallMobilePage extends StatelessWidget {
  const CallMobilePage({super.key, required this.controller});

  final CallFemaleController controller;

  Widget _buildListView() {
    return Obx(() {
      return ListView.builder(
        padding: const EdgeInsets.all(kDefaultPadding),
        itemCount: controller.list.length,
        itemBuilder: (BuildContext context, int index) {
          final e = controller.list[index];
          return TicketView(model: e);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
        title: Text('call_cast'.tr),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.showPickerDate,
        child: getSvgImage('ic_calendar'),
        backgroundColor: kPrimaryColorFemale,
      ),
      body: Column(
        children: [
          const SizedBox(height: kDefaultPadding),
          TabBarCustom(
            controller: controller.tabController,
            tabs: [
              Tab(
                  text:
                      '${'today'.tr}(${formatDateTime(date: DateTime.now(), formatString: DateTimeFormatString.textBehindddMM)})'),
              Tab(text: 'next_day'.tr),
            ],
          ),
          Expanded(
              child: TabBarView(
            controller: controller.tabController,
            children: [
              _buildListView(),
              _buildListView(),
            ],
          ))
        ],
      ),
    );
  }
}
