import 'package:flutter/material.dart';
import 'package:venturelead/feathures/home/view/page/navigation.dart';

class ForYouPage extends StatelessWidget {
  const ForYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

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
          fillColor: Colors.grey[900],
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
                    label:
                        Text(category, style: const TextStyle(fontSize: 10.0)),
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

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFeaturedStoryCard(
              'Production',
              '11minread',
              'Foreign Direct Investment',
              'Nepal Secures Over Rs 53 Billion in Foreign Investment Commitments',
              'assets/images/news.jpeg'),
          _buildTrendingStoryCard(
            'Business and Tech News',
            'Nepal and Armenia Chambers of Commerce Forge Economic Partnership',
            'May 19, 2024',
            'assets/images/news.jpeg',
          ),
          _buildTrendingStoryCard(
            'Business and Tech News',
            'Nepal and Armenia Chambers of Commerce Forge Economic Partnership',
            'May 19, 2024',
            'assets/images/news.jpeg',
          ),
          _buildTrendingStoryCard(
            'Business and Tech News',
            'Nepal and Armenia Chambers of Commerce Forge Economic Partnership',
            'May 19, 2024',
            'assets/images/news.jpeg',
          ),
          _buildTrendingStoryCard(
            'Business and Tech News',
            'Nepal and Armenia Chambers of Commerce Forge Economic Partnership',
            'May 19, 2024',
            'assets/images/news.jpeg',
          ),
        ],
      ),
    );
  }
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
          const SizedBox(height: 2),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time, size: 15),
                  const SizedBox(width: 5),
                  Text(date),
                ],
              ),
              ButtonBar(
                children: [
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ],
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
