import 'package:flutter/material.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    void scrollToTop() {
      scrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }

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
                    // Text(
                    //   'List of Companies Curated By VentureLed',
                    //   style: TextStyle(
                    //     color: Colors.grey[300],
                    //     fontSize: 16,
                    //   ),
                    // ),
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
                            IconButton(
                              icon:
                                  const Icon(Icons.clear, color: Colors.white),
                              onPressed: () {
                                // Clear search field
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // TextField(
                    //   onTap: () => {HomeController.to.selectedIndex.value = 6},
                    //   decoration: InputDecoration(
                    //     hintText: 'Search Companies',
                    //     hintStyle: const TextStyle(
                    //         color: Color.fromARGB(255, 255, 255, 255)),
                    //     prefixIcon: const Icon(Icons.search,
                    //         color: Color.fromARGB(255, 255, 255, 255)),
                    //     filled: true,
                    //     border: OutlineInputBorder(
                    //       borderSide:
                    //           const BorderSide(width: 2.0, color: Colors.white),
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //     fillColor: Colors.blueGrey[700],
                    //   ),
                    // ),

                    //  const SizedBox(height: 10),
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
              const CompanyCard(
                logoUrl: 'assets/images/news.jpeg',
                name: 'SignalOne',
                description:
                    'SignalOne is the first modern B2B technology platform for real estate in Nepal. The platform brings new technology',
                category: 'Technology, Real Estate',
                location: 'Kathmandu, Nepal',
                businessType: 'B2C',
              ),
              const CompanyCard(
                logoUrl: 'assets/images/news.jpeg',
                name: 'FoodKart',
                description:
                    'Founded in 2010 FoodKart is a pioneer in the foodtech space, building the first global Intelligent food cold storage',
                category: 'FoodTech',
                location: 'Chitwan, Nepal',
                businessType: 'B2B',
              ),
              const CompanyCard(
                logoUrl: 'assets/images/news.jpeg',
                name: 'StudioOne',
                description:
                    'StudioOne Pvt Ltd, a active young studio for sounds and soundtech. Studio One brings new innovation to the sound industry',
                category: 'SoundTech',
                location: 'Kathmandu, Nepal',
                businessType: 'B2C',
              ),
            ],
          ),
        ),
        floatingActionButton: RawMaterialButton(
          onPressed: scrollToTop,
          elevation: 6.0,
          fillColor: Colors.grey[900],
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
