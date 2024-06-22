import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  Future<void> _launchEmail(String email) async {
    if (!await launchUrl(Uri(scheme: 'mailto'))) {
      Get.snackbar(
        'Error',
        'Could not send email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    try {
      await launchUrl(launchUri);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not make phone call',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      path: url,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we help you?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "Don't hesitate to contact us whether you have a suggestion on our improvement, a complain to discuss or an issue to solve.",
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildContactOption(
                  icon: Icons.phone,
                  title: 'Call us',
                  subtitle: 'Our team is on the line\nMon-Fri • 9-17',
                  color: Colors.red,
                ),
                _buildContactOption(
                  icon: Icons.email,
                  title: 'Email us',
                  subtitle: 'Our team is online\nMon-Fri • 9-17',
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Contact us in Social Media',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialIcon('instagram'),
                _buildSocialIcon('telegram'),
                _buildSocialIcon('facebook'),
                _buildSocialIcon('whatsapp'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: GestureDetector(
              onTap: () {
                switch (icon) {
                  case Icons.phone:
                    _makePhoneCall('+1234567890');
                    break;
                  case Icons.email:
                    _launchEmail('hello@venturelead.com.np');
                    break;
                }
              },
              child: Icon(icon, color: Colors.white, size: 25)),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String assetName) {
    return GestureDetector(
      onTap: () {
        switch (assetName) {
          case 'instagram':
            _launchUrl('https://instagram.com');
            break;
          case 'telegram':
            _launchUrl('https://telegram.com');
            break;
          case 'facebook':
            _launchUrl('https://facebook.com');
            break;
          case 'whatsapp':
            _launchUrl('https://whatsapp.com');
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const FaIcon(FontAwesomeIcons.twitter, color: Colors.red),
      ),
    );
  }
}
