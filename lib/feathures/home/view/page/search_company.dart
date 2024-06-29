// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
// import 'package:venturelead/feathures/home/controller/companies_controller.dart';
// import 'package:venturelead/feathures/home/view/page/companies_home.dart';
// import 'package:venturelead/feathures/home/view/widget/navigation.dart';

// class HomeScreenSearch extends StatefulWidget {
//   const HomeScreenSearch({super.key});

//   @override
//   State<HomeScreenSearch> createState() => _HomeScreenSearchState();
// }

// final appBarController = Get.put(AppBarController());
// final ScrollController scrollController = ScrollController();

// cleanDescription(String description) {
//   return description.replaceAll(RegExp(r'<[^>]*>|&nbsp;'), '');
// }

// void scrollToTop() {
//   scrollController.animateTo(
//     0,
//     duration: const Duration(seconds: 1),
//     curve: Curves.easeInOut,
//   );
// }

// List<dynamic> searchCompanies(List<dynamic> companies, String searchText) {
//   final lowerSearchText = searchText.toLowerCase();

//   return companies.where((company) {
//     bool matches = false;

//     void checkField(dynamic value) {
//       if (value is String && value.toLowerCase().contains(lowerSearchText)) {
//         matches = true;
//       }
//     }

//     // Check main fields
//     checkField(company['name']);
//     checkField(company['address']);
//     checkField(company['email']);
//     checkField(company['phone']);
//     checkField(company['category']);
//     checkField(company['companyDescription']);
//     checkField(company['website']);
//     checkField(company['registration']);
//     checkField(company['facebook']);
//     checkField(company['basicDescription']);
//     checkField(company['marketDescription']);
//     checkField(company['businesstype']);
//     checkField(company['revenueStream']);

//     // Check nested fields
//     if (company['products'] is List) {
//       for (var product in company['products']) {
//         checkField(product['name']);
//         checkField(product['description']);
//       }
//     }

//     if (company['timelines'] is List) {
//       for (var timeline in company['timelines']) {
//         checkField(timeline['name']);
//         checkField(timeline['description']);
//         checkField(timeline['date']);
//       }
//     }

//     if (company['fundings'] is List) {
//       for (var funding in company['fundings']) {
//         checkField(funding['name']);
//         checkField(funding['description']);
//         checkField(funding['date']);
//       }
//     }

//     return matches;
//   }).toList();
// }

// class _HomeScreenSearchState extends State<HomeScreenSearch> {
//   final CompanyController companyController = Get.put(CompanyController());

//   final TextEditingController searchTextController = TextEditingController();

//   bool isSearchVisible = false;
//   var filteredCompanies = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//           controller: scrollController,
//           child: Column(
//             children: [
//               Container(
//                 color: Colors.blueGrey[700],
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(5.0),
//                       child: const Center(
//                         child: Text(
//                           'Company Listing',
//                           style: TextStyle(
//                             fontSize: 24,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Center(
//                         child: RichText(
//                           text: const TextSpan(
//                             text: 'A List of Companies Curated By ',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text: 'Venture',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: 'Led',
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.white),
//                         ),
//                         child: Row(
//                           children: [
//                             const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Icon(
//                                 Icons.search,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: TextField(
//                                   controller: searchTextController,
//                                   decoration: const InputDecoration(
//                                     hintText: 'Search Companies',
//                                     hintStyle: TextStyle(
//                                       color: Colors.white,
//                                     ),
//                                     border: InputBorder.none,
//                                   ),
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                   ),
//                                   onChanged: (value) {
//                                     setState(() {
//                                       isSearchVisible = value.isNotEmpty;
//                                     });
//                                   }),
//                             ),
//                             Visibility(
//                               visible: isSearchVisible,
//                               child: IconButton(
//                                 icon: const Icon(Icons.search,
//                                     color: Colors.white),
//                                 onPressed: () {
//                                   final searchText = searchTextController.text;
//                                   final searchResults = searchCompanies(
//                                       companyController.getCompanies,
//                                       searchText);

