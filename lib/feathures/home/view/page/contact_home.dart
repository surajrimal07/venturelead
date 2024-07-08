import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  Future<void> _launchEmail(String email) async {
    if (!await launchUrl(Uri(scheme: 'mailto', path: email))) {
      Get.snackbar(
        'Error',
        'Could not open email',
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
    final Uri launchUri = Uri.parse(url);
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              SizedBox(
                height: 200,
                child: FlutterMap(
                  options: const MapOptions(
                    initialCenter: LatLng(27.7172453, 85.3239605),
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    const MarkerLayer(markers: [
                      Marker(
                        point: LatLng(27.7172453, 85.3239605),
                        width: 64,
                        height: 64,
                        alignment: Alignment.centerLeft,
                        child: ColoredBox(
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('Here -->',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Our office is located in Kathmandu, Nepal',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  _buildSocialIcon(FontAwesomeIcons.instagram,
                      'https://www.instagram.com/venturelead/'),
                  _buildSocialIcon(
                      FontAwesomeIcons.telegram, 'https://t.me/venturelead'),
                  _buildSocialIcon(FontAwesomeIcons.facebook,
                      'https://www.facebook.com/venturelead/'),
                  _buildSocialIcon(
                      FontAwesomeIcons.whatsapp, 'https://wa.me/1234567890'),
                  _buildSocialIcon(FontAwesomeIcons.twitter,
                      'https://twitter.com/venturelead/')
                ],
              ),
            ],
          ),
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

  Widget _buildSocialIcon(IconData assetName, String url) {
    return GestureDetector(
      onTap: () {
        _launchUrl(url);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(12),
        ),
        child: FaIcon(assetName, color: Colors.red),
      ),
    );
  }
}
