import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:venturelead/core/utils/customWebview.dart';
import 'package:venturelead/feathures/home/controller/news_controller.dart';

class NewsSearchPage extends StatelessWidget {
  final String keyword;

  const NewsSearchPage({super.key, required this.keyword});

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
      newsController.searchNews(keyword);
    });

    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.red,
        onRefresh: () async {
          newsController.searchNews(keyword);
        },
        child: Obx(() {
          if (newsController.isLoading.value) {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ));
          } else if (newsController.searchNewsList.isEmpty) {
            return Center(child: Text('No news found for $keyword'));
          } else {
            return ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(8.0),
              children: [
                Column(
                  children: newsController.searchNewsList
                      .map((news) => newsCard(
                            news.title,
                            news.source,
                            news.imgUrl,
                            formatDateString(news.pubDate),
                            news.link,
                          ))
                      .toList(),
                ),
              ],
            );
          }
        }),
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

  Widget newsCard(String title, String source, String imageUrl, String pubDate,
      String url) {
    return GestureDetector(
      onTap: () {
        Get.to(WebViewPage(name: 'News', url: url));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://res.cloudinary.com/dio3qwd9q/image/upload/fl_preserve_transparency/v1718440959/10212377_ev7xiw.jpg',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
