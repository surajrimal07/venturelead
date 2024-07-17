import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:venturelead/core/app.dart';
import 'package:venturelead/core/http/http_service.dart';
import 'package:venturelead/core/utils/theme.dart';
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/controller/companies_controller.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';
import 'package:venturelead/feathures/home/view/widget/websocket.dart';
import 'package:venturelead/feathures/onboarding/controller/onboarding_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NotificationController());

  AwesomeNotifications().initialize(
    'resource://raw/ic_launcher',
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'businessnews',
        channelDescription: 'Business News',
        playSound: true,
        onlyAlertOnce: true,
        groupAlertBehavior: GroupAlertBehavior.Children,
        importance: NotificationImportance.Max,
        defaultPrivacy: NotificationPrivacy.Public,
        defaultColor: AppColors.btnColor,
        channelShowBadge: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
      ),
    ],
    debug: false,
  );

  WebSocketServices webSocketServices = WebSocketServices();
  await webSocketServices.startWebSocket();

  Get.put(HomeController());
  Get.put(HttpService());
  Get.put(ThemeController());
  Get.put(OnboardingController());
  Get.put(AuthController());
  Get.put(AppBarController());
  Get.put(CompanyController());

  runApp(const App());
}
