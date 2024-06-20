import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompanyDetails extends StatelessWidget {
  const CompanyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text('Karkhana', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.handyman,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Design learning experience',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                'Karkhana',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Karkhana is a social enterprise dedicated to designing hands-on learning experiences for students inside regular classrooms. Karkhana aim to foster a culture of experimentation.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              const Wrap(
                spacing: 8,
                children: [
                  Chip(label: Text('Education')),
                  Chip(label: Text('Manufacturing')),
                  Chip(label: Text('STEM')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: const FaIcon(FontAwesomeIcons.linkedin),
                      onPressed: () {}),
                  IconButton(
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      onPressed: () {}),
                  IconButton(
                      icon: const FaIcon(FontAwesomeIcons.twitter),
                      onPressed: () {}),
                  IconButton(
                      icon: const FaIcon(FontAwesomeIcons.googlePlay),
                      onPressed: () {}),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.red),
                ),
                onPressed: () {},
                child: const Text('CONNECT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
