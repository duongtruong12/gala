import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/paging_list.dart';
import 'package:base_flutter/components/ticket_view.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'search_call_controller.dart';

class SearchCallPage extends GetView<SearchCallController> {
  const SearchCallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: SearchCallMobilePage(controller: controller),
      desktop: SearchCallMobilePage(controller: controller),
    ));
  }
}

class SearchCallMobilePage extends StatelessWidget {
  const SearchCallMobilePage({super.key, required this.controller});

  final SearchCallController controller;

  Widget _buildListView() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: PagingListCustom(
            onRefresh: controller.onRefresh,
            onScrollDown: controller.onScrollDown,
            childWidget:
                controller.list.map((e) => TicketView(model: e)).toList()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
          leading: BackButton(
            onPressed: controller.onPressedBack,
          ),
          title: Text(formatDateTime(
              date: controller.date,
              formatString: DateTimeFormatString.textBehindddMM))),
      body: _buildListView(),
    );
  }
}
