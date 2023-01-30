import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'components/find_date_picker.dart';

class CallFemaleController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static CallFemaleController get to => Get.find();
  late TabController tabController;
  final list = <Ticket>[].obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
    installList();
  }

  Future<void> installList() async {
    final ticket = Ticket(
        id: 'ticket-1',
        area: '東京都品川区 ',
        startTime: Timestamp.now(),
        requiredTime: 1,
        numberPeople: 4,
        peopleApply: ['user-123'],
        createdDate: Timestamp.now(),
        createdUser: 'user-234',
        expectedPoint: 8000,
        extension: 5200);
    list.addAll([
      ticket,
      ticket,
      ticket,
      ticket,
      ticket,
      ticket,
      ticket,
      ticket,
    ]);
  }

  Future<void> showPickerDate() async {
    showCustomDialog(
      widget: FindDatePicker(),
    );
  }
}