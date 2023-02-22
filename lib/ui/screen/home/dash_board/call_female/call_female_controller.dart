import 'dart:async';

import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import 'components/find_date_picker.dart';

class CallFemaleController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static CallFemaleController get to => Get.find();
  late TabController tabController;

  final list = <Ticket>[].obs;
  final listFutureTicket = <Ticket>[].obs;
  int page = 1;
  int futurePage = 1;
  StreamSubscription? streamSubscription;
  StreamSubscription? streamSubscriptionFuture;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getData(true);
      getData(false);
    });
  }

  @override
  void onClose() {
    streamSubscription?.cancel();
    streamSubscriptionFuture?.cancel();
    super.onClose();
  }

  bool todayTab() {
    return tabController.index == 0;
  }

  Future<void> onRefresh(int index) async {
    if (todayTab()) {
      page = 1;
    } else {
      futurePage = 1;
    }
    await getData(todayTab());
  }

  Future<void> onScrollDown(int index) async {
    if (todayTab()) {
      page = index;
    } else {
      futurePage = index;
    }
    await getData(todayTab());
  }

  bool checkEmpty() {
    return list.length > (todayTab() ? page : futurePage) * kPagingSize;
  }

  Future<void> getData(bool futureData) async {
    final dateTime = futureData
        ? DateTime.now().add(const Duration(days: 1))
        : DateTime.now();

    if (futureData) {
      streamSubscriptionFuture?.cancel();
      streamSubscriptionFuture = fireStoreProvider.listenerListTicker(
          futureData: futureData,
          dateTime: dateTime,
          status: TicketStatus.created.name,
          valueChanged: (QuerySnapshot<Map<String, dynamic>> listDoc) {
            listFutureTicket.clear();
            if (listDoc.docs.isNotEmpty) {
              for (var value in listDoc.docs) {
                try {
                  final messageModel = Ticket.fromJson(value.data());
                  listFutureTicket.add(messageModel);
                } catch (e) {
                  logger.e(e);
                }
              }
            }
            listFutureTicket.sort((a, b) =>
                a.createdDate?.millisecondsSinceEpoch
                    .compareTo(b.createdDate?.millisecondsSinceEpoch ?? 0) ??
                0);

            listFutureTicket.refresh();
          },
          page: futurePage);
    } else {
      streamSubscription?.cancel();
      streamSubscription = fireStoreProvider.listenerListTicker(
          futureData: futureData,
          dateTime: dateTime,
          status: TicketStatus.created.name,
          valueChanged: (QuerySnapshot<Map<String, dynamic>> listDoc) {
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
                a.createdDate?.millisecondsSinceEpoch
                    .compareTo(b.createdDate?.millisecondsSinceEpoch ?? 0) ??
                0);
            list.refresh();
          },
          page: page);
    }
  }

  Future<void> showPickerDate() async {
    showCustomDialog(
      widget: FindDatePicker(
        valueSetter: (DateTime value) {
          Get.toNamed(Routes.searchCall,
              parameters: {'date': '${value.millisecondsSinceEpoch}'},
              arguments: true);
        },
      ),
    );
  }

  Future<void> switchChatDetail() async {
    streamSubscriptionFuture?.pause();
    streamSubscription?.pause();
    final messageGroupId = generateIdMessage(['admin', user.value!.id!]);
    await Get.toNamed(Routes.messageDetail,
        arguments: true, parameters: {'id': messageGroupId});
    streamSubscriptionFuture?.resume();
    streamSubscription?.resume();
  }
}
