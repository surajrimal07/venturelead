import 'package:flutter/material.dart';
import 'package:venturelead/feathures/auth/view/widget/interest_settings.dart';

class InterestCard extends StatelessWidget {
  final List<String> interests;

  const InterestCard({super.key, required this.interests});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'News Interest',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
                const SizedBox(width: 190),
                GestureDetector(
                  onTap: () {
                    showInterestCustomizeSetting(context);
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Customise',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            interests.isEmpty
                ? _buildEmptyInterestCard()
                : _buildInterestCardWithData(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyInterestCard() {
    return Column(
      children: [
        Image.asset('assets/images/news.jpeg', height: 100),
        const SizedBox(height: 16),
        const Text('No Interests found'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Add Topics'),
        ),
      ],
    );
  }

  Widget _buildInterestCardWithData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: interests
          .map((interest) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: InterestItem(interest: interest),
              ))
          .toList(),
    );
  }
}

class InterestItem extends StatelessWidget {
  final String interest;

  const InterestItem({super.key, required this.interest});

  @override
  Widget build(BuildContext context) {
    String subtitle = _getSubtitle(interest);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          interest,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  String _getSubtitle(String interest) {
    switch (interest) {
      case 'Business and Tech News':
        return 'Latest news about economy, finance, technology, etc.';
      case 'Discover New Business':
        return 'Companies developing innovative products and solutions';
      case 'Ecosystem Insights':
        return 'Key insights and trends in the business ecosystem';
      case 'Event Announcements':
        return 'Know about the latest tech and business events';
      case 'Funding and Investments':
        return 'Latest news about startup funding, deals, M&As, and exits';
      case 'General News':
        return 'All the latest news and headlines';
      case 'Government Initiatives and Insights':
        return 'Insights on government initiatives and policies';
      default:
        return 'Description not available';
    }
  }
}
