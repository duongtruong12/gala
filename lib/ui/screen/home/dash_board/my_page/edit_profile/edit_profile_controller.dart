import 'package:base_flutter/components/custom_bottom_sheet.dart';
import 'package:base_flutter/model/city_model.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:base_flutter/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/bottom_sheet_tag.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find();
  final listImage = [].obs;

  @override
  void onInit() {
    super.onInit();
    listImage.addAll(user.value?.previewImage ?? []);
  }

  Future<void> selectImage() async {
    final image = await picker.pickMultiImage(imageQuality: 70);
    if (image.isNotEmpty) {
      final list = await fireStoreProvider.uploadMultipleFiles(
          images: image, path: 'avatar');
      listImage.clear();
      for (var element in list) {
        if (element != null) {
          listImage.add(element);
        }
      }
      await fireStoreProvider.updateUser(
          data: {'previewImage': listImage, 'avatar': listImage.first});
    }
  }

  Future<void> swapImage() async {
    if (listImage.length > 1) {
      final first = listImage[0];
      listImage.removeAt(0);
      listImage.add(first);
      await fireStoreProvider.updateUser(
          data: {'previewImage': listImage, 'avatar': listImage.first});
    }
  }

  Future<void> switchHideAge(bool? hideAge) async {
    await fireStoreProvider.updateUser(data: {'hideAge': hideAge});
  }

  String? validateNickName(String? str) {
    return Validate.emptyValidate(str: str, field: 'nick_name'.tr);
  }

  Future<void> showInputNickName() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInput(
            myValueSetter: (str) async {
              await fireStoreProvider.updateUser(data: {
                'displayName': str
              }).then((value) => user.value?.displayName = str);
            },
            label: 'enter_nick_name'.tr,
            validate: validateNickName,
            initText: user.value?.displayName,
          );
        });
  }

  Future<void> selectCity(
      {required String type,
      required String? initText,
      required String label}) async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInputCity(
            myValueSetter: (cityModel) async {
              await fireStoreProvider.updateUser(data: {type: cityModel?.name});
            },
            label: label,
            init: initText,
          );
        });
  }

  Future<void> showPasswordChange() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInputPassword(
            myValueSetter: (str) async {
              await fireStoreProvider.changePassword(newPassword: str);
            },
            label: 'change_password'.tr,
          );
        });
  }

  Future<void> showDateBottom() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInputDate(
            myValueSetter: (date) async {
              await fireStoreProvider.updateUser(data: {'birthday': date});
            },
            initDate: user.value?.birthday,
            label: 'select_date'.tr,
          );
        });
  }

  Future<void> showSelectCity() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomSelectAddress(
            myValueSetter: (map) async {
              CityModel? cityModel = map?['city'] as CityModel?;
              StateModel? stateModel = map?['state'] as StateModel?;
              if (cityModel != null && stateModel != null) {
                await fireStoreProvider.updateUser(data: {
                  'cityId': cityModel.id,
                  'cityName': cityModel.name,
                  'stateId': stateModel.id,
                  'stateName': stateModel.name,
                });
              }
            },
            label: 'please_select_label'.tr,
            init: user.value?.cityId,
            initState: user.value?.stateId,
          );
        });
  }

  Future<void> showSelectTag() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return BottomSheetTag(
            valueSetter: (List value) async {
              Get.back(closeOverlays: true);
              await fireStoreProvider
                  .updateUser(data: {'tagInformation': value});
            },
          );
        });
  }

  Future<void> showInputDescription() async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInput(
            myValueSetter: (str) async {
              await fireStoreProvider.updateUser(data: {'description': str});
            },
            hint: 'description_hint'.tr,
            minLines: 8,
            label: 'description_enter'.tr,
            initText: user.value?.description,
          );
        });
  }

  Future<void> showSelectLabel(
      {required String type,
      required String label,
      required Map<String, dynamic> map,
      required dynamic initValue}) async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomSelectDropdown(
            myValueSetter: (value) async {
              await fireStoreProvider.updateUser(data: {type: value});
            },
            label: label,
            init: initValue,
            map: map,
          );
        });
  }

  Future<void> showInput(
      {required String type,
      required String label,
      bool numeric = false,
      required String? initText}) async {
    await showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CustomInput(
            numeric: numeric,
            myValueSetter: (str) async {
              await fireStoreProvider
                  .updateUser(data: {type: numeric ? int.parse(str!) : str});
            },
            validate: (str) {
              return numeric ? Validate.numberValidate(str, label) : null;
            },
            label: label,
            initText: initText,
          );
        });
  }
}
