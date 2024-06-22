import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

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
            const Text(
              '         No notifications',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
