import 'package:base_flutter/ui/screen/error/404_screen.dart';
import 'package:base_flutter/ui/screen/error/404_screen_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/call_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/call_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/confirm_call/confirm_call_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/confirm_call/confirm_call_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/first_time_user/first_time_user_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/first_time_user/first_time_user_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/select_mood/select_mood_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/select_mood/select_mood_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call_female/call_female_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call_female/call_female_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/detail/message_detail_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/detail/message_detail_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/message_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/message_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/edit_profile/edit_profile_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/edit_profile/edit_profile_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/help/help_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/help/help_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/my_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/my_page_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/payment_information/payment_information_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/payment_information/payment_information_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/point_history/point_history_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/point_history/point_history_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/user_guide/user_guide_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/user_guide/user_guide_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/my_page_female.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/my_page_female_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/search/search_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/search/search_page.dart';
import 'package:base_flutter/ui/screen/login/login_binding.dart';
import 'package:base_flutter/ui/screen/login/login_page.dart';
import 'package:base_flutter/ui/screen/search_detail/search_detail_binding.dart';
import 'package:base_flutter/ui/screen/search_detail/search_detail_page.dart';
import 'package:base_flutter/ui/screen/user_detail/female_detail_binding.dart';
import 'package:base_flutter/ui/screen/user_detail/female_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/screen/home/home_binding.dart';
import '../ui/screen/home/home_page.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.homeFemale,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.error,
      page: () => const ErrorScreen(),
      binding: ErrorBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.femaleProfile,
      page: () => const FemaleDetail(),
      binding: FemaleDetailBinding(),
    ),
    GetPage(
      name: Routes.messageDetail,
      page: () => const MessageDetailPage(),
      binding: MessageDetailBinding(),
    ),
  ];
}

Route onGenerateRouteDashboard(RouteSettings settings) {
  GetPageRoute _getPageRoute(
      {required String name,
      required Widget child,
      required Bindings? bindings}) {
    return GetPageRoute(
      settings: settings,
      routeName: name,
      title: name.tr,
      page: () => child,
      binding: bindings,
    );
  }

  if (settings.name == Routes.message) {
    return _getPageRoute(
        name: Routes.message,
        child: const MessagePage(),
        bindings: MessageBinding());
  }

  if (settings.name == Routes.myPage) {
    return _getPageRoute(
        name: Routes.myPage, child: const MyPage(), bindings: MyPageBinding());
  }

  if (settings.name == Routes.call) {
    return _getPageRoute(
        name: Routes.call, child: const CallPage(), bindings: CallBinding());
  }

  if (settings.name == Routes.myPageFemale) {
    return _getPageRoute(
        name: Routes.myPageFemale,
        child: const MyPageFemale(),
        bindings: MyPageFemaleBinding());
  }

  if (settings.name == Routes.callFemale) {
    return _getPageRoute(
        name: Routes.call,
        child: const CallFemalePage(),
        bindings: CallFemaleBinding());
  }

  if (settings.name == Routes.searchDetail) {
    return _getPageRoute(
        name: Routes.searchDetail,
        child: const SearchDetail(),
        bindings: SearchDetailBinding());
  }

  if (settings.name == Routes.editProfile) {
    return _getPageRoute(
        name: Routes.editProfile,
        child: const EditProfile(),
        bindings: EditProfileBinding());
  }

  if (settings.name == Routes.search) {
    return _getPageRoute(
        name: Routes.search,
        child: const SearchPage(),
        bindings: SearchBinding());
  }

  if (settings.name == Routes.paymentInformation) {
    return _getPageRoute(
        name: Routes.paymentInformation,
        child: const PaymentInformation(),
        bindings: PaymentInformationBinding());
  }

  if (settings.name == Routes.userGuide) {
    return _getPageRoute(
        name: Routes.userGuide,
        child: const UserGuide(),
        bindings: UserGuideBinding());
  }

  if (settings.name == Routes.help) {
    return _getPageRoute(
        name: Routes.help,
        child: const HelpPage(),
        bindings: HelpPageBinding());
  }

  if (settings.name == Routes.selectMood) {
    return _getPageRoute(
        name: Routes.selectMood,
        child: const SelectMood(),
        bindings: SelectMoodBinding());
  }

  if (settings.name == Routes.firstTimeUser) {
    return _getPageRoute(
        name: Routes.firstTimeUser,
        child: const FirstTimeUser(),
        bindings: FirstTimeUserBinding());
  }

  if (settings.name == Routes.confirmCall) {
    return _getPageRoute(
        name: Routes.confirmCall,
        child: const ConfirmCall(),
        bindings: ConfirmCallBinding());
  }

  if (settings.name == Routes.pointHistory) {
    return _getPageRoute(
        name: Routes.pointHistory,
        child: const PointHistory(),
        bindings: PointHistoryBinding());
  }

  return _getPageRoute(
    name: Routes.error,
    child: const ErrorScreen(),
    bindings: ErrorBinding(),
  );
}
