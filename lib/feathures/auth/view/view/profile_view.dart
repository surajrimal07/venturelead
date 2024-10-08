import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:venturelead/core/utils/shared_prefs.dart';
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/auth/controller/auth_network_controller.dart';
import 'package:venturelead/feathures/auth/model/user_model.dart';
import 'package:venturelead/feathures/auth/view/view/login_auth.dart';
import 'package:venturelead/feathures/auth/view/widget/connection_widget.dart';
import 'package:venturelead/feathures/auth/view/widget/interestcard_widget.dart';
import 'package:venturelead/feathures/auth/view/widget/settings_widget.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileScreen> {
  String selectedTab = 'About';

  final AuthController authController = Get.find<AuthController>();
  final AppBarController appBarController = Get.put(AppBarController());

  final User user = Get.find<AuthController>().authState.value.authEntity;
  File? img;

  List<String> interestNames = [];

  Future browseImage(ImageSource imageSource, String email) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  void showEditProfileModal(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: user.username);
    TextEditingController emailController =
        TextEditingController(text: user.email);
    TextEditingController bioController =
        TextEditingController(text: user.bio ?? 'No bio available');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16.0,
          right: 16.0,
          top: 24.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Edit Profile', style: TextStyle(fontSize: 18.0)),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('You have cancelled the update.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Get.showSnackbar(const GetSnackBar(
                          title: 'Info',
                          message: 'Please wait ...',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                        ));

                        FormData formData = FormData.fromMap({
                          'username': nameController.text,
                          'email': emailController.text,
                          'bio': bioController.text,
                        });

                        if (img != null) {
                          formData.files.add(
                            MapEntry(
                              'picture',
                              await MultipartFile.fromFile(
                                img!.path,
                                filename: img!.path.split('/').last,
                              ),
                            ),
                          );
                        }

                        bool updateProfile =
                            await handleUpdateController(formData);

                        if (updateProfile) {
                          Navigator.pop(context);
                        }
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Save',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Card(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: img != null
                        ? FileImage(img!) as ImageProvider<Object>?
                        : NetworkImage(user.picture!),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 15),
                        onPressed: () async {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                              ),
                              builder: (context) => Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            checkCameraPermission();

                                            browseImage(
                                                ImageSource.camera, user.email);
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.camera),
                                          label: const Text('Camera'),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () async {
                                            browseImage(ImageSource.gallery,
                                                user.email);

                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.image),
                                          label: const Text('Gallery'),
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bioController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPrefs = UserSharedPrefss();
    final RxString selectedTab = 'About'.obs;

    if (user.interests != null && user.interests!.isNotEmpty) {
      String interestString = user.interests![0];
      interestString = interestString.substring(1, interestString.length - 1);

      interestNames =
          interestString.split(',').map((item) => item.trim()).toList();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40,
        actions: [
          TextButton(
            onPressed: () {
              showEditProfileModal(context);
            },
            child: const Text(
              'Edit Profile',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.red,
        onRefresh: () async {
          final email = await userPrefs.getData<String>('email') ?? '';
          final password = await userPrefs.getData<String>('password') ?? '';

          bool isLoggedIn =
              await handleLoginController(email, password, refresh: true);
          if (!isLoggedIn) {
            Get.offAll(const LoginScreen());
            userPrefs.saveData<bool>('isLoggedInSave', false);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                  radius: 50, backgroundImage: NetworkImage(user.picture!)),
              //const SizedBox(height: 10),
              Text(
                user.username,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(user.email),
              const SizedBox(height: 4),
              Text(
                'Employee of ${user.employeeCompanyIds != null && user.employeeCompanyIds!.isNotEmpty ? user.employeeCompanyIds!.join(', ') : 'None'}',
              ),
              const SizedBox(height: 5),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    TextButton(
                      onPressed: () {
                        selectedTab.value = 'About';
                      },
                      child: Obx(() => Text(
                            'About',
                            style: TextStyle(
                              color: selectedTab.value == 'About'
                                  ? Colors.red
                                  : Colors.grey,
                              fontWeight: selectedTab.value == 'About'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          )),
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        selectedTab.value = 'Interests';
                      },
                      child: Obx(() => Text(
                            'Interests',
                            style: TextStyle(
                              color: selectedTab.value == 'Interests'
                                  ? Colors.red
                                  : Colors.grey,
                              fontWeight: selectedTab.value == 'Interests'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          )),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        selectedTab.value = 'Settings';
                      },
                      child: Obx(() => Text(
                            'Settings',
                            style: TextStyle(
                              color: selectedTab.value == 'Settings'
                                  ? Colors.red
                                  : Colors.grey,
                              fontWeight: selectedTab.value == 'Settings'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          )),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        selectedTab.value = 'Connections';
                      },
                      child: Obx(() => Text(
                            'Connections',
                            style: TextStyle(
                              color: selectedTab.value == 'Connections'
                                  ? Colors.red
                                  : Colors.grey,
                              fontWeight: selectedTab.value == 'Connections'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          )),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        selectedTab.value = 'Reviews';
                      },
                      child: Obx(() => Text(
                            'Reviews',
                            style: TextStyle(
                              color: selectedTab.value == 'Reviews'
                                  ? Colors.red
                                  : Colors.grey,
                              fontWeight: selectedTab.value == 'Reviews'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (selectedTab.value == 'About') return AboutCard(user);
                if (selectedTab.value == 'Interests') {
                  return InterestCard(interests: interestNames);
                }
                if (selectedTab.value == 'Settings') return SettingsCard();
                if (selectedTab.value == 'Connections') {
                  return ConnectionCard(user: user);
                }
                if (selectedTab.value == 'Reviews') {
                  return const ReviewCard();
                }
                return Container();
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: () {
          appBarController.showBack.value = true;
          appBarController.showCustomText.value = true;
          appBarController.customText.value = 'FAQ';
          appBarController.showBookmark.value = false;
          appBarController.showNotificationIcon.value = false;
          HomeController.to.selectedIndex.value = 10;
        },
        elevation: 6.0,
        fillColor: const Color.fromARGB(255, 216, 106, 98),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16.0),
        child: const Icon(
          Icons.support_agent,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 600,
      width: 400,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Bio',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 8),
            Text(
              "You have not made any review so far, you can review company after you have made a successfuly connection with them.",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class AboutCard extends StatelessWidget {
  final User user;
  const AboutCard(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user.bio ??
                  "You haven't told us anything about yourself. Please add your bio to complete your user profile.",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
