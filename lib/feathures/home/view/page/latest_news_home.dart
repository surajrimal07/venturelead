import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/view/page/navigation.dart';

AppBarController appbarController = Get.put(AppBarController());

class LatestNewsView extends StatelessWidget {
  const LatestNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    // appbarController.setShowSearch(true);
    // appbarController.setShowBack(true);

    void scrollToTop() {
      scrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      HomeController.to.selectedIndex.value = 0;
                    },
                    child: const Text('Recently Added',
                        style: TextStyle(color: Colors.grey)),
                  ),
                  const Text(
                    'LatestNews',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                        fontSize: 17),
                  ),
                  TextButton(
                    onPressed: () {
                      HomeController.to.selectedIndex.value = 5;
                    },
                    child: const Text('For You',
                        style: TextStyle(color: Colors.grey)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'FeaturedStories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFeaturedStoryCard(
                        'Production',
                        '11minread',
                        'Foreign Direct Investment',
                        'Nepal Secures Over Rs 53 Billion in Foreign Investment Commitments',
                        'assets/images/news.jpeg'),
                    _buildFeaturedStoryCard(
                        'FinTech',
                        '15minread',
                        'Tech Innovation',
                        'Nepal Secures Over Rs 53 Billion in dddddddddddddddddddddddddddddddddddddddForeign Investment Commitments',
                        'assets/images/news.jpeg'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Trending Stories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildTrendingStoryCard(
                  'Business and Tech News',
                  'Nepal Hosts International Dialogue to Address Climate Change Impact on Mountain Ecosystems',
                  'May 15, 2024',
                  'assets/images/news.jpeg'),
              const SizedBox(height: 10),
              _buildTrendingStoryCard(
                  'Business and Tech News',
                  'Nepal and Armenia Chambers of Commerce Forge Economic Partnership',
                  'May 18, 2024',
                  'assets/images/news.jpeg'),
            ],
          ),
        ),
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: scrollToTop,
        elevation: 6.0,
        fillColor: Colors.grey[900],
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16.0),
        child: const Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFeaturedStoryCard(String category, String readTime, String title,
      String description, String image) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: SizedBox(
        width: 300,
        height: 320,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Chip(
                      label: Text(category,
                          style: const TextStyle(fontSize: 10.0)),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 15),
                        Text(readTime, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Image.asset(image, height: 150, width: 300, fit: BoxFit.cover),
                Text(
                  title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingStoryCard(
    String category,
    String title,
    String date,
    String image,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Chip(
              label: Text(category, style: const TextStyle(fontSize: 11.0)),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Image.asset(
                  image,
                  height: 90,
                  width: 130,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 10),
                Expanded(
                  //this text should start at the same height as the image
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),
            Text(date), //this should be exactely below the title
          ],
        ),
      ),
    );
  }
}