//                                   setState(() {
//                                     filteredCompanies = searchResults;
//                                     // companyController
//                                     //     .setCompanyEntity(searchResults);
//                                   });
//                                   //companyController.setCompanyEntity(searchResults);
//                                 },
//                               ),
//                             ),
//                             Visibility(
//                               visible: isSearchVisible,
//                               child: IconButton(
//                                 icon: const Icon(Icons.clear,
//                                     color: Colors.white),
//                                 onPressed: () {
//                                   searchTextController.clear();
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   color: Colors.white,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const SizedBox(height: 32),
//                       if (filteredCompanies.isEmpty)
//                         const Center(
//                           child: Text(
//                             'No search results',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       for (var company in filteredCompanies)
//                         GestureDetector(
//                           onTap: () {
//                             appBarController.showSearch.value = true;
//                             appBarController.showBack.value = true;
//                             appBarController.showBookmark.value = true;
//                             appBarController.showShare.value = true;
//                             appBarController.showCustomText.value = true;
//                             appBarController.customText.value = company['name'];
//                             companyController.setSelectedCompany(company);
//                             HomeController.to.selectedIndex.value = 7;
//                           },
//                           child: CompanyCard(
//                             logoUrl: 'assets/images/news.jpeg',
//                             name: company['name'],
//                             description:
//                                 cleanDescription(company['contentData']),
//                             category: company['category'],
//                             location: company['address'],
//                             businessType: company['businesstype'],
//                           ),
//                         ),
//                       const Spacer(),
//                       Center(
//                         child: ElevatedButton.icon(
//                           onPressed: () {
//                             // Filter button pressed
//                           },
//                           icon: const Icon(Icons.filter_list),
//                           label: const Text('Filters'),
//                           style: ElevatedButton.styleFrom(
//                             foregroundColor: Colors.white,
//                             backgroundColor: Colors.black,
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 24,
//                               vertical: 12,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: RawMaterialButton(
//           onPressed: scrollToTop,
//           elevation: 6.0,
//           fillColor: Colors.grey[900],
//           shape: const CircleBorder(),
//           padding: const EdgeInsets.all(16.0),
//           child: const Icon(
//             Icons.arrow_upward,
//             color: Colors.white,
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/feathures/home/controller/appbar_controller.dart';
import 'package:venturelead/feathures/home/controller/companies_controller.dart';
import 'package:venturelead/feathures/home/view/page/companies_home.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class HomeScreenSearch extends StatefulWidget {
  const HomeScreenSearch({super.key});

  @override
  State<HomeScreenSearch> createState() => _HomeScreenSearchState();
}

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

List<dynamic> searchCompanies(List<dynamic> companies, String searchText) {
  final lowerSearchText = searchText.toLowerCase();

  return companies.where((company) {
    bool matches = false;

    void checkField(dynamic value) {
      if (value is String && value.toLowerCase().contains(lowerSearchText)) {
        matches = true;
      }
    }

    // Check main fields
    checkField(company['name']);
    checkField(company['address']);
    checkField(company['email']);
    checkField(company['phone']);
    checkField(company['category']);
    checkField(company['companyDescription']);
    checkField(company['website']);
    checkField(company['registration']);
    checkField(company['facebook']);
    checkField(company['basicDescription']);
    checkField(company['marketDescription']);
    checkField(company['businesstype']);
    checkField(company['revenueStream']);

    // Check nested fields
    if (company['products'] is List) {
      for (var product in company['products']) {
        checkField(product['name']);
        checkField(product['description']);
      }
    }

    if (company['timelines'] is List) {
      for (var timeline in company['timelines']) {
        checkField(timeline['name']);
        checkField(timeline['description']);
        checkField(timeline['date']);
      }
    }

    if (company['fundings'] is List) {
      for (var funding in company['fundings']) {
        checkField(funding['name']);
        checkField(funding['description']);
        checkField(funding['date']);
      }
    }

    return matches;
  }).toList();
}

class _HomeScreenSearchState extends State<HomeScreenSearch> {
  final CompanyController companyController = Get.put(CompanyController());

  final TextEditingController searchTextController = TextEditingController();

  bool isSearchVisible = false;
  var filteredCompanies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blueGrey[700],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: const Center(
                    child: Text(
                      'Company Listing',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: RichText(
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
                  ),
                ),
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
                            controller: searchTextController,
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
                            onChanged: (value) {
                              setState(() {
                                isSearchVisible = value.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: isSearchVisible,
                          child: IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              final searchText = searchTextController.text;
                              final searchResults = searchCompanies(
                                  companyController.getCompanies, searchText);

                              setState(() {
                                filteredCompanies = searchResults;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: isSearchVisible,
                          child: IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                isSearchVisible = false;
                                searchTextController.clear();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                if (filteredCompanies.isEmpty)
                  const Center(
                    child: Text(
                      'No search results',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                for (var company in filteredCompanies)
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
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Filter button pressed
                    },
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filters'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 216, 106, 98),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const RawMaterialButton(
        onPressed: scrollToTop,
        elevation: 6.0,
        fillColor: Color.fromARGB(255, 216, 106, 98),
        shape: CircleBorder(),
        padding: EdgeInsets.all(16.0),
        child: Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
    );
  }
}
