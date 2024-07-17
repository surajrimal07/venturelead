import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/core/utils/customWebview.dart';
import 'package:venturelead/feathures/auth/view/widget/settings_widget.dart';
import 'package:venturelead/feathures/home/controller/news_controller.dart';
import 'package:venturelead/feathures/home/view/widget/websocket.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final settingController = Get.put(SettingsController());
  final NotificationController newsController =
      Get.put(NotificationController());

  void clearNotifications() {
    newsController.clearNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.redAccent,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: Scaffold(
        body: Obx(() {
          if (settingController.isNotificationOn.value) {
            if (newsController.newsList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/nonotification.png',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'No pending notifications',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: newsController.newsList.length,
                itemBuilder: (context, index) {
                  final reversedIndex =
                      newsController.newsList.length - 1 - index;
                  final newsItem = newsController.newsList[reversedIndex];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: GestureDetector(
                      onTap: () async {
                        final NewsController newsController =
                            Get.put(NewsController());
                        await newsController
                            .updateNewsView(newsItem['unique_key']);
                        Get.to(WebViewPage(name: 'News', url: newsItem['url']));
                      },
                      child: ListTile(
                        leading: const Icon(Icons.notifications),
                        title: Text(newsItem['title']),
                        subtitle: Text(newsItem['description']),
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/nonotification.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Notifications are off, turn on to receive notifications',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            );
          }
        }),
        floatingActionButton: Obx(() {
          if (settingController.isNotificationOn.value &&
              newsController.newsList.isNotEmpty) {
            return FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: clearNotifications,
              tooltip: 'Clear All Notifications',
              child: const Icon(Icons.clear_outlined, color: Colors.red),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
