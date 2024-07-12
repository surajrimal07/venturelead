import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/core/utils/shared_prefs.dart';
import 'package:venturelead/feathures/auth/view/widget/logout_dialog.dart';

class SettingsController extends GetxController {
  final userPrefs = UserSharedPrefss();

  var isNotificationOn = false.obs;
  var isDarkModeOn = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isDarkModeOn.value = await userPrefs.getData<bool>('dakmode') ?? false;
    update();
  }

  void toggleNotification() {
    Get.showSnackbar(const GetSnackBar(
      title: 'Info',
      message: 'Notification toggled successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      duration: Duration(seconds: 1),
    ));
    isNotificationOn.value = !isNotificationOn.value;
  }

  void toggleDarkMode() {
    if (Get.isDarkMode) {
      Get.changeTheme(ThemeData.light());
      isDarkModeOn.value = false;

      userPrefs.saveData<bool>('dakmode', false);

      Get.showSnackbar(
        const GetSnackBar(
          title: 'Info',
          message: 'Dark mode turned off',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );

      update();
    } else {
      Get.changeTheme(ThemeData.dark());
      isDarkModeOn.value = true;
      userPrefs.saveData<bool>('dakmode', true);
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Info',
          message: 'Dark mode turned on',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
      update();
    }
  }
}

class SettingsCard extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Obx(
              () => SwitchListTile(
                title: const Text('Notifications'),
                value: controller.isNotificationOn.value,
                onChanged: (value) => controller.toggleNotification(),
                activeColor: Colors.red,
              ),
            ),
            Obx(
              () => SwitchListTile(
                title: const Text('Dark Mode'),
                value: controller.isDarkModeOn.value,
                onChanged: (value) => controller.toggleDarkMode(),
                activeColor: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                showLogoutDialog();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
