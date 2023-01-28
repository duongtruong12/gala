import 'package:base_flutter/ui/screen/error/404_screen.dart';
import 'package:base_flutter/ui/screen/error/404_screen_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/call_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/call_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/detail/message_detail_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/detail/message_detail_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/message_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/message/message_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/edit_profile/edit_profile_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/edit_profile/edit_profile_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/my_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/my_page_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/search/search_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/search/search_page.dart';
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
      name: Routes.error,
      page: () => const ErrorScreen(),
      binding: ErrorBinding(),
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

  return _getPageRoute(
    name: Routes.error,
    child: const ErrorScreen(),
    bindings: ErrorBinding(),
  );
}
