import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:venturelead/core/utils/customWebview.dart';
import 'package:venturelead/feathures/home/controller/news_controller.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class LatestNewsView extends StatelessWidget {
  const LatestNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final NewsController newsController = Get.put(NewsController());

    void scrollToTop() {
      scrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }

    String formatDateString(String dateString) {
      final RegExp regExp = RegExp(r'\w{3} (\w{3}) (\d{2}) (\d{4})');
      final Match? match = regExp.firstMatch(dateString);

      if (match != null) {
        final String day = match.group(2)!;
        final String month = match.group(1)!;
        final String year = match.group(3)!;

        return '$day $month $year';
      } else {
        return 'Invalid date';
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsController.fetchNews('Business');
    });

    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.red,
        onRefresh: () async {
          newsController.fetchNews('Business');
        },
        child: SingleChildScrollView(
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
                      'Latest News',
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
                //const SizedBox(height: 4),
                const Text(
                  'Featured Stories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(() {
                    if (newsController.isLoading.value) {
                      return const Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      ));
                    } else if (newsController.errorMessage.isNotEmpty) {
                      return Center(
                          child: Text(newsController.errorMessage.value));
                    } else {
                      var featuredStories =
                          newsController.newsList.take(5).toList();
                      return Row(
                        children: featuredStories
                            .map((news) => _buildFeaturedStoryCard(
                                  news.category,
                                  news.readingTime.toString(),
                                  news.title,
                                  news.description,
                                  news.imgUrl,
                                  formatDateString(news.pubDate),
                                  news.link,
                                ))
                            .toList(),
                      );
                    }
                  }),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Trending Stories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Obx(() {
                  if (newsController.isLoading.value) {
                    return const Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ));
                  } else if (newsController.errorMessage.isNotEmpty) {
                    return Center(
                        child: Text(newsController.errorMessage.value));
                  } else {
                    var trendingStories =
                        newsController.newsList.skip(6).toList();
                    return Column(
                      children: trendingStories
                          .map((news) => _buildTrendingStoryCard(
                              news.category,
                              news.title,
                              formatDateString(news.pubDate),
                              news.imgUrl,
                              news.link,
                              news.description,
                              news.readingTime.toString(),
                              news.source))
                          .toList(),
                    );
                  }
                }),
              ],
            ),
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
      ),
    );
  }

  Widget _buildFeaturedStoryCard(String category, String readTime, String title,
      String description, String image, String pubDate, String url) {
    return GestureDetector(
      onTap: () {
        Get.to(WebViewPage(name: 'News', url: url));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 7.0),
        child: SizedBox(
          width: 300,
          height: 320,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(5),
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
                          Text("$readTime Mins",
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  Image.network(image,
                      height: 150, width: 300, fit: BoxFit.cover),
                  const SizedBox(height: 5),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 5),
                      Text(pubDate),
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

  Widget _buildTrendingStoryCard(
      String category,
      String title,
      String pubDate,
      String image,
      String url,
      String description,
      String readTime,
      String source) {
    return GestureDetector(
      onTap: () {
        Get.to(WebViewPage(name: 'News', url: url));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Chip(
                    label:
                        Text(category, style: const TextStyle(fontSize: 10.0)),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 15),
                      Text("$readTime Mins",
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Image.network(image,
                      height: 90, width: 130, fit: BoxFit.cover),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 5),
                  Text('$pubDate • $source'),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
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
}
