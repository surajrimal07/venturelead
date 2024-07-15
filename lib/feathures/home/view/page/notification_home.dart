import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/auth/view/widget/settings_widget.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final settingController = Get.put(SettingsController());

  final RxList<Map<String, String>> notifications = <Map<String, String>>[
    {'title': 'Welcome!', 'message': 'Thank you for joining us.'},
    {'title': 'Info', 'message': 'This is a sample notification.'},
    {
      'title': 'Reminder',
      'message': 'Don\'t forget to follow your favorite companies and topics'
    },
  ].obs;

  void clearNotifications() {
    notifications.clear();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.redAccent,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: Scaffold(
        body: Center(
          child: Obx(() {
            if (settingController.isNotificationOn.value) {
              if (notifications.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/nonotification.png',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      '       No pending notifications',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: const Icon(Icons.notifications),
                          title: Text(notifications[index]['title']!),
                          subtitle: Text(notifications[index]['message']!),
                        ),
                      );
                    },
                  ),
                );
              }
            } else {
              return Column(
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
              );
            }
          }),
        ),
        floatingActionButton: Obx(() {
          if (settingController.isNotificationOn.value &&
              notifications.isNotEmpty) {
            return FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: clearNotifications,
              tooltip: 'Clear All Notifications',
              child: const Icon(Icons.clear_outlined, color: Colors.red),
            );
          } else {
            return Container(); // Return an empty container if no notifications
          }
        }),
      ),
    );
  }
}
