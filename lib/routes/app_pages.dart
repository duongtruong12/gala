import 'package:base_flutter/ui/admin/dash_board/call_list/call_list_binding.dart';
import 'package:base_flutter/ui/admin/dash_board/call_list/call_list_page.dart';
import 'package:base_flutter/ui/admin/dash_board/call_list/ticket_detail/ticket_detail_binding.dart';
import 'package:base_flutter/ui/admin/dash_board/call_list/ticket_detail/ticket_detail_page.dart';
import 'package:base_flutter/ui/admin/dash_board/cast_payment_manager/cast_payment_manager_binding.dart';
import 'package:base_flutter/ui/admin/dash_board/cast_payment_manager/cast_payment_manager_page.dart';
import 'package:base_flutter/ui/admin/dash_board/caster_manager/caster_manager_binding.dart';
import 'package:base_flutter/ui/admin/dash_board/caster_manager/caster_manager_page.dart';
import 'package:base_flutter/ui/admin/dash_board/guest_manager/guest_manager_binding.dart';
import 'package:base_flutter/ui/admin/dash_board/guest_manager/guest_manager_page.dart';
import 'package:base_flutter/ui/admin/dash_board/payment_manager/payment_manager_binding.dart';
import 'package:base_flutter/ui/admin/dash_board/payment_manager/payment_manager_page.dart';
import 'package:base_flutter/ui/admin/home_admin/home_admin_binding.dart';
import 'package:base_flutter/ui/admin/home_admin/home_admin_page.dart';
import 'package:base_flutter/ui/login/login_binding.dart';
import 'package:base_flutter/ui/login/login_page.dart';
import 'package:base_flutter/ui/screen/error/404_screen.dart';
import 'package:base_flutter/ui/screen/error/404_screen_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/call_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/call_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/confirm_call/confirm_call_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/confirm_call/confirm_call_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/first_time_user/first_time_user_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/first_time_user/first_time_user_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/purchase_point/purchase_point_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/purchase_point/purchase_point_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/select_mood/select_mood_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call/select_mood/select_mood_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call_female/call_female_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call_female/call_female_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call_female/search_call_date/search_call_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/call_female/search_call_date/search_call_page.dart';
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
import 'package:base_flutter/ui/screen/home/dash_board/my_page/point_history/point_history_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/point_history/point_history_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/user_guide/user_guide_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page/user_guide/user_guide_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/help_female/help_female_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/help_female/help_female_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/my_page_female.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/my_page_female_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/point_history_female/point_history_female_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/point_history_female/point_history_female_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/sale_proceed/instant_deposit/instant_deposit_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/sale_proceed/instant_deposit/instant_deposit_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/sale_proceed/sale_proceed_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/sale_proceed/sale_proceed_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/sale_proceed/transfer_information/transfer_information_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/sale_proceed/transfer_information/transfer_information_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/user_guide_female/user_guide_female_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/my_page_female/user_guide_female/user_guide_female_page.dart';
import 'package:base_flutter/ui/screen/home/dash_board/right_term/right_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/search/search_binding.dart';
import 'package:base_flutter/ui/screen/home/dash_board/search/search_page.dart';
import 'package:base_flutter/ui/screen/search_detail/search_detail_binding.dart';
import 'package:base_flutter/ui/screen/search_detail/search_detail_page.dart';
import 'package:base_flutter/ui/screen/user_detail/user_detail_binding.dart';
import 'package:base_flutter/ui/screen/user_detail/user_detail_page.dart';
import 'package:base_flutter/utils/global/global_middleware.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/screen/home/dash_board/right_term/right_page.dart';
import '../ui/screen/home/home_binding.dart';
import '../ui/screen/home/home_page.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: Routes.homeAdmin,
      page: () => const HomeAdminPage(),
      binding: HomeAdminBinding(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: Routes.term,
      page: () => const RightTermPage(label: 'term_service_label'),
      binding: RightTermBinding(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: Routes.law,
      page: () => const RightTermPage(label: 'law_label'),
      binding: RightTermBinding(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: Routes.privacyPolicy,
      page: () => const RightTermPage(label: 'privacy_policy_label'),
      binding: RightTermBinding(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: Routes.homeFemale,
      page: () => const HomePage(),
      binding: HomeBinding(),
      middlewares: [GlobalMiddleware()],
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
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: Routes.userDetail,
      page: () => const UserDetail(),
      binding: UserDetailBinding(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: Routes.searchCall,
      page: () => const SearchCallPage(),
      binding: SearchCallBinding(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: Routes.ticketDetail,
      page: () => const TicketDetailPage(),
      binding: TicketDetailBinding(),
      middlewares: [GlobalMiddleware()],
    ),
    GetPage(
      name: Routes.messageDetail,
      page: () => const MessageDetailPage(),
      binding: MessageDetailBinding(),
      middlewares: [GlobalMiddleware()],
    ),
  ];
}

Route onGenerateRouteDashboardAdmin(RouteSettings settings) {
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

  if (settings.name == Routes.casterManager) {
    return _getPageRoute(
        name: Routes.casterManager,
        child: const CasterManagerPage(),
        bindings: CasterManagerBinding());
  }

  if (settings.name == Routes.guestManager) {
    return _getPageRoute(
        name: Routes.guestManager,
        child: const GuestManagerPage(),
        bindings: GuestManagerBinding());
  }

  if (settings.name == Routes.chatManager) {
    return _getPageRoute(
        name: Routes.chatManager,
        child: const MessagePage(),
        bindings: MessageBinding());
  }

  if (settings.name == Routes.paymentManager) {
    return _getPageRoute(
        name: Routes.paymentManager,
        child: const PaymentManagerPage(),
        bindings: PaymentManagerBinding());
  }

  if (settings.name == Routes.castPaymentManager) {
    return _getPageRoute(
        name: Routes.castPaymentManager,
        child: const CastPaymentManagerPage(),
        bindings: CastPaymentManagerBinding());
  }

  if (settings.name == Routes.callList) {
    return _getPageRoute(
        name: Routes.callList,
        child: const CallListPage(),
        bindings: CallListBinding());
  }

  return _getPageRoute(
    name: Routes.error,
    child: const ErrorScreen(),
    bindings: ErrorBinding(),
  );
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

  if (settings.name == Routes.saleProceed) {
    return _getPageRoute(
        name: Routes.saleProceed,
        child: const SaleProceed(),
        bindings: SaleProceedBinding());
  }

  if (settings.name == Routes.transferInformation) {
    return _getPageRoute(
        name: Routes.transferInformation,
        child: const TransferInformation(),
        bindings: TransferInformationBinding());
  }

  if (settings.name == Routes.instantDeposit) {
    return _getPageRoute(
        name: Routes.instantDeposit,
        child: const InstantDeposit(),
        bindings: InstantDepositBinding());
  }

  if (settings.name == Routes.userGuide) {
    return _getPageRoute(
        name: Routes.userGuide,
        child: const UserGuide(),
        bindings: UserGuideBinding());
  }

  if (settings.name == Routes.userGuideFemale) {
    return _getPageRoute(
        name: Routes.userGuideFemale,
        child: const UserGuideFemale(),
        bindings: UserGuideFemaleBinding());
  }

  if (settings.name == Routes.help) {
    return _getPageRoute(
        name: Routes.help,
        child: const HelpPage(),
        bindings: HelpPageBinding());
  }

  if (settings.name == Routes.helpFemale) {
    return _getPageRoute(
        name: Routes.helpFemale,
        child: const HelpFemale(),
        bindings: HelpFemaleBinding());
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

  if (settings.name == Routes.purchasePoint) {
    return _getPageRoute(
        name: Routes.purchasePoint,
        child: const PurchasePointPage(),
        bindings: PurchasePointBinding());
  }

  if (settings.name == Routes.pointHistory) {
    return _getPageRoute(
        name: Routes.pointHistory,
        child: const PointHistory(),
        bindings: PointHistoryBinding());
  }

  if (settings.name == Routes.pointHistoryFemale) {
    return _getPageRoute(
        name: Routes.pointHistoryFemale,
        child: const PointHistoryFemale(),
        bindings: PointHistoryFemaleBinding());
  }

  return _getPageRoute(
    name: Routes.error,
    child: const ErrorScreen(),
    bindings: ErrorBinding(),
  );
}
