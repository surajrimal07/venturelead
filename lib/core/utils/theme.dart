import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:venturelead/core/utils/shared_prefs.dart';

class ThemeController extends GetxController {
  final _isDarkMode = false.obs;
  final userPrefs = UserSharedPrefss();

  @override
  void onInit() async {
    super.onInit();
    _isDarkMode.value = await userPrefs.getData<bool>('dakmode') ?? false;
    update();
  }

  bool get isDarkMode => _isDarkMode.value;

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    update();
  }
}

class AppColors {
  static const Color btnColor = Color(0xFF9585C0);
  static const Color primaryColor = Color(0xFF6750A4);
  static const Color secondaryColor = Color(0xFF928D9C);
  static const Color tertiaryColor = Color(0xFF7D5260);
  static const Color errorColor = Color(0xFFCA6862);
  static const Color backgroundColor = Colors.white;
  static const Color outlineColor = Color(0xFFA29EA5);
  static const Color redColor = Color.fromARGB(255, 248, 144, 144);
  static const Color greenColor = Color.fromARGB(255, 123, 228, 126);
  static const Color greyPrimaryColor = Color.fromRGBO(28, 27, 32, 1.0);

  static const Color darkPrimaryColor = Color(0xFF6750A4);
  static const Color darkbackgroundColor = Color(0xFF000000);
  static const Color darktextColor = Colors.white;
  static const Color whitetextColor = Colors.black;
}
