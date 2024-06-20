import 'package:flutter/material.dart';

class HomeScreenSearch extends StatelessWidget {
  const HomeScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Section
          Container(
            color: Colors.blueGrey[700], // Dark grey background color
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(5.0), // Padding inside the container
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
                  padding:
                      const EdgeInsets.all(5.0), // Padding inside the container
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
                    // child: Text(
                    //   'A List of Companies Curated By ',
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.white70,
                    //   ),
                    // ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color:
                              Colors.white), // Add border to match the design
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(
                              8.0), // Padding for the search icon
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search Companies',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            // Clear search field
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Section
          Expanded(
            child: Container(
              color: Colors.white, // White background color
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 32),
                  const Center(
                    child: Text(
                      'No search results',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Filter button pressed
                      },
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filters'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
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
          ),
        ],
      ),
    );
  }
}
