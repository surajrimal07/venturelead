// import 'package:flutter/material.dart';

// class BookmarkScreen extends StatelessWidget {
//   const BookmarkScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 40),
//             Image.asset(
//               'assets/images/bookmark.png',
//               width: 200,
//               height: 200,
//             ),
//             const SizedBox(height: 15),
//             const Text(
//               'No bookmark',
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bookmarks',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                ),
                Text(
                  "Don't miss on your favorites",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildBookmarkItem(
                  'assets/images/news.jpeg',
                  'The Game called Entrepreneurship for Startup Enthusiasts',
                  'August02,2020',
                ),
                _buildBookmarkItem(
                  'assets/images/news.jpeg',
                  'List of Mobile App Performance Metrics to Gauge the Success of App',
                  'October18,2019',
                ),
                _buildBookmarkItem(
                  'assets/images/news.jpeg',
                  'What are thelatest artificial intelligence trends?',
                  'June10,2020',
                ),
                _buildBookmarkItem(
                  'assets/images/news.jpeg',
                  "'Failure is there to teach you something'-40quotes from business journeys",
                  'May05,2020',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkItem(String imagePath, String title, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.bookmark, color: Colors.black),
        ],
      ),
    );
  }
}
