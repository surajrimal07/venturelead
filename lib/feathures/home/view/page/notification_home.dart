import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/auth/view/widget/settings_widget.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final settingController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/nonotification.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 15),
            Obx(() => Text(
                  settingController.isNotificationOn.value
                      ? '        No notifications'
                      : 'Notifications are off, turn on to receive notifications',
                  style: const TextStyle(fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}
