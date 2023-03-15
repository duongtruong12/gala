import 'dart:async';

import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CallListController extends GetxController {
  static CallListController get to => Get.find();

  final listStatus = <String>[
    TicketStatus.all.name,
    TicketStatus.created.name,
    TicketStatus.done.name,
    TicketStatus.finish.name,
    TicketStatus.cancelled.name,
  ];

  final currentStatus = TicketStatus.all.name.obs;

  final list = <Ticket>[].obs;
  int page = 1;
  StreamSubscription? streamSubscription;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    super.onClose();
  }

  bool checkEmpty() {
    return (page * kPagingSize) > list.length;
  }

  Future<void> getData() async {
    streamSubscription?.cancel();
    streamSubscription = fireStoreProvider.listenerListTicker(
        dateTime: DateTime.now(),
        queryAll: true,
        status: currentStatus.value,
        valueChanged: (listDoc) {
          list.clear();
          if (listDoc.docs.isNotEmpty) {
            for (var value in listDoc.docs) {
              try {
                final messageModel = Ticket.fromJson(value.data());
                list.add(messageModel);
              } catch (e) {
                logger.e(e);
              }
            }
          }

          list.sort((a, b) =>
              b.createdDate?.millisecondsSinceEpoch
                  .compareTo(a.createdDate?.millisecondsSinceEpoch ?? 0) ??
              0);

          list.refresh();
        },
        page: page);
  }

  Future<void> onScrollDown(int index) async {
    page = index;
    await getData();
  }

  Future<void> onChangeStatus(String? str) async {
    currentStatus.value = str ?? TicketStatus.created.name;
    page = 1;
    await getData();
  }

  Future<void> switchTicket(Ticket model) async {
    streamSubscription?.pause();
    await Get.toNamed(Routes.ticketDetail,
        parameters: {'id': '${model.id}'}, arguments: true);
    streamSubscription?.resume();
  }
}
