import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Logo
            Hero(
              tag: 'app_logo',
              child: Image.asset(
                'assets/icons/App_Icon.png',
                height: 120,
              ),
            ),
            const SizedBox(height: 16),

            // App Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MOS',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Q',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'GUARD',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // App Tagline
            Text(
              'Smart Mosquito Monitoring & Control System',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),

            // Mission Section
            _buildCardSection(
              title: 'Our Mission',
              icon: Icons.shield_outlined,
              content:
              'To safeguard communities from mosquito-borne diseases through real-time '
                  'monitoring and data-driven prevention strategies, creating a healthier and safer environment.',
            ),

            // Vision Section
            _buildCardSection(
              title: 'Our Vision',
              icon: Icons.visibility_outlined,
              content:
              'To be the leading technological solution for mosquito control, leveraging smart devices and AI '
                  'to predict and prevent outbreaks before they happen.',
            ),

            // Services Section
            const SizedBox(height: 16),
            _buildSectionTitle('Our Services'),
            const SizedBox(height: 8),
            _buildServiceTile(
              Icons.bug_report,
              'Real-Time Mosquito Detection',
              'Advanced sensors monitor mosquito activity and provide real-time alerts for high-risk areas.',
            ),
            _buildServiceTile(
              Icons.map,
              'Risk Zone Mapping',
              'Heatmaps visualize mosquito-prone areas, helping communities take preventive action.',
            ),
            _buildServiceTile(
              Icons.notifications_active,
              'Smart Notifications & Alerts',
              'Get instant notifications about mosquito density changes and suggested countermeasures.',
            ),
            _buildServiceTile(
              Icons.analytics,
              'Data-Driven Insights',
              'AI-powered analytics provide trends and forecasts, enabling long-term disease prevention strategies.',
            ),
            const SizedBox(height: 20),

            // Contact Us Section
            _buildCardSection(
              title: 'Contact Us',
              icon: Icons.contact_mail_outlined,
              content: '',
              child: Column(
                children: [
                  _buildContactButton(Icons.email, 'support@mosqguard.com',
                      'mailto:support@mosqguard.com'),
                  _buildContactButton(Icons.language, 'www.mosqguard.com',
                      'https://www.mosqguard.com'),
                  _buildContactButton(Icons.phone, '+123 456 7890',
                      'tel:+1234567890'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for section title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // Widget for sections with cards
  Widget _buildCardSection({
    required String title,
    required IconData icon,
    required String content,
    Widget? child,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
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
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (content.isNotEmpty)
              Text(
                content,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
            if (child != null) child,
          ],
        ),
      ),
    );
  }

  // Widget for service items
  Widget _buildServiceTile(IconData icon, String title, String description) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      shadowColor: Colors.black26,
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent, size: 32),
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
    );
  }

  // Contact Buttons
  Widget _buildContactButton(IconData icon, String text, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16), // Added horizontal margin
      child: SizedBox(
        width: double.infinity, // Expands within the padded area
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
          icon: Icon(icon, color: Colors.white),
          label: Text(text, style: const TextStyle(color: Colors.white)),
          onPressed: () => launchUrl(Uri.parse(url)),
        ),
      ),
    );
  }
}
