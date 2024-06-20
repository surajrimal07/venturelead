import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:venturelead/core/utils/string_utils.dart';
import 'package:venturelead/core/utils/theme.dart';
import 'package:venturelead/feathures/auth/view/view/profile_view.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/view/page/blog_home.dart';
import 'package:venturelead/feathures/home/view/page/companies_home.dart';
import 'package:venturelead/feathures/home/view/page/company_home.dart';
import 'package:venturelead/feathures/home/view/page/foryou_news.home.dart';
import 'package:venturelead/feathures/home/view/page/home.dart';
import 'package:venturelead/feathures/home/view/page/latest_news_home.dart';
import 'package:venturelead/feathures/home/view/page/search.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static HomeController get to => Get.find();
  static AppBarController appBarController = Get.find<AppBarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(),
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
          currentIndex: selectedIndex == 4 || selectedIndex == 5
              ? 0
              : selectedIndex == 6 || selectedIndex == 7
                  ? 2
                  : selectedIndex,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          selectedColorOpacity: 0.8,
          onTap: (index) {
            if (index == 0 || index == 1 || index == 2 || index == 3) {
              appBarController.showSearch.value = false;
              appBarController.showBack.value = false;
              appBarController.showBookmark.value = true;
              appBarController.showShare.value = false;
              appBarController.showCustomText.value = false;
              appBarController.showNotificationIcon.value = true;
              appBarController.customText.value = '';
            }

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
                color: selectedIndex == 0 ||
                        selectedIndex == 4 ||
                        selectedIndex == 5
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.calendar_today,
                  color: selectedIndex == 1 ? Colors.white : Colors.grey),
              title:
                  const Text("Events", style: TextStyle(color: Colors.white)),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                Icons.business,
                color: selectedIndex == 2 ||
                        selectedIndex == 6 ||
                        selectedIndex == 7
                    ? Colors.white
                    : Colors.grey,
              ),
              title: const Text(
                "Companies",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.account_circle,
                  color: selectedIndex == 3 ? Colors.white : Colors.grey),
              title:
                  const Text("Profile", style: TextStyle(color: Colors.white)),
            ),
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
    DashboardView(),
    const BlogPage(),
    const CompanyPage(),
    const ProfileScreen(),
    const LatestNewsView(),
    const ForYouPage(),
    const HomeScreenSearch(),
    const CompanyDetails(),
  ];
}

class AppBarWidget extends StatelessWidget {
  AppBarWidget({super.key});
  final AppBarController appBarController = Get.put(AppBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final showBack = appBarController.showBack.value;
      final showBookmark = appBarController.showBookmark.value;
      final showSearch = appBarController.showSearch.value;
      final showShare = appBarController.showShare.value;
      final showCustomText = appBarController.showCustomText.value;
      final customText = appBarController.customText.value;
      bool centerTitle = showCustomText ? false : true;

      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  appBarController.showBack.value = false;
                  appBarController.showBookmark.value = true;
                  appBarController.showSearch.value = false;
                  appBarController.showShare.value = false;
                  appBarController.showCustomText.value = false;
                  appBarController.showNotificationIcon.value = true;

                  HomeController.to.selectedIndex.value = 0;
                },
              )
            : null,
        centerTitle: centerTitle,
        title: GestureDetector(
          onTap: () {
            appBarController.showSearch.value = false;
            appBarController.showBack.value = false;
            appBarController.showBookmark.value = false;

            HomeController.to.selectedIndex.value = 0;
          },
          child: showCustomText
              ? Text(
                  customText,
                  style: const TextStyle(color: Colors.black),
                )
              : const Text.rich(
                  TextSpan(
                    text: 'VENTURE',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'LED',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
                  ),
                ),
        ),
        actions: [
          if (showBookmark)
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                // Handle bookmark button action
              },
            ),
          if (showBookmark)
            IconButton(
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {
                // Handle bookmark button action
              },
            ),
          if (showSearch)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                // Handle search button action
              },
            ),
          if (showShare)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                // Handle share button action
              },
            ),
        ],
      );
    });
  }
}
