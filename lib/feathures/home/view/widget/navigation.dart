import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:venturelead/core/utils/string_utils.dart';
import 'package:venturelead/core/utils/theme.dart';
import 'package:venturelead/feathures/auth/view/view/profile_view.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/view/page/blog_home.dart';
import 'package:venturelead/feathures/home/view/page/bookmark_home.dart';
import 'package:venturelead/feathures/home/view/page/companies_home.dart';
import 'package:venturelead/feathures/home/view/page/company_home.dart';
import 'package:venturelead/feathures/home/view/page/company_test.dart';
import 'package:venturelead/feathures/home/view/page/contact_home.dart';
import 'package:venturelead/feathures/home/view/page/faq_home.dart';
import 'package:venturelead/feathures/home/view/page/foryou_news.home.dart';
import 'package:venturelead/feathures/home/view/page/home.dart';
import 'package:venturelead/feathures/home/view/page/latest_news_home.dart';
import 'package:venturelead/feathures/home/view/page/news_search_result_home.dart';
import 'package:venturelead/feathures/home/view/page/notification_home.dart';
import 'package:venturelead/feathures/home/view/page/search_company.dart';

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
          currentIndex: selectedIndex == 4 ||
                  selectedIndex == 5 ||
                  selectedIndex == 8 ||
                  selectedIndex == 9
              ? 0
              : selectedIndex == 12
                  ? 1
                  : selectedIndex == 6 || selectedIndex == 7
                      ? 2
                      : selectedIndex == 10 || selectedIndex == 11
                          ? 3
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
                        selectedIndex == 5 ||
                        selectedIndex == 8 ||
                        selectedIndex == 9
                    ? Colors.white
                    : Colors.grey,
              ),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.newspaper,
                  color: selectedIndex == 1 || selectedIndex == 12
                      ? Colors.white
                      : Colors.grey),
              title: const Text("News", style: TextStyle(color: Colors.white)),
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
                  color: selectedIndex == 3 ||
                          selectedIndex == 10 ||
                          selectedIndex == 11
                      ? Colors.white
                      : Colors.grey),
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
  String keyword = 'business';

  late List<Widget> lstScreen;

  HomeController() {
    lstScreen = [
      DashboardView(),
      const BlogPage(),
      CompanyPage(),
      const ProfileScreen(),
      const LatestNewsView(),
      const ForYouPage(),
      const HomeScreenSearch(),
      CompanyDetails(),
      const NotificationScreen(),
      const BookmarkScreen(),
      const FAQScreen(),
      const ContactUsScreen(),
      NewsSearchPage(keyword: keyword),
    ];
  }

  void updateKeyword(String newKeyword) {
    keyword = newKeyword;
    lstScreen[12] = NewsSearchPage(keyword: keyword);
  }
}

class AppBarWidget extends StatelessWidget {
  AppBarWidget({super.key});
  final AppBarController appBarController = Get.put(AppBarController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final showBack = appBarController.showBack.value;
      final showBookmark = appBarController.showBookmark.value;
      final showNotifi = appBarController.showNotificationIcon.value;
      final showSearch = appBarController.showSearch.value;
      final showSetting = appBarController.showSettings.value;
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
            appBarController.showBack.value = false;
            appBarController.showBookmark.value = true;
            appBarController.showSearch.value = false;
            appBarController.showShare.value = false;
            appBarController.showCustomText.value = false;
            appBarController.showNotificationIcon.value = true;

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
          if (showNotifi)
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                appBarController.showNotificationIcon.value = false;
                appBarController.showBack.value = true;
                appBarController.showCustomText.value = false;
                HomeController.to.selectedIndex.value = 8;
                //Get.to(const DocumentViewer(title: 'Companies'));
              },
            ),
          if (showBookmark)
            IconButton(
              icon: const Icon(Icons.bookmark_border),
              onPressed: () {
                appBarController.showNotificationIcon.value = true;
                appBarController.showBookmark.value = false;
                appBarController.showCustomText.value = false;
                appBarController.showBack.value = true;
                HomeController.to.selectedIndex.value = 9;
                // Handle bookmark button action
              },
            ),
          if (showSearch)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                appBarController.showSearch.value = false;
                appBarController.showCustomText.value = false;
                HomeController.to.selectedIndex.value = 6;
              },
            ),
          if (showSetting)
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                appBarController.showSearch.value = false;
                appBarController.showCustomText.value = false;
                HomeController.to.selectedIndex.value = 6;
              },
            ),
          if (showShare)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                Get.to(const TargetMarketUI());
                //Share.share('Check out this awesome business app VentureLead');
              },
            ),
        ],
      );
    });
  }
}
