class News {
  final String id;
  final String title;
  final String link;
  final String description;
  final String imgUrl;
  final String pubDate;
  final String source;
  final String uniqueKey;
  final int newsId;
  final int version;
  final String category;
  int readingTime;

  News({
    required this.id,
    required this.title,
    required this.link,
    required this.description,
    this.imgUrl =
        'https://res.cloudinary.com/dio3qwd9q/image/upload/fl_preserve_transparency/v1718440959/10212377_ev7xiw.jpg',
    required this.pubDate,
    required this.source,
    required this.uniqueKey,
    required this.newsId,
    required this.version,
    required this.category,
    this.readingTime = 0,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['_id'],
      title: json['title'],
      link: json['link'],
      description: json['description'],
      imgUrl: json['img_url'],
      pubDate: json['pubDate'],
      source: json['source'],
      uniqueKey: json['unique_key'],
      newsId: json['id'],
      version: json['__v'],
      category: json['category'],
      readingTime: json['readingTime'] ?? 0,
    );
  }
  // static String _generateRandomCategory() {
  //   const categories = ['Production', 'Business', 'Tech', 'Tourism', 'Health'];
  //   categories.shuffle();
  //   return categories.first;
  // }

  // static String _generateReadTimeBasedOnDescription(String description) {
  //   final wordCount = description.split(' ').length;
  //   final readTime = (wordCount / 200).ceil();
  //   return '$readTime min read';
  // }
}
