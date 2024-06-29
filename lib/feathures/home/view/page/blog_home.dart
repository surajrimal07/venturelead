import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/core/utils/customWebview.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final TextEditingController searchTextController = TextEditingController();
  //final NewsController newsController = Get.put(NewsController());
  final appBarController = Get.put(AppBarController());

  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                          hintText: 'Search Companies',
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
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Suggested Topics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 700,
              height: 110,
              child: GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 10.0,
                children: const [
                  TopicCard(title: 'Latest', color: Colors.purple),
                  TopicCard(title: 'Fintech', color: Colors.blueGrey),
                  TopicCard(title: 'Innovation', color: Colors.green),
                  TopicCard(title: 'Business', color: Colors.brown),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Trending',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  NewsCard(
                    imageUrl: 'assets/images/news.jpeg',
                    newsUrl:
                        'https://www.sharesansar.com/newsdetail/gold-prices-surge-by-rs-1000-silver-follows-suit-with-rs-10-increase-2024-06-28',
                    title:
                        "Government Introduces 'National Startups Policy, 2080' to Boost Startup Investments",
                    source: 'Sharesansar',
                  ),
                  NewsCard(
                    imageUrl: 'assets/images/news.jpeg',
                    newsUrl:
                        'https://www.sharesansar.com/newsdetail/gold-prices-surge-by-rs-1000-silver-follows-suit-with-rs-10-increase-2024-06-28',
                    title:
                        'Nepal Secures Over Rs 53 Billion in Foreign Investment Commitments in First Ten Months of Fiscal Year',
                    source: 'Sharesansar',
                  ),
                ],
              ),
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

  const TopicCard({
    super.key,
    required this.title,
    required this.color,
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
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
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

  const NewsCard({
    super.key,
    required this.imageUrl,
    required this.newsUrl,
    required this.title,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Get.to(WebViewPage(name: 'News', url: newsUrl));
        },
        child: SizedBox(
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(imageUrl, height: 150, width: 300, fit: BoxFit.cover),
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
