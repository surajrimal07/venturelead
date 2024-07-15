import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:venturelead/core/utils/customWebview.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/controller/companies_controller.dart';
import 'package:venturelead/feathures/home/controller/connection_controller.dart';
import 'package:venturelead/feathures/home/controller/network_controller.dart';
import 'package:venturelead/feathures/home/view/widget/claim_modal.dart';
import 'package:venturelead/feathures/home/view/widget/connection.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';
import 'package:venturelead/feathures/home/view/widget/rate_modal.dart';

class CompanyDetails extends StatelessWidget {
  CompanyDetails({super.key});

  final CompanyController companyController = Get.put(CompanyController());
  static HomeController get to => Get.find<HomeController>();
  static AppBarController appBarController = Get.find<AppBarController>();
  final connectionController = Get.put(ConnectionController());

  shortText(String text) {
    return text.substring(0, 30);
  }

  cleanDescription(String description) {
    return description.replaceAll(RegExp(r'<[^>]*>|&nbsp;'), '');
  }

  cleanFoundedDate(String date) {
    return date.substring(0, 10);
  }

  Future<void> _launchEmail(String email) async {
    if (!await launchUrl(Uri(scheme: 'mailto'))) {
      Get.snackbar(
        'Error',
        'Could not send email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(color: Colors.red)),
    );
  }

  Widget _buildMediaItem(String title) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 60,
          color: Colors.grey[300],
          child: const Center(child: Text('Image')),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(title)),
      ],
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    try {
      await launchUrl(launchUri);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not make phone call',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: TextStyle(color: Colors.grey[600])),
          ),
          const Text(': '),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildCoreTeamRow(
      String label, String value, String link, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: TextStyle(color: Colors.grey[600])),
          ),
          Text(': $role: $value'),
          const SizedBox(width: 10),
          Expanded(
              child: GestureDetector(
            onTap: () {
              Get.to(const WebViewPage(
                  name: 'Linkedin', url: 'https://www.linkedin.com'));
            },
            child: const FaIcon(FontAwesomeIcons.linkedin,
                size: 18, color: Colors.blue),
          )),
        ],
      ),
    );
  }

  _refreshCompanies() async {
    await fetchAllCompanies();
  }

  @override
  Widget build(BuildContext context) {
    final company = companyController.getSelectedCompany;
    final recentCompanies = companyController.getCompanies.take(5);

    return Scaffold(
      body: RefreshIndicator(
        color: Colors.red,
        onRefresh: () async {
          await _refreshCompanies();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.handyman,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  shortText(company['companyDescription']),
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text(
                  company['name'],
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  cleanDescription(company['companyDescription']),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(label: Text(company['category'])), //only one category
                    const Chip(label: Text('Manufacturing')),
                    const Chip(label: Text('STEM')),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: company['website'] != null,
                      child: IconButton(
                          icon: const FaIcon(FontAwesomeIcons.globe),
                          onPressed: () {
                            Get.to(WebViewPage(
                                name: 'Website', url: company['website']));
                          }),
                    ),
                    Visibility(
                      visible: company['facebook'] != null,
                      child: IconButton(
                          icon: const FaIcon(FontAwesomeIcons.facebook),
                          onPressed: () {
                            Get.to(WebViewPage(
                                name: 'Facebook', url: company['facebook']));
                          }),
                    ),
                    Visibility(
                      visible: company['email'] != null,
                      child: IconButton(
                          icon: const FaIcon(
                            Icons.email,
                            size: 31,
                          ),
                          onPressed: () {
                            _launchEmail(company['email']);
                          }),
                    ),
                    Visibility(
                      visible: company['phone'] != null,
                      child: IconButton(
                          icon: const FaIcon(FontAwesomeIcons.phone),
                          onPressed: () {
                            _makePhoneCall(company['phone']);
                          }),
                    ),
                    IconButton(
                        icon: const FaIcon(FontAwesomeIcons.twitter),
                        onPressed: () {
                          Get.to(WebViewPage(
                              name: 'Facebook', url: company['twitter']));
                        }),
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.googlePlay),
                      onPressed: () {
                        Get.to(WebViewPage(
                            name: 'Facebook',
                            url: company['playStore'] ?? company['appStore']));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.values[5],
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.red),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (BuildContext context) {
                            connectionController.companyId.value =
                                company['_id'];
                            return const ConnectionModel();
                          },
                        );
                      },
                      child: const Text('CONNECT'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.red),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const ClaimModal();
                          },
                        );
                      },
                      child: const Text('CLAIM'),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Detailed Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  cleanDescription(company['contentData']),
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     child: const Text('More details',
                //         style: TextStyle(color: Colors.blue)),
                //     onPressed: () {},
                //   ),
                // ),
                _buildInfoRow('Legal Name', company['name'] + ' Pvt. Ltd.'),
                _buildInfoRow('Headquarter', company['address']),
                _buildInfoRow('Business Model', company['businesstype']),
                _buildInfoRow('Founding Date', company['registration']),
                _buildInfoRow('No. of Employee', '<10'),
                // _buildInfoRow('Core Team', 'Pavitra Gautam'),
                _buildCoreTeamRow(
                    'Core Team', 'Pavitra Gautam', 'linkedin', 'CEO'),
                _buildCoreTeamRow('', 'Sakar Pudasaini', 'linkedin', 'CTO'),

                const SizedBox(height: 10),
                const Text(
                  'Revenue Stream',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildChip('Subscription'),
                    const SizedBox(width: 8),
                    _buildChip('Product'),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Media',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildMediaItem('Karkhana: Innovative space for curious mind'),
                const SizedBox(height: 8),
                _buildMediaItem(
                    'Karkhana: Innovative space for curious mind News 2'),
                const SizedBox(height: 10),
                const Text(
                  'Target Market',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Wrap(
                //   spacing: 8,
                //   children: [
                //     Chip(label: Text(company['category'])), //only one category
                //     // const Chip(label: Text('Manufacturing')),
                //     // const Chip(label: Text('STEM')),
                //   ],
                // ),
                // const Chip(
                //   label: Text('B2B', style: TextStyle(color: Colors.white)),
                //   backgroundColor: Colors.grey,
                // ),
                const SizedBox(height: 8),
                _buildInfoRow('Target Audience', 'Student and parents'),

                _buildInfoRow('Client Segment',
                    'Mobility/Transportation\nConsumer Electronics,\nEdtech /Manufacturing'),
                _buildInfoRow(
                    'Target Companies', 'Large Enterprise,Medium\nEnterprise'),
                _buildInfoRow('Target Geography', 'Tier 1 cities, Nepal'),
                const SizedBox(height: 24),
                const Text(
                  'Products and Services',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Icon(Icons.science, color: Colors.red, size: 32),
                    SizedBox(width: 8),
                    Text('Science Tools and technologies',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recently Added',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        appBarController.showBack.value = false;
                        appBarController.showCustomText.value = false;
                        appBarController.showShare.value = false;

                        appBarController.showSearch.value = false;
                        HomeController.to.selectedIndex.value = 2;
                      },
                      child: const Text('View All >',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: recentCompanies.map((company) {
                    return Expanded(
                      child: Card(
                        child: GestureDetector(
                          onTap: () {
                            appBarController.showSearch.value = true;
                            appBarController.showBack.value = true;
                            appBarController.showBookmark.value = true;
                            appBarController.showShare.value = true;
                            appBarController.showCustomText.value = true;
                            appBarController.customText.value = company['name'];

                            companyController.setSelectedCompany(company);
                            HomeController.to.selectedIndex.value = 7;
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset('assets/images/karkhana.png',
                                    width: 170, height: 90),
                                const SizedBox(height: 8),
                                Text(company['name'],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text(company['companyDescription'],
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
                // Row(
                //   children: [
                //     Expanded(
                //         child: _buildRecentlyAddedCard(
                //             recentCompanies,
                //             'Outside Studio',
                //             'An impact-driven design\n& technology studio')),
                //     const SizedBox(width: 16),
                //     Expanded(
                //         child: _buildRecentlyAddedCard('Δ', 'Delta Tech',
                //             'Sales tracking, field\nsales automation')),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (BuildContext context) {
              connectionController.companyId.value = company['_id'];
              return const RatingModal();
            },
          );
        },
        elevation: 6.0,
        fillColor: const Color.fromARGB(255, 216, 106, 98),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16.0),
        child: const Icon(
          Icons.star_border_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
