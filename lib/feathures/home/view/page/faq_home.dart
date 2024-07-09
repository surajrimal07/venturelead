import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/common/presentation/widget/privacy_common.dart';
import 'package:venturelead/feathures/common/presentation/widget/terms_common.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/controller/faq_controller.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  FAQScreenState createState() => FAQScreenState();
}

class FAQScreenState extends State<FAQScreen> {
  final AppBarController appBarController = Get.put(AppBarController());
  final FAQController faqController = Get.put(FAQController());
  int? expandedIndex;

  @override
  void initState() {
    super.initState();
    fetchFAQ();
  }

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
            child: Obx(() {
              if (faqController.faq.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: faqController.faq.length,
                itemBuilder: (context, index) {
                  final faqItem = faqController.faq[index];
                  return _buildFAQItem(
                    faqItem.question,
                    faqItem.answer,
                    index,
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'By continuing you agree to our ',
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: 'Terms of Service',
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(const TermsOfService());
                      },
                  ),
                  const TextSpan(
                    text: ' and ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(const PrivacyPolicy());
                      },
                  ),
                  const TextSpan(
                    text: '.',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
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
