// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
// import 'package:venturelead/feathures/auth/model/user_model.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   File? img;
//   final User user = Get.find<AuthController>().authState.value.authEntity;

//   void showEditProfileModal(BuildContext context) {
//     TextEditingController nameController =
//         TextEditingController(text: user.username);
//     TextEditingController emailController =
//         TextEditingController(text: user.email);
//     TextEditingController bioController =
//         TextEditingController(text: user.bio ?? 'No bio available');



//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
//       ),
//       builder: (context) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//           left: 16.0,
//           right: 16.0,
//           top: 24.0,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Edit Profile', style: TextStyle(fontSize: 18.0)),
//                 Row(
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context); // Close the modal
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('You have cancelled the update.'),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       },
//                       child: const Text('Cancel',
//                           style: TextStyle(color: Colors.red)),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // updateProfile(
//                         //   nameController.text,
//                         //   emailController.text,
//                         //   bioController.text,
//                         //   picture,
//                         // );
//                         Navigator.pop(context);
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Your profile has been updated.'),
//                             backgroundColor: Colors.green,
//                           ),
//                         );
//                       },
//                       child: const Text('Save',
//                           style: TextStyle(color: Colors.green)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Card(
//               child: Stack(
//                 children: [
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundImage: img != null
//                         ? FileImage(img!) as ImageProvider<Object>?
//                         : NetworkImage(user.picture!),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: CircleAvatar(
//                       radius: 15,
//                       backgroundColor: Colors.black54,
//                       child: IconButton(
//                         icon: const Icon(Icons.edit, size: 15),
//                         onPressed: () {
//                           browseImage(ImageSource.gallery, user.email);
//                         },
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: bioController,
//               maxLines: 5,
//               decoration: const InputDecoration(
//                 labelText: 'Bio',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }
