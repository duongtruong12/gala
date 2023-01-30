import 'package:base_flutter/lang/locale_service.dart';
import 'package:base_flutter/ui/screen/error/404_screen.dart';
import 'package:base_flutter/ui/screen/error/404_screen_binding.dart';
import 'package:base_flutter/ui/screen/login/login_binding.dart';
import 'package:base_flutter/utils/const.dart';
import 'package:base_flutter/utils/global/globals_functions.dart';
import 'package:base_flutter/utils/global/globals_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'routes/app_pages.dart';
import 'utils/connect_internet_check.dart';
import 'utils/constant.dart';

var connectivity = ConnectivityChangeNotifier();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  femaleGender.value = await getBool(key: SharedPrefKey.femaleGender);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    setStatusBarColor();
    return ScreenUtilInit(
      designSize: const Size(375, 904),
      builder: (context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        smartManagement: SmartManagement.keepFactory,
        builder: (context, child) {
          return MediaQuery(
            child: child ?? const SizedBox(),
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          );
        },
        theme: femaleGender.value ? femaleTheme : lightTheme,
        defaultTransition: Transition.fade,
        localizationsDelegates: const [
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        title: 'ガラ',
        supportedLocales: LocalizationService.locales,
        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        initialRoute: Routes.login,
        initialBinding: LoginBinding(),
        getPages: AppPages.pages,
        unknownRoute: GetPage(
          name: Routes.error,
          page: () => const ErrorScreen(),
          binding: ErrorBinding(),
        ),
      ),
    );
  }
}
