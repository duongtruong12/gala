import 'package:base_flutter/model/female_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find();
  final list = <FemaleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 25,
      "point": 10000,
      "avatar":
          "https://gravatar.com/avatar/8305ec25259a1ebe06e94a478cc6453f?s=400&d=robohash&r=x"
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar":
          "https://gravatar.com/avatar/8d4d8398d95737a9d9958c61f2a88879?s=400&d=robohash&r=x"
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 25,
      "point": 10000,
      "avatar":
          "https://gravatar.com/avatar/8305ec25259a1ebe06e94a478cc6453f?s=400&d=robohash&r=x"
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar":
          "https://gravatar.com/avatar/8d4d8398d95737a9d9958c61f2a88879?s=400&d=robohash&r=x"
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 25,
      "point": 10000,
      "avatar":
          "https://gravatar.com/avatar/8305ec25259a1ebe06e94a478cc6453f?s=400&d=robohash&r=x"
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar":
          "https://gravatar.com/avatar/8d4d8398d95737a9d9958c61f2a88879?s=400&d=robohash&r=x"
    }));
  }

  void onSwitchSearchDetail() {
    Get.toNamed(Routes.searchDetail, id: RouteId.search);
  }

  void onSwitchFemaleDetail(int id) {
    Get.toNamed(Routes.femaleProfile,
        parameters: {'id': '$id'}, arguments: true);
  }
}
