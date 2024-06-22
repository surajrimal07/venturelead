import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final AppBarController appBarController = Get.put(AppBarController());
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'How can we help you?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your keyword',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Top Questions',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: const Text('View all',
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildFAQItem(
                    'How to create a account?',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse .......',
                    0),
                _buildFAQItem('How can we change password?', '', 1),
                _buildFAQItem('How to update company information?', '', 2),
                _buildFAQItem('How to claim the company?', '', 3),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appBarController.showBack.value = true;
          appBarController.showCustomText.value = true;
          appBarController.customText.value = 'Contact Us';
          appBarController.showBookmark.value = false;
          appBarController.showNotificationIcon.value = false;
          HomeController.to.selectedIndex.value = 11;
        },
        backgroundColor: const Color.fromARGB(255, 216, 106, 98),
        child: const Icon(
          Icons.headset_mic,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer, int index) {
    bool isExpanded = expandedIndex == index;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ExpansionTile(
        title:
            Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: isExpanded
            ? const Icon(Icons.remove, color: Colors.red)
            : const Icon(Icons.add, color: Colors.red),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(answer),
          ),
        ],
        onExpansionChanged: (expanded) {
          setState(() {
            expandedIndex = expanded ? index : null;
          });
        },
      ),
    );
  }
}
