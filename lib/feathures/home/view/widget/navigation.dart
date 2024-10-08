import 'package:animations/animations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:venturelead/core/utils/string_utils.dart';
import 'package:venturelead/core/utils/theme.dart';
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/auth/controller/auth_network_controller.dart';
import 'package:venturelead/feathures/auth/model/user_model.dart';
import 'package:venturelead/feathures/auth/view/view/profile_view.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/controller/companies_controller.dart';
import 'package:venturelead/feathures/home/controller/network_controller.dart';
import 'package:venturelead/feathures/home/view/page/blog_home.dart';
import 'package:venturelead/feathures/home/view/page/bookmark_home.dart';
import 'package:venturelead/feathures/home/view/page/companies_home.dart';
import 'package:venturelead/feathures/home/view/page/company_home.dart';
import 'package:venturelead/feathures/home/view/page/contact_home.dart';
import 'package:venturelead/feathures/home/view/page/faq_home.dart';
import 'package:venturelead/feathures/home/view/page/foryou_news.home.dart';
import 'package:venturelead/feathures/home/view/page/home.dart';
import 'package:venturelead/feathures/home/view/page/latest_news_home.dart';
import 'package:venturelead/feathures/home/view/page/news_search_result_home.dart';
import 'package:venturelead/feathures/home/view/page/notification_home.dart';
import 'package:venturelead/feathures/home/view/page/search_company.dart';
import 'package:venturelead/feathures/home/view/widget/websocket.dart';

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
      NotificationScreen(),
      BookmarkScreen(),
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
  final CompanyController companyController = Get.put(CompanyController());
  final User user = Get.find<AuthController>().authState.value.authEntity;
  final NotificationController newsController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final showBack = appBarController.showBack.value;
      final showBookmark = appBarController.showBookmark.value;
      final bookmarkType = appBarController.bookmarkType.value;
      final showNotifi = appBarController.showNotificationIcon.value;
      final showSearch = appBarController.showSearch.value;
      final showSetting = appBarController.showSettings.value;
      final showShare = appBarController.showShare.value;
      final showCustomText = appBarController.showCustomText.value;
      final customText = appBarController.customText.value;
      bool centerTitle = showCustomText ? false : true;

      return AppBar(
        //backgroundColor: Colors.white,
        elevation: 0,
        leading: showBack
            ? IconButton(
                icon: Icon(Icons.arrow_back,
                    color: Get.isDarkMode ? Colors.white : Colors.black),
                onPressed: () {
                  appBarController.bookmarkType.value = 'news';
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
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                )
              : Text.rich(
                  TextSpan(
                    text: 'VENTURE',
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black),
                    children: const <TextSpan>[
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
              icon: Icon(newsController.newsList.isEmpty
                  ? Icons.notifications_outlined
                  : Icons.notifications_active),
              onPressed: () {
                appBarController.showNotificationIcon.value = false;
                appBarController.showBack.value = true;
                appBarController.showCustomText.value = false;
                HomeController.to.selectedIndex.value = 8;
              },
            ),
          if (showBookmark)
            Obx(() {
              final newfavcompanyId = companyController.getSelectedCompany;
              bool isThisCompanyFav = false;
              List<String> favoriteCompanies = user.favoriteCompanyIds ?? [];

              if (newfavcompanyId != null &&
                  favoriteCompanies.contains(newfavcompanyId['_id'])) {
                isThisCompanyFav = true;
              }

              return IconButton(
                icon: Icon(bookmarkType == 'news'
                    ? Icons.bookmark_border
                    : isThisCompanyFav
                        ? Icons.favorite
                        : Icons.favorite_border),
                onPressed: () async {
                  if (bookmarkType == 'news') {
                    appBarController.showNotificationIcon.value = true;
                    appBarController.showBookmark.value = false;
                    appBarController.showCustomText.value = false;
                    appBarController.showBack.value = true;
                    HomeController.to.selectedIndex.value = 9;
                  } else {
                    if (newfavcompanyId != null &&
                        favoriteCompanies.contains(newfavcompanyId['_id'])) {
                      favoriteCompanies.remove(newfavcompanyId['_id']);
                    } else if (newfavcompanyId != null) {
                      favoriteCompanies.add(newfavcompanyId['_id']);
                    }

                    FormData formData = FormData.fromMap({
                      'email': user.email,
                      'favoriteCompanies': favoriteCompanies,
                    });

                    bool updateProfile = await handleUpdateController(formData);

                    if (updateProfile) {
                      await fetchAllCompanies();
                      Get.showSnackbar(const GetSnackBar(
                        title: 'Success',
                        message: 'Favorite company updated successfully.',
                        duration: Duration(seconds: 1),
                      ));
                    }
                  }
                },
              );
            }),
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
                //Get.to(const TargetMarketUI());
                Share.share('Check out this awesome business app VentureLead');
              },
            ),
        ],
      );
    });
  }
}
