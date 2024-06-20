import 'package:flutter/material.dart';

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
                    print('Customise clicked');
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Customise',
                      style: TextStyle(color: Colors.grey),
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
        Image.asset('assets/images/news.jpeg', //empty assest
            height: 100),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          interest,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Some description about the $interest.',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
