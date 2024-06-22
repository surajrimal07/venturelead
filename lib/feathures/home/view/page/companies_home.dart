import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/controller/companies_controller.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class CompanyPage extends StatelessWidget {
  CompanyPage({super.key});
  final CompanyController companyController = Get.put(CompanyController());
  final appBarController = Get.put(AppBarController());
  final ScrollController scrollController = ScrollController();

  cleanDescription(String description) {
    return description.replaceAll(RegExp(r'<[^>]*>|&nbsp;'), '');
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final companies = companyController.getCompanies;

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.blueGrey[700],
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      'Company Listing',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: const TextSpan(
                        text: 'A List of Companies Curated By ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Venture',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Led',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                onTap: () =>
                                    {HomeController.to.selectedIndex.value = 6},
                                decoration: const InputDecoration(
                                  hintText: 'Search Companies',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // IconButton(
                            //   icon:
                            //       const Icon(Icons.clear, color: Colors.white),
                            //   onPressed: () {
                            //     // Clear search field
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Featured',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              for (var company in companies)
                GestureDetector(
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
                  child: CompanyCard(
                    logoUrl: 'assets/images/news.jpeg',
                    name: company['name'],
                    description: cleanDescription(company['contentData']),
                    category: company['category'],
                    location: company['address'],
                    businessType: company['businesstype'],
                  ),
                ),
            ],
          ),
        ),
        floatingActionButton: RawMaterialButton(
          onPressed: scrollToTop,
          elevation: 6.0,
          fillColor: const Color.fromARGB(255, 216, 106, 98),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(16.0),
          child: const Icon(
            Icons.arrow_upward,
            color: Colors.white,
          ),
        ));
  }
}

class CompanyCard extends StatelessWidget {
  final String logoUrl;
  final String name;
  final String description;
  final String category;
  final String location;
  final String businessType;

  const CompanyCard({
    super.key,
    required this.logoUrl,
    required this.name,
    required this.description,
    required this.category,
    required this.location,
    required this.businessType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(logoUrl, width: 50, height: 50),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        businessType,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.label, color: Colors.grey[600], size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          category,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[700],
                                  ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.location_on,
                          color: Colors.grey[600], size: 16),
                      const SizedBox(width: 4),
                      Text(
                        location,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[700],
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
