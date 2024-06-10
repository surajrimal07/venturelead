import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:venturelead/core/utils/string_utils.dart';
import 'package:venturelead/core/utils/theme.dart';
import 'package:venturelead/feathures/splash/view/page/splash.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController =
        Get.find<ThemeController>();

    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: themeController.isDarkMode
          ? ThemeData.dark()
          : ThemeData.light(),
      home: const SplashScreen(),
    );
  }
}
