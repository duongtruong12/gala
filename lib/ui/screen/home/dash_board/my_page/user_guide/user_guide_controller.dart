import 'package:base_flutter/model/faq_model.dart';
import 'package:base_flutter/routes/app_pages.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:get/get.dart';

class UserGuideController extends GetxController {
  static UserGuideController get to => Get.find();
  final list = <FaqModel>[];

  @override
  void onInit() {
    super.onInit();
    _installList();
  }

  void _installList() {
    list.add(FaqModel(question: '通知が届かない', answer: '「マイページ」＞「通知設定」よりご確認ください。'));
    list.add(FaqModel(
        question: '友達紹介ポイントが反映されていない',
        answer:
            'ブラウザや端末環境によっては友達紹介が反映されない場合がございます。紹介が反映されない場合、運営コンシェルジュへメッセージでご一報ください。'));
    list.add(FaqModel(
        question: '合流確定したキャストと連絡が取れなくなった', answer: '運営コンシェルジェへメッセージをください。'));
    list.add(FaqModel(
        question: '領収書を発行したい', answer: '「マイページ」＞「ポイント」履歴より領収書の発行が可能です。'));
    list.add(FaqModel(
        question: '携帯番号を変更した。アカウントを引き継ぎたい場合',
        answer:
            '運営コンシェルジュへメッセージ、もしくはお問合せよりご連絡ください。その際、本人確認のため登録していたプロフィールや、最後のメッセージ、以前合流したキャストなどをお尋ねする可能性があります。'));
  }

  void onPressedBack() {
    Get.back(id: getRouteMyPage());
  }

  Future<void> onSwitchMessageDetail() async {
    final messageGroupId = generateIdMessage(['admin', user.value?.id ?? '']);
    Get.toNamed(Routes.messageDetail,
        arguments: true, parameters: {'id': messageGroupId});
  }
}
