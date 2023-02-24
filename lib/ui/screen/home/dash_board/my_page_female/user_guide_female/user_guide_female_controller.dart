import 'dart:async';

import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

enum TicketPage {
  apply,
  current,
  past,
}

class UserGuideFemaleController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static UserGuideFemaleController get to => Get.find();

  late TabController tabController;
  final listApplyTicket = <Ticket>[].obs;
  final listCurrentTicket = <Ticket>[].obs;
  final listPastTicket = <Ticket>[].obs;
  int pageApply = 1;
  int pageCurrent = 1;
  int pagePast = 1;
  StreamSubscription? streamSubscriptionApply;
  StreamSubscription? streamSubscriptionCurrent;
  StreamSubscription? streamSubscriptionPast;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 3);
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getData(TicketPage.apply);
      getData(TicketPage.current);
      getData(TicketPage.past);
    });
  }

  @override
  void onClose() {
    cancel();
    super.onClose();
  }

  void cancel() {
    streamSubscriptionApply?.cancel();
    streamSubscriptionCurrent?.cancel();
    streamSubscriptionPast?.cancel();
  }

  TicketPage getTicketPage() {
    switch (tabController.index) {
      case 0:
        return TicketPage.apply;
      case 1:
        return TicketPage.current;
      default:
        return TicketPage.past;
    }
  }

  Future<void> onRefresh(int index) async {
    final page = getTicketPage();
    if (page == TicketPage.apply) {
      pageApply = 1;
    } else if (page == TicketPage.current) {
      pageCurrent = 1;
    } else {
      pagePast = 1;
    }
    await getData(page);
  }

  Future<void> onScrollDown(int index) async {
    final page = getTicketPage();
    if (page == TicketPage.apply) {
      pageApply = index;
    } else if (page == TicketPage.current) {
      pageCurrent = index;
    } else {
      pagePast = index;
    }
    await getData(page);
  }

  bool checkEmpty() {
    final page = getTicketPage();
    if (page == TicketPage.apply) {
      return listApplyTicket.length > pageApply * kPagingSize;
    } else if (page == TicketPage.current) {
      return listCurrentTicket.length > pageCurrent * kPagingSize;
    } else {
      return listPastTicket.length > pagePast * kPagingSize;
    }
  }

  Future<void> getData(TicketPage page) async {
    switch (page) {
      case TicketPage.apply:
        streamSubscriptionApply?.cancel();
        streamSubscriptionApply = fireStoreProvider.listenerHistoryTicker(
            valueChanged: (listDoc) {
              listApplyTicket.clear();
              if (listDoc.docs.isNotEmpty) {
                for (var value in listDoc.docs) {
                  try {
                    final messageModel = Ticket.fromJson(value.data());
                    listApplyTicket.add(messageModel);
                  } catch (e) {
                    logger.e(e);
                  }
                }
              }
              listApplyTicket.sort((a, b) =>
                  a.createdDate?.millisecondsSinceEpoch
                      .compareTo(b.createdDate?.millisecondsSinceEpoch ?? 0) ??
                  0);

              listApplyTicket.refresh();
            },
            ticketPage: page,
            page: pageApply);
        break;
      case TicketPage.current:
        streamSubscriptionCurrent?.cancel();
        streamSubscriptionCurrent = fireStoreProvider.listenerHistoryTicker(
            valueChanged: (listDoc) {
              listCurrentTicket.clear();
              if (listDoc.docs.isNotEmpty) {
                for (var value in listDoc.docs) {
                  try {
                    final messageModel = Ticket.fromJson(value.data());
                    listCurrentTicket.add(messageModel);
                  } catch (e) {
                    logger.e(e);
                  }
                }
              }
              listCurrentTicket.sort((a, b) =>
                  a.createdDate?.millisecondsSinceEpoch
                      .compareTo(b.createdDate?.millisecondsSinceEpoch ?? 0) ??
                  0);

              listCurrentTicket.refresh();
            },
            ticketPage: page,
            page: pageCurrent);
        break;
      default:
        streamSubscriptionPast?.cancel();
        streamSubscriptionPast = fireStoreProvider.listenerHistoryTicker(
            valueChanged: (listDoc) {
              listPastTicket.clear();
              if (listDoc.docs.isNotEmpty) {
                for (var value in listDoc.docs) {
                  try {
                    final messageModel = Ticket.fromJson(value.data());
                    listPastTicket.add(messageModel);
                  } catch (e) {
                    logger.e(e);
                  }
                }
              }
              listPastTicket.sort((a, b) =>
                  a.createdDate?.millisecondsSinceEpoch
                      .compareTo(b.createdDate?.millisecondsSinceEpoch ?? 0) ??
                  0);

              listPastTicket.refresh();
            },
            ticketPage: page,
            page: pagePast);
        break;
    }
  }

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }
}
