import 'package:base_flutter/model/female_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/constant.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
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
      "avatar": listImage[r.nextInt(listImage.length)]
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar": listImage[r.nextInt(listImage.length)]
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 25,
      "point": 10000,
      "avatar": listImage[r.nextInt(listImage.length)]
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar": listImage[r.nextInt(listImage.length)]
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 25,
      "point": 10000,
      "avatar": listImage[r.nextInt(listImage.length)]
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar": listImage[r.nextInt(listImage.length)]
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
