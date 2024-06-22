import 'package:flutter/material.dart';

class TargetMarketUI extends StatelessWidget {
  const TargetMarketUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Target Market',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Chip(
              label: Text('B2B', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 8),
            const Text('Student and parents'),
            const SizedBox(height: 16),
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
                Text('Science Tools', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recently Added',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All >'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: _buildRecentlyAddedCard('NdS', 'Outside Studio',
                        'An impact-driven design\n& technology studio')),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildRecentlyAddedCard('Δ', 'Delta Tech',
                        'Sales tracking, field\nsales automation')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          const Text(': '),
          Expanded(
            flex: 3,
            child: Text(content),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyAddedCard(
      String logo, String title, String description) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              logo,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(description,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
