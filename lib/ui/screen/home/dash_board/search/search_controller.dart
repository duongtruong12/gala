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
          "https://fastly.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE"
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar":
          "https://fastly.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE"
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 25,
      "point": 10000,
      "avatar":
          "https://fastly.picsum.photos/id/16/2500/1667.jpg?hmac=uAkZwYc5phCRNFTrV_prJ_0rP0EdwJaZ4ctje2bY7aE"
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar":
          "https://fastly.picsum.photos/id/28/4928/3264.jpg?hmac=GnYF-RnBUg44PFfU5pcw_Qs0ReOyStdnZ8MtQWJqTfA"
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 25,
      "point": 10000,
      "avatar":
          "https://fastly.picsum.photos/id/20/3670/2462.jpg?hmac=CmQ0ln-k5ZqkdtLvVO23LjVAEabZQx2wOaT4pyeG10I"
    }));

    list.add(FemaleModel.fromJson({
      "display_name": "あかね",
      "age": 35,
      "point": 20000,
      "avatar":
          "https://fastly.picsum.photos/id/28/4928/3264.jpg?hmac=GnYF-RnBUg44PFfU5pcw_Qs0ReOyStdnZ8MtQWJqTfA"
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
