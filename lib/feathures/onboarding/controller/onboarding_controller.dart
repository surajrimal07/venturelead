import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OnboardingController extends GetxController {
  final pageController = PageController(initialPage: 0);
  final currentIndex = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    update();
  }
}
