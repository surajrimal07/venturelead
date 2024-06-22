import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/auth/controller/auth_network_controller.dart';
import 'package:venturelead/feathures/auth/model/user_model.dart';

void showInterestCustomizeSetting(BuildContext context) {
  final User user = Get.find<AuthController>().authState.value.authEntity;
  final userName = user.username;
  List<String> interestNames = [];

  if (user.interests != null && user.interests!.isNotEmpty) {
    String interestString = user.interests![0];
    interestString = interestString.substring(1, interestString.length - 1);

    interestNames =
        interestString.split(',').map((item) => item.trim()).toList();
  }

  bool businessAndTechNews = interestNames.contains('Business and Tech News');
  bool discoverNewBusiness = interestNames.contains('Discover New Business');
  bool ecosystemInsights = interestNames.contains('Ecosystem Insights');
  bool eventAnnouncements = interestNames.contains('Event Announcements');
  bool fundingAndInvestments =
      interestNames.contains('Funding and Investments');
  bool generalNews = interestNames.contains('General News');
  bool governmentInitiatives =
      interestNames.contains('Government Initiatives and Insights');

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
        top: 10.0,
      ),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                text: 'VENTURE',
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'LED',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                            Get.showSnackbar(const GetSnackBar(
                              title: 'Update Cancelled',
                              message: 'No changes were made.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 1),
                            ));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: userName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                            text: " We'd love to personalise your experience",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Tell us what you're looking for",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Select as many as you want.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Business and Tech News'),
                subtitle: const Text(
                    'Latest news about economy, finance, technology, etc.'),
                leading: Checkbox(
                  activeColor: Colors.red,
                  value: businessAndTechNews,
                  onChanged: (val) =>
                      setState(() => businessAndTechNews = val!),
                ),
              ),
              ListTile(
                title: const Text('Discover New Business'),
                subtitle: const Text(
                    'Companies developing innovative products and solutions'),
                leading: Checkbox(
                  activeColor: Colors.red,
                  value: discoverNewBusiness,
                  onChanged: (val) =>
                      setState(() => discoverNewBusiness = val!),
                ),
              ),
              ListTile(
                title: const Text('Ecosystem Insights'),
                subtitle: const Text(
                    'Key insights and trends in the business ecosystem'),
                leading: Checkbox(
                  activeColor: Colors.red,
                  value: ecosystemInsights,
                  onChanged: (val) => setState(() => ecosystemInsights = val!),
                ),
              ),
              ListTile(
                title: const Text('Event Announcements'),
                subtitle: const Text(
                    'Know about the latest tech and business events'),
                leading: Checkbox(
                  activeColor: Colors.red,
                  value: eventAnnouncements,
                  onChanged: (val) => setState(() => eventAnnouncements = val!),
                ),
              ),
              ListTile(
                title: const Text('Funding and Investments'),
                subtitle: const Text(
                    'Latest news about startup funding, deals, M&As, and exits'),
                leading: Checkbox(
                  activeColor: Colors.red,
                  value: fundingAndInvestments,
                  onChanged: (val) =>
                      setState(() => fundingAndInvestments = val!),
                ),
              ),
              ListTile(
                title: const Text('General News'),
                subtitle: const Text('All the latest news and headlines'),
                leading: Checkbox(
                  activeColor: Colors.red,
                  value: generalNews,
                  onChanged: (val) => setState(() => generalNews = val!),
                ),
              ),
              ListTile(
                title: const Text('Government Initiatives and Insights'),
                subtitle: const Text(
                    'Insights on government initiatives and policies'),
                leading: Checkbox(
                  activeColor: Colors.red,
                  value: governmentInitiatives,
                  onChanged: (val) =>
                      setState(() => governmentInitiatives = val!),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24), // Spacer
                  ElevatedButton(
                    onPressed: () async {
                      final email = user.email;

                      List<String> selectedTitles = [];
                      if (businessAndTechNews) {
                        selectedTitles.add('Business and Tech News');
                      }
                      if (discoverNewBusiness) {
                        selectedTitles.add('Discover New Business');
                      }
                      if (ecosystemInsights) {
                        selectedTitles.add('Ecosystem Insights');
                      }
                      if (eventAnnouncements) {
                        selectedTitles.add('Event Announcements');
                      }
                      if (fundingAndInvestments) {
                        selectedTitles.add('Funding and Investments');
                      }
                      if (generalNews) selectedTitles.add('General News');
                      if (governmentInitiatives) {
                        selectedTitles
                            .add('Government Initiatives and Insights');
                      }

                      FormData formData = FormData.fromMap({
                        'email': email,
                        'interests': '{${selectedTitles.join(', ')}}',
                      });

                      bool updateProfile =
                          await handleUpdateController(formData);

                      if (updateProfile) {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(150, 40),
                    ),
                    child: const Text('Save',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ],
          );
        },
      ),
    ),
  );
}
