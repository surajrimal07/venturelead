import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/core/utils/shared_prefs.dart';
import 'package:venturelead/feathures/auth/view/view/login_auth.dart';

void showLogoutDialog() {
  Get.dialog(
    AlertDialog(
      title: const Text('Logout'),
      content: const Text('You will be logged out, are you sure?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.snackbar(
              maxWidth: 300,
              'Logout Cancelled',
              'You have cancelled the logout.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: const Text('No',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        TextButton(
          onPressed: () {
            Get.offAll(const LoginScreen());
            final userPrefs = UserSharedPrefss();

            userPrefs.saveData<bool>('isLoggedInSave', false);
            Get.snackbar(
              maxWidth: 300,
              'Logout Successful',
              'You have been loggedout successfuly.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Yes',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ],
    ),
  );
}
