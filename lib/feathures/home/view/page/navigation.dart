import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:venturelead/core/utils/string_utils.dart';
import 'package:venturelead/core/utils/theme.dart';
import 'package:venturelead/feathures/auth/view/view/profile.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/view/page/blog_home.dart';
import 'package:venturelead/feathures/home/view/page/companies_home.dart';
import 'package:venturelead/feathures/home/view/page/foryou_news.home.dart';
import 'package:venturelead/feathures/home/view/page/latest_news_home.dart';
import 'package:venturelead/feathures/home/view/widget/home.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final AppBarController appBarController = Get.put(AppBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: GestureDetector(
            onTap: () {
              HomeController.to.selectedIndex.value = 0;
            },
            child: const Text(
              AppStrings.appName,
              style: TextStyle(color: Colors.red),
            )),
        // leading: Obx(() => appbarController.showBack.value
        //     ? IconButton(
        //         icon: const Icon(Icons.arrow_back),
        //         onPressed: () {
        //           Get.back();
        //         },
        //       )
        //     : const SizedBox()),
        actions: [
          Obx(() => appbarController.showSearch.value
              ? IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    print("Search clicked!");
                  },
                )
              : const SizedBox()),
          IconButton(
            icon: const Icon(Icons.bookmark_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        final selectedIndex = HomeController.to.selectedIndex.value;
        return PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              fillColor: AppColors.backgroundColor,
              child: child,
            );
          },
          duration: AppStrings.duration,
          child: HomeController.to.lstScreen[selectedIndex],
        );
      }),
      bottomNavigationBar: Obx(() {
        final selectedIndex = HomeController.to.selectedIndex.value;
        return SalomonBottomBar(
          currentIndex: selectedIndex > 3 ? 0 : selectedIndex,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          selectedColorOpacity: 0.8,
          onTap: (index) {
            HomeController.to.selectedIndex.value = index;
          },
          itemPadding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
          itemShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          items: [
            SalomonBottomBarItem(
                title: const Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.home,
                  color: selectedIndex == 0 ? Colors.white : Colors.grey,
                )),
            SalomonBottomBarItem(
                icon: Icon(Icons.calendar_today,
                    color: selectedIndex == 1 ? Colors.white : Colors.grey),
                title: const Text("Events",
                    style: TextStyle(color: Colors.white))),
            SalomonBottomBarItem(
                icon: Icon(
                  Icons.business,
                  color: selectedIndex == 2 ? Colors.white : Colors.grey,
                ),
                title: const Text(
                  "Companies",
                  style: TextStyle(color: Colors.white),
                )),
            SalomonBottomBarItem(
                icon: Icon(Icons.account_circle,
                    color: selectedIndex == 3 ? Colors.white : Colors.grey),
                title: const Text("Profile",
                    style: TextStyle(color: Colors.white))),
          ],
        );
      }),
    );
  }
}

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var selectedIndex = 0.obs;

  List<Widget> lstScreen = [
    const DashboardView(),
    const BlogPage(),
    const CompanyPage(),
    const ProfileScreen(),
    const LatestNewsView(),
    const ForYouPage(),
  ];
}
