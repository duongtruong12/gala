import 'package:base_flutter/components/custom_bottom_sheet.dart';
import 'package:base_flutter/model/city_model.dart';
import 'package:base_flutter/model/ticket_model.dart';
import 'package:base_flutter/model/user_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call_female/components/find_date_picker.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CallController extends GetxController {
  static CallController get to => Get.find();
  final list = <UserModel>[].obs;
  Rxn<bool> edit = Rxn<bool>();
  final Rx<Ticket> ticket = Ticket(
      peopleApply: [],
      tagInformation: [],
      status: TicketStatus.created.name,
      peopleApprove: []).obs;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  Future<void> getData() async {
    final listDoc =
        await fireStoreProvider.getListUser(sort: TypeAccount.caster);
    if (listDoc.isNotEmpty) {
      for (var value in listDoc) {
        try {
          if (value.data() != null) {
            final userModel = UserModel.fromJson(value.data()!);
            list.add(userModel);
          }
        } catch (e) {
          logger.e(e);
        }
      }
    }
    list.refresh();
  }

  Future<void> switchSelectMood() async {
    if (ticket.value.numberPeople == null ||
        ticket.value.cityId == null ||
        ticket.value.cityName == null ||
        ticket.value.stateName == null ||
        ticket.value.startTimeAfter == null ||
        ticket.value.durationDate == null) {
      showError('error_select_fields'.tr);
      return;
    }

    if (edit.value == true) {
      onPressedBack();
    } else {
      Get.toNamed(Routes.selectMood, id: RouteId.call);
    }
  }

  void onSwitchFemaleDetail(String? id) {
    Get.toNamed(Routes.userDetail, parameters: {'id': '$id'}, arguments: true);
  }

  void onPressedBack() {
    Get.back(id: RouteId.call);
  }

  void setEdit(bool edit) {
    this.edit.value = edit;
  }

  Future<void> showInputMaxNumber() async {
    final result = await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomStepperNumberPeople(
            label: 'number_people_select'.tr,
            init: ticket.value.numberPeople,
          );
        });
    if (result != null) {
      ticket.value.numberPeople = result;
      ticket.refresh();
    }
  }

  Future<void> showSelectCity() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInputCity(
            myValueSetter: (cityModel) async {
              if (cityModel?.id != ticket.value.cityId) {
                ticket.value.cityName = cityModel?.name;
                ticket.value.cityId = cityModel?.id;
                ticket.value.stateName = null;
                ticket.refresh();
              }
            },
            initList: [
              CityModel(
                id: 12,
                name: '東京',
              ),
              CityModel(
                id: 26,
                name: '大阪',
              ),
            ],
            label: 'please_select_label'.tr,
            init: ticket.value.cityName,
          );
        });
  }

  Future<void> showSelectState() async {
    if (ticket.value.cityId == null) {
      return;
    }
    final result = await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomSelectStateChip(
            label: 'select_state_label'.tr,
            init: ticket.value.stateName,
            initListState: ticket.value.cityId == 12
                ? [
                    '恵比寿',
                    '六本木',
                    '西麻布',
                    '麻布十番',
                    '渋谷',
                    '赤坂',
                    '銀座',
                    '中目黒',
                    '池袋',
                    '新宿'
                  ]
                : ['梅田', '北新地', '心斎橋・なんば', '京橋', '天満', '福島'],
          );
        });
    if (result != null) {
      ticket.value.stateName = result;
      ticket.refresh();
    }
  }

  Future<void> selectListStartTime() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomSelectChip(
            myValueSetter: (str) async {
              if (str == StartTimeAfter.customMinutes.name) {
                DateTime? date;
                await Future.delayed(const Duration(milliseconds: 100));
                await showCustomDialog(
                  widget: FindDatePicker(
                    date: ticket.value.startTime,
                    valueSetter: (DateTime value) {
                      date = value;
                    },
                    label: 'add_payment_title'.tr,
                  ),
                );
                if (date != null) {
                  ticket.value.startTimeAfter = str;
                  ticket.value.startTime = date;
                }
              } else {
                ticket.value.startTimeAfter = str;
                ticket.value.startTime = null;
              }
              ticket.refresh();
            },
            label: 'start_time_question'.tr,
            init: ticket.value.startTimeAfter,
            listChips: StartTimeAfter.values.map((e) => e.name).toList(),
          );
        });
  }

  Future<void> selectListDurationDate() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomSelectChip(
            myValueSetter: (str) async {
              ticket.value.durationDate = str;
              ticket.refresh();
            },
            label: 'duration_select'.tr,
            init: ticket.value.durationDate,
            listChips: DurationDate.values.map((e) => e.name).toList(),
          );
        });
  }

  Ticket getTicket() {
    return ticket.value;
  }

  void setTicket(Ticket ticket) {
    this.ticket.value = ticket;
  }
}
