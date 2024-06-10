import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:venturelead/core/app.dart';
import 'package:venturelead/core/http/http_service.dart';
import 'package:venturelead/core/utils/theme.dart';
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/view/page/navigation.dart';
import 'package:venturelead/feathures/onboarding/controller/onboarding_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(HomeController());
  Get.put(HttpService());
  Get.put(ThemeController());
  Get.put(OnboardingController());
  Get.put(AuthController());
  runApp(const App());
}
