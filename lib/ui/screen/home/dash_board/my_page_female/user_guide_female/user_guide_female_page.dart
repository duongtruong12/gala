import 'package:base_flutter/components/background.dart';
import 'package:base_flutter/components/custom_appbar.dart';
import 'package:base_flutter/components/custom_view.dart';
import 'package:base_flutter/components/tab_bar_custom.dart';
import 'package:base_flutter/components/ticket_view.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/ui/responsive.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'user_guide_female_controller.dart';

class UserGuideFemale extends GetView<UserGuideFemaleController> {
  const UserGuideFemale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Responsive(
      mobile: UserGuideMobilePage(controller: controller),
      desktop: UserGuideMobilePage(controller: controller),
    ));
  }
}

class UserGuideMobilePage extends StatelessWidget {
  const UserGuideMobilePage({super.key, required this.controller});

  final UserGuideFemaleController controller;

  Widget _buildListView(TicketPage page) {
    return Obx(() {
      late List<Ticket> list;
      switch (page) {
        case TicketPage.apply:
          list = controller.listApplyTicket;
          break;
        case TicketPage.current:
          list = controller.listCurrentTicket;
          break;
        case TicketPage.past:
          list = controller.listPastTicket;
          break;
      }
      if (list.isEmpty) {
        return textEmpty();
      }
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          final e = list[index];
          return TicketView(model: e);
        },
      );
    });
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          const SizedBox(height: kDefaultPadding),
          Text(
            'call_list'.tr,
            style: tNormalTextStyle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: kDefaultPadding),
          TabBarCustom(
            controller: controller.tabController,
            padding: 0,
            tabs: [
              Tab(
                child: Text(
                  'wanted_call'.tr,
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  'current_call'.tr,
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  'past_call'.tr,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding),
          Expanded(
              child: TabBarView(
            controller: controller.tabController,
            children: [
              _buildListView(TicketPage.apply),
              _buildListView(TicketPage.current),
              _buildListView(TicketPage.past),
            ],
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarCustom(
          title: Text('user_guide'.tr),
          leadingWidth: 100,
          leading: backButtonText(callback: controller.onPressedBack)),
      body: _buildBody(),
    );
  }
}
