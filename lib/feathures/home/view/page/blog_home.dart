import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/controller/news_controller.dart';
import 'package:venturelead/feathures/home/view/page/news_summary_home.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final TextEditingController searchTextController = TextEditingController();
  final NewsController newsController = Get.put(NewsController());
  final appBarController = Get.put(AppBarController());

  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newsController.fetchTrendingNews();
    });

    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: searchTextController,
                        decoration: const InputDecoration(
                          hintText: 'Search News, Blogs and Events.',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          setState(() {
                            isSearchVisible = value.isNotEmpty;
                          });
                        },
                      ),
                    ),
                    Visibility(
                      visible: isSearchVisible,
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.black),
                        onPressed: () {
                          appBarController.showBack(true);
                          appBarController.showSearch(true);
                          appBarController.showCustomText(true);
                          appBarController
                              .setCustomText(searchTextController.text);
                          appBarController.showShare(false);
                          appBarController.showBookmark(false);

                          HomeController.to
                              .updateKeyword(searchTextController.text);
                          HomeController.to.selectedIndex.value = 12;
                          // newsController.fetchNews(searchTextController.text);
                          // final searchText = searchTextController.text;
                          // final searchResults = searchCompanies(
                          //     companyController.getCompanies, searchText);

                          // setState(() {
                          //   filteredCompanies = searchResults;
                          // });
                        },
                      ),
                    ),
                    Visibility(
                      visible: isSearchVisible,
                      child: IconButton(
                        icon: const Icon(Icons.clear, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            isSearchVisible = false;
                            searchTextController.clear();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Suggested Topics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 433,
              height: 80,
              child: GridView.count(
                crossAxisCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(4.0),
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 5.0,
                children: const [
                  TopicCard(
                      title: 'Latest',
                      color: Colors.purple,
                      icon: Icon(Icons.new_releases, color: Colors.white)),
                  TopicCard(
                      title: 'Fintech',
                      color: Colors.blueGrey,
                      icon: Icon(Icons.money, color: Colors.white)),
                  TopicCard(
                      title: 'Innovation',
                      color: Colors.green,
                      icon: Icon(Icons.science, color: Colors.white)),
                  TopicCard(
                      title: 'Business',
                      color: Colors.brown,
                      icon: Icon(Icons.business, color: Colors.white)),
                  TopicCard(
                      title: 'Nepal',
                      color: Colors.brown,
                      icon: Icon(Icons.local_atm, color: Colors.white)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Trending',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                if (newsController.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                } else if (newsController.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(newsController.errorMessage.value),
                  );
                } else {
                  var featuredStories =
                      newsController.trendingNews.take(10).toList();
                  return Row(
                    children: featuredStories.map((news) {
                      return NewsCard(
                        source: news.source,
                        newsKey: news.uniqueKey,
                        title: news.title,
                        imageUrl: news.imgUrl,
                        newsUrl: news.link,
                      );
                    }).toList(),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final String title;
  final Color color;
  final Icon icon;

  const TopicCard({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final appBarController = Get.put(AppBarController());

    return GestureDetector(
      onTap: () {
        appBarController.showBack(true);
        appBarController.showSearch(true);
        appBarController.showCustomText(true);
        appBarController.setCustomText(title);
        appBarController.showShare(false);
        appBarController.showBookmark(false);

        HomeController.to.updateKeyword(title);
        HomeController.to.selectedIndex.value = 12;
      },
      child: Container(
        width: 50, // Reduced width for the smaller circle
        height: 50, // Reduced height for the smaller circle
        decoration: BoxDecoration(
          color: color,
          gradient: const LinearGradient(
            colors: [Colors.grey, Colors.redAccent],
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 5.0),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String source;
  final String newsUrl;
  final String newsKey;

  const NewsCard(
      {super.key,
      required this.imageUrl,
      required this.newsUrl,
      required this.title,
      required this.source,
      required this.newsKey});

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.put(NewsController());
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () async {
          await newsController.updateNewsView(newsKey);
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return NewsSummaryModal(imageUrl: imageUrl, newsUrl: newsUrl);
            },
          );
        },
        child: SizedBox(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(imageUrl,
                  height: 150, width: 300, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.article, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      source,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
