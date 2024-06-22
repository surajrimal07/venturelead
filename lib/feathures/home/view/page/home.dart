import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/controller/companies_controller.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});
  final appBarController = Get.put(AppBarController());

  final CompanyController companyController = Get.put(CompanyController());

  cleanDescription(String description) {
    return description.replaceAll(RegExp(r'<[^>]*>|&nbsp;'), '');
  }

  cleanFoundedDate(String date) {
    return date.substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    final companies = companyController.getCompanies;

    Widget buildCompanyCard(company) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Image(
                      image: AssetImage('assets/images/karkhana.png'),
                      height: 50),
                  const SizedBox(width: 10),
                  Text(
                    company['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.bookmark_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      Share.share(
                          'Check out this company: ${company['name']} in VentureLead App!');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                // company['basicDescription'],
                cleanDescription(company['basicDescription']),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CoreTeam'),
                      SizedBox(height: 5),
                      Text('1. Pavitra Gautam'),
                      Text('2. Sakar Pudasaini'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Industries'),
                      const SizedBox(height: 5),
                      Text(company['category']),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Founded: ${cleanFoundedDate(company['registration'])}'),
                  ElevatedButton(
                    onPressed: () {
                      appBarController.showSearch.value = true;
                      appBarController.showBack.value = true;
                      appBarController.showBookmark.value = true;
                      appBarController.showShare.value = true;
                      appBarController.showCustomText.value = true;
                      appBarController.customText.value = company['name'];

                      companyController.setSelectedCompany(company);

                      // companyController.companyState.value
                      //     .copyWith(selectedCompany: company);

                      HomeController.to.selectedIndex.value = 7;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'View Profile',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onTap: () {
                  HomeController.to.selectedIndex.value = 6;
                },
                decoration: InputDecoration(
                  hintText: 'Search news, companies here',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Recently Added',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      HomeController.to.selectedIndex.value = 4;
                    },
                    child: const Text('Latest News',
                        style: TextStyle(color: Colors.grey)),
                  ),
                  TextButton(
                    onPressed: () {
                      appBarController.showSearch.value = true;
                      appBarController.showBack.value = true;
                      appBarController.showBookmark.value = true;

                      HomeController.to.selectedIndex.value = 5;
                    },
                    child: const Text('For You',
                        style: TextStyle(color: Colors.grey)),
                  )
                ],
              ),
              const SizedBox(height: 10),
              for (var company in companies) buildCompanyCard(company),
            ],
          ),
        ),
      ),
    );
  }
}
