import 'package:base_flutter/model/female_model.dart';
import 'package:get/get.dart';

class FemaleDetailController extends GetxController {
  static FemaleDetailController get to => Get.find();
  Rxn<FemaleModel> model = Rxn<FemaleModel>();
  bool? canPop;
  final currentSelect = 0.obs;

  @override
  void onInit() {
    super.onInit();
    canPop = Get.arguments;
    model.value = FemaleModel.fromJson({
      "id": "EB3HA4EL990Q9PX7U7X0I",
      "age": 25,
      "display_name": "あなた",
      "point": 10000,
      "avatar":
          "https://i.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU",
      "preview_images": [
        "https://i.picsum.photos/id/1/5000/3333.jpg?hmac=Asv2DU3rA_5D1xSe22xZK47WEAN0wjWeFOhzd13ujW4",
        "https://i.picsum.photos/id/1/5000/3333.jpg?hmac=Asv2DU3rA_5D1xSe22xZK47WEAN0wjWeFOhzd13ujW4",
        "https://i.picsum.photos/id/4/5000/3333.jpg?hmac=ghf06FdmgiD0-G4c9DdNM8RnBIN7BO0-ZGEw47khHP4",
        "https://i.picsum.photos/id/1/5000/3333.jpg?hmac=Asv2DU3rA_5D1xSe22xZK47WEAN0wjWeFOhzd13ujW4",
        "https://i.picsum.photos/id/1/5000/3333.jpg?hmac=Asv2DU3rA_5D1xSe22xZK47WEAN0wjWeFOhzd13ujW4",
        "https://i.picsum.photos/id/4/5000/3333.jpg?hmac=ghf06FdmgiD0-G4c9DdNM8RnBIN7BO0-ZGEw47khHP4",
      ],
      "tags": [
        "わいわい",
        "ゴルフ",
        "海好き",
        "カラオケ",
        "わいわい",
        "ゴルフ",
        "海好き",
        "カラオケ",
        "わいわい",
        "ゴルフ",
        "海好き",
        "カラオケ",
        "わいわい",
        "ゴルフ",
        "海好き",
        "カラオケ",
      ],
      "description":
          "初めまして♡最近始めたので不慣れですがよろしくお願いします。お酒やることが大好きです。旅行も好きで、休みの日にはよく出かけています。",
      "height": 165,
      "address": "東京都",
      "birth_place": "長野県",
      "education": "短大/専門学校卒",
      "job": "美容",
      "can_drink": false,
      "can_smoke": true,
      "siblings": "長女",
      "live_family": false,
      "hair_style": "ロング",
      "hair_color": "茶系"
    });
  }

  void onSwitchImage(int i) {
    currentSelect.value = i;
  }
}
