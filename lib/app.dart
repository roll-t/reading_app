import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/app_binding.dart';
import 'package:reading_app/core/configs/themes/themes.dart';
import 'package:reading_app/core/lang/translation_service.dart';
import 'package:reading_app/core/routes/pages.dart';
import 'package:reading_app/core/utils/behavior.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Pages.initial,
        scrollBehavior: MyBehavior(),
        getPages: Pages.routes,
        initialBinding: AppBinding(),
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.dark,
      );
    });
  }
}
