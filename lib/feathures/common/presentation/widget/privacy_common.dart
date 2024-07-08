import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      setState(() {
        _isAtBottom = _scrollController.position.pixels != 0;
      });
    } else {
      setState(() {
        _isAtBottom = false;
      });
    }
  }

  void _scrollToPosition() {
    if (_isAtBottom) {
      _scrollController.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'AGREEMENT',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              const Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Last updated on 6/17/2024',
                style: TextStyle(color: Colors.grey),
              ),
              const Divider(height: 24, color: Colors.grey),
              buildClause('Clause 1', _generateRandomText()),
              buildClause('Clause 2', _generateRandomText()),
              buildClause('Clause 3', _generateRandomText()),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButton: RawMaterialButton(
        onPressed: _scrollToPosition,
        fillColor: const Color.fromARGB(255, 216, 106, 98),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16.0),
        child: Icon(
          _isAtBottom ? Icons.arrow_upward : Icons.arrow_downward,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildClause(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(content),
        ],
      ),
    );
  }

  String _generateRandomText() {
    return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Vivamus lacinia odio vitae vestibulum vestibulum. Cras venenatis euismod malesuada. '
        'Nullam ac erat ante. Pellentesque maximus justo vel consectetur lacinia. '
        'Donec vehicula leo sit amet dui luctus, at ultrices risus ullamcorper. '
        'Curabitur lobortis, arcu ac suscipit gravida, libero magna placerat erat, id vestibulum erat arcu ac justo. '
        'Fusce vehicula justo vitae fermentum vestibulum. Aenean in turpis in dui vehicula dictum vel at turpis. '
        'Nam dapibus aliquet turpis, non vehicula turpis tincidunt in. '
        'In hac habitasse platea dictumst. Duis tincidunt, metus ac malesuada feugiat, mi nibh dignissim augue, ut consectetur metus tortor a lectus.';
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
