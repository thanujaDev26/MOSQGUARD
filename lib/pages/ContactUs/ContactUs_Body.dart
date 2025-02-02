import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mosqguard/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              children: [
                const SizedBox(height: 20),
                // Contact Us Section
                _buildCardSection(
                  context,
                  title: 'Contact Us',
                  icon: Icons.contact_mail_outlined,
                  content: '',
                  child: Column(
                    children: [
                      _buildContactButton(Icons.email, 'support@mosqguard.com', 'mailto:support@mosqguard.com'),
                      _buildContactButton(Icons.language, 'www.mosqguard.com', 'https://www.mosqguard.com'),
                      _buildContactButton(Icons.phone, '+123 456 7890', 'tel:+1234567890'),
                    ],
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }

  // Card Section Widget
  Widget _buildCardSection(BuildContext context, {required String title, required IconData icon, required String content, Widget? child}) {
    final isDarkMode = Provider.of<ThemeNotifier>(context, listen: false).themeMode == ThemeMode.dark;
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDarkMode ? Colors.black : Colors.white,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent, size: 28),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (content.isNotEmpty)
              Text(
                content,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.grey[200] : Colors.grey[800]),
              ),
            if (child != null) child,
          ],
        ),
      ),
    );
  }

  // Contact Button Widget
  Widget _buildContactButton(IconData icon, String text, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
          icon: Icon(icon, color: Colors.white),
          label: SelectableText(text, style: const TextStyle(color: Colors.white)), // Allows copy-pasting
          onPressed: () => _launchURL(url),
        ),
      ),
    );
  }

  // URL Launcher Function
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}
