import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NotificationController extends GetxController {
  var newsList = <Map<String, dynamic>>[].obs;

  void addNews(Map<String, dynamic> newsItem) {
    newsList.add(newsItem);
  }

  void clearNotifications() {
    newsList.clear();
  }
}

class WebSocketServices {
  late WebSocketChannel _channel;
  bool _isConnected = false;

  bool get isConnected => _isConnected;
  final NotificationController newsController = Get.find();

  Future<void> startWebSocket() async {
    void handleSocketError(dynamic error) {
      Future.delayed(const Duration(seconds: 10), () {
        if (!_isConnected) {
          startWebSocket();
        }
      });
    }

    try {
      _channel = WebSocketChannel.connect(Uri.parse(
          'wss://socket.surajr.com.np/?room=news&jwt=string:0d4bdd8c8dd5469a1a7eb165637d3cfd9a02f61e67e071e1e4a7172ac412673bbb6c9fe2d2bcea536c186db25b4361f5280718f4c5b11c3ad7d25923eec3222dc549b359f8c2b1c07d37385b2bc98dba1c8a6f4a9bdce09f18479330d45f78b413a9121a23e6db650a9f1d560eda503d281a5dd48f2410cf24188d4d3d9341af8969d2c3b7b9069a669631f548b9a0a749929edea468ab09da8ef92fbbf135ef3d7f245086d472d593'));

      _channel.stream.listen(
        (message) {
          onDataCallback(message);
        },
        onError: handleSocketError,
        onDone: () {
          _isConnected = false;
        },
      );

      _isConnected = true;
    } on SocketException catch (e) {
      handleSocketError(e);
    } catch (e) {
      handleSocketError(e);
    }
  }

  void onDataCallback(dynamic data) {
    print(data);
    Map<String, dynamic> newData = json.decode(data);
    String type = newData['type'];
    if (type == 'news') {
      newsController.addNews(newData);
      String receivedTitle = newData['title'];
      String receivedDescription = newData['description'];
      String? receivedImage =
          newData['image'] is String ? newData['image'] : null;
      String url = newData['url'];

      NotificationServices.showNotification(
        receivedTitle,
        receivedDescription,
        receivedImage,
        url,
      );
    }
  }

  void closeWebSocket() {
    _channel.sink.close();
    _isConnected = false;
  }
}

class NotificationServices {
  static Future<void> showNotification(
      String title, String description, String? image, String url) async {
    String defaultImagePath = 'resource://raw/news';
    String selectedImagePath = image ?? defaultImagePath;

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'basic_channel',
        title: title,
        body: description,
        bigPicture: selectedImagePath,
        largeIcon: selectedImagePath,
        notificationLayout: image != null
            ? NotificationLayout.BigPicture
            : NotificationLayout.Default,
        displayOnBackground: true,
        displayOnForeground: true,
        wakeUpScreen: true,
        actionType: ActionType.KeepOnTop,
        payload: {'notificationId': '1234567890', 'url': url},
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'open_link',
          label: 'Open Link',
        ),
      ],
    );
  }
}
