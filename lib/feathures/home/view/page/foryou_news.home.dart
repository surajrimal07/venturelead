import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/view/page/news_summary_home.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class ForYouPage extends StatelessWidget {
  const ForYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final appBarController = Get.put(AppBarController());

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
                        appBarController.showBack.value = false;
                        appBarController.showBookmark.value = true;
                        appBarController.showSearch.value = false;
                        appBarController.showShare.value = false;
                        appBarController.showCustomText.value = false;
                        appBarController.showNotificationIcon.value = true;

                        HomeController.to.selectedIndex.value = 0;
                      },
                      child: const Text(
                        'Recently Added',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        HomeController.to.selectedIndex.value = 4;
                      },
                      child: const Text('Latest News',
                          style: TextStyle(color: Colors.grey)),
                    ),
                    TextButton(
                      onPressed: () {
                        HomeController.to.selectedIndex.value = 5;
                      },
                      child: const Text('For You',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w400,
                              fontSize: 17)),
                    ),
                  ],
                ),
                const NewsPage(),
              ],
            ),
          ),
        ),
        floatingActionButton: RawMaterialButton(
          onPressed: scrollToTop,
          elevation: 6.0,
          fillColor: const Color.fromARGB(255, 216, 106, 98),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16.0),
          child: const Icon(
            Icons.arrow_upward,
            color: Colors.white,
          ),
        ));
  }
}

Widget _buildFeaturedStoryCard(String category, String readTime, String title,
    String description, String image, String date, String url) {
  return Padding(
    padding: const EdgeInsets.only(right: 0.0),
    child: SizedBox(
      width: 420,
      height: 332,
      child: GestureDetector(
        onTap: () async {
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return NewsSummaryModal(imageUrl: image, newsUrl: url);
            },
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(9.0),
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
                Image.asset(image, height: 150, width: 420, fit: BoxFit.cover),
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
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 5),
                    Text(date),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Handle bookmark button press
                      },
                      child: const Icon(
                        Icons.bookmark_border,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        Share.share(
                            'Check out this news: $title in VentureLead App! $url');
                      },
                      child: const Icon(
                        Icons.share,
                        size: 22,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFeaturedStoryCard(
              'Production',
              '11 Min',
              'Foreign Direct Investment',
              'Nepal Secures Over Rs 53 Billion in Foreign Investment Commitments',
              'assets/images/news.jpeg',
              'May 19, 2024',
              'https://www.sharesansar.com/newsdetail/gold-prices-surge-by-rs-1000-silver-follows-suit-with-rs-10-increase-2024-06-28'),
          _buildTrendingStoryCard(
              'Business and Tech News',
              'Nepal and Armenia Chambers of Commerce Forge Economic Partnership',
              'May 19, 2024',
              'assets/images/news.jpeg',
              '11 Min',
              'https://www.sharesansar.com/newsdetail/gold-prices-surge-by-rs-1000-silver-follows-suit-with-rs-10-increase-2024-06-28'),
          _buildTrendingStoryCard(
              'Business and Tech News',
              'Nepal and Armenia Chambers of Commerce Forge Economic Partnership',
              'May 19, 2024',
              'assets/images/news.jpeg',
              '11 Min',
              'https://www.sharesansar.com/newsdetail/gold-prices-surge-by-rs-1000-silver-follows-suit-with-rs-10-increase-2024-06-28'),
          _buildTrendingStoryCard(
              'Business and Tech News',
              'Nepal and Armenia Chambers of Commerce Forge Economic Partnership',
              'May 19, 2024',
              'assets/images/news.jpeg',
              '11 Min',
              'https://www.sharesansar.com/newsdetail/gold-prices-surge-by-rs-1000-silver-follows-suit-with-rs-10-increase-2024-06-28'),
          _buildTrendingStoryCard(
              'Business and Tech News',
              'Nepal and Armenia Chambers of Commerce Forge Economic Partnership',
              'May 19, 2024',
              'assets/images/news.jpeg',
              '11 Min',
              'https://www.sharesansar.com/newsdetail/gold-prices-surge-by-rs-1000-silver-follows-suit-with-rs-10-increase-2024-06-28'),
        ],
      ),
    );
  }
}

Widget _buildTrendingStoryCard(String category, String title, String date,
    String image, String readTime, String url) {
  return GestureDetector(
    onTap: () async {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return NewsSummaryModal(imageUrl: image, newsUrl: url);
        },
      );
      //Get.to(WebViewPage(name: 'News', url: url));
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      // elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Chip(
                  label: Text(category, style: const TextStyle(fontSize: 11.0)),
                ),
                const Spacer(),
                const Icon(Icons.access_time, size: 15),
                Text(readTime, style: const TextStyle(fontSize: 12)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  image,
                  height: 90,
                  width: 130,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 5),
                Text(date),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // Handle bookmark button press
                  },
                  child: const Icon(
                    Icons.bookmark_border,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Share.share(
                        'Check out this news: $title in VentureLead App! $url');
                  },
                  child: const Icon(
                    Icons.share,
                    size: 22,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final bool isLarge;

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imageUrl,
              height: isLarge ? 200 : 150,
              width: double.infinity,
              fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              date,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {
                  // Handle bookmark button press
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  // Handle share button press
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
