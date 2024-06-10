import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/core/utils/string_utils.dart';
import 'package:venturelead/feathures/auth/view/view/home.dart';
import 'package:venturelead/feathures/common/presentation/widget/button.dart';
import 'package:venturelead/feathures/onboarding/controller/onboarding_controller.dart';
import 'package:venturelead/feathures/onboarding/model/onboarding_model.dart';
import 'package:venturelead/feathures/onboarding/view/widget/onboarding_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    return Scaffold(
      appBar: AppBar(
        title:
            const Text(AppStrings.appName, style: TextStyle(color: Colors.red)),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Get.off(() => const AuthHomeScreen());
            },
            child: const Text(
              'Skip',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (index) => controller.currentIndex.value = index,
              children: onBoardingData
                  .map((data) => OnboardingWidget(
                        title: data.title,
                        subtitle: data.subtitle,
                        image: data.image,
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Obx(() {
              return MainElevatedButton(
                text:
                    controller.currentIndex.value != 3 ? 'Next' : 'Get Started',
                onPressed: () {
                  if (controller.currentIndex.value == 3) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const AuthHomeScreen()),
                    );
                  } else {
                    controller.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                size: ButtonSize.large,
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(
                    controller.currentIndex.value, onBoardingData.length),
              );
            }),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator(int currentPage, int totalPages) {
    List<Widget> list = [];
    for (int i = 0; i < totalPages; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 5.0,
      width: isActive ? 40.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.red : Colors.red.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(2)),
      ),
    );
  }
}
