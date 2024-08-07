import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:venturelead/core/utils/customWebview.dart';
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/auth/controller/auth_network_controller.dart';
import 'package:venturelead/feathures/auth/model/user_model.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/controller/companies_controller.dart';
import 'package:venturelead/feathures/home/controller/network_controller.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class BookmarkScreen extends StatelessWidget {
  BookmarkScreen({super.key});
  final CompanyController companyController = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    final companies = companyController.getCompanies;
    final User user = Get.find<AuthController>().authState.value.authEntity;

    List<String> favoriteCompanies = user.favoriteCompanyIds ?? [];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: TabBar(
              indicatorColor: Colors.red,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'News/Blog'),
                Tab(text: 'Companies'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // News/Blog section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _buildBookmarkItem(
                          'assets/images/news.jpeg',
                          'The Game called Entrepreneurship for Startup Enthusiasts',
                          'August 02, 2020',
                          'https://www.sharesansar.com/newsdetail/gold-prices-surge-by-rs-1000-silver-follows-suit-with-rs-10-increase-2024-06-28'),
                      _buildBookmarkItem(
                          'assets/images/news.jpeg',
                          'List of Mobile App Performance Metrics to Gauge the Success of App',
                          'October 18, 2019',
                          'https://www.sharesansar.com/newsdetail/gold-prices-surge-by-rs-1000-silver-follows-suit-with-rs-10-increase-2024-06-28'),
                      _buildBookmarkItem(
                          'assets/images/news.jpeg',
                          'What are the latest artificial intelligence trends?',
                          'June 10, 2020',
                          'https://www.sharesansar.com/newsdetail/gold-prices-surge-by-rs-1000-silver-follows-suit-with-rs-10-increase-2024-06-28'),
                      _buildBookmarkItem(
                          'assets/images/news.jpeg',
                          "'Failure is there to teach you something' - 40 quotes from business journeys",
                          'May 05, 2020',
                          'https://www.sharesansar.com/newsdetail/gold-prices-surge-by-rs-1000-silver-follows-suit-with-rs-10-increase-2024-06-28'),
                    ],
                  ),
                ),
              ],
            ),
            // Companies section
            ListView.builder(
              itemCount: companies.length,
              itemBuilder: (context, index) {
                var company = companies[index];
                if (!favoriteCompanies.contains(company['_id'])) {
                  return Container();
                }
                return _buildCompanyItem(company);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmarkItem(
      String imagePath, String title, String date, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.to(WebViewPage(name: 'News', url: url));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.snackbar(
                'Bookmark Removed',
                'Bookmark removed successfully.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
            child: const Icon(Icons.bookmark, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyItem(Map<String, dynamic> company) {
    final User user = Get.find<AuthController>().authState.value.authEntity;
    final appBarController = Get.put(AppBarController());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: () {
          appBarController.showSearch.value = true;
          appBarController.showBack.value = true;
          appBarController.showBookmark.value = true;
          appBarController.showShare.value = true;
          appBarController.showCustomText.value = true;
          appBarController.customText.value = company['name'];
          appBarController.bookmarkType.value = 'company';

          companyController.setSelectedCompany(company);

          HomeController.to.selectedIndex.value = 7;
        },
        child: Row(
          children: [
            const Image(
                image: AssetImage('assets/images/karkhana.png'), height: 50),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                company['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                maxLines: 2,
                company['companyDescription'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.bookmark_remove, color: Colors.red),
              onPressed: () async {
                // List<String> favoriteCompanies = user.favoriteCompanyIds ?? [];
                List<String> updatedFavoriteCompanies =
                    List.from(user.favoriteCompanyIds ?? []);

                if (updatedFavoriteCompanies.contains(company['_id'])) {
                  updatedFavoriteCompanies.remove(company['_id']);
                }

                if (updatedFavoriteCompanies.isEmpty) {
                  updatedFavoriteCompanies = [];
                }

                FormData formData = FormData.fromMap({
                  'email': user.email,
                  'favoriteCompanies': updatedFavoriteCompanies.isEmpty
                      ? []
                      : updatedFavoriteCompanies,
                });

                print(formData.fields);

                bool updateProfile = await handleUpdateController(formData);

                if (updateProfile) {
                  await fetchAllCompanies();
                  Get.showSnackbar(const GetSnackBar(
                    title: 'Success',
                    message: 'Bookmark updated.',
                    duration: Duration(seconds: 1),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
