// news_summary_modal.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/core/utils/customWebview.dart';
import 'package:venturelead/feathures/home/controller/news_summary_controller.dart';

class NewsSummaryModal extends StatelessWidget {
  final String imageUrl;
  final String newsUrl;

  const NewsSummaryModal(
      {super.key, required this.imageUrl, required this.newsUrl});

  @override
  Widget build(BuildContext context) {
    final NewsSummaryController newsSummaryController =
        Get.put(NewsSummaryController());

    return FutureBuilder(
      future: newsSummaryController.fetchNewsSummary(newsUrl),
      builder: (context, snapshot) {
        if (newsSummaryController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        } else if (newsSummaryController.errorMessage.isNotEmpty) {
          return AlertDialog(
            title: const Text('Summary Error'),
            content: Text(newsSummaryController.errorMessage.value),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Read Full News',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Get.back();
                  Get.to(WebViewPage(name: 'News', url: newsUrl));
                },
              )
            ],
          );
        } else {
          return AlertDialog(
            title: const Text(
              'News Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      imageUrl,
                      width: 300,
                      height: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/news.jpeg',
                          width: 300,
                          height: 130,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          newsSummaryController.summary.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Read Full News',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Get.back();
                  Get.to(WebViewPage(name: 'News', url: newsUrl));
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child:
                    const Text('Close', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          );
        }
      },
    );
  }
}
