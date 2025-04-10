import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mosqguard/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App Logo with Hero Animation
              Hero(
                tag: 'app_logo',
                child: Image.asset(
                  'assets/icons/App_Icon.png',
                  height: 120,
                ),
              ),
              const SizedBox(height: 16),

              // App Name
              _buildAppTitle(context, isDarkMode),

              const SizedBox(height: 8),

              // App Tagline
              Text(
                'Smart Mosquito Monitoring & Control System',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: isDarkMode ? Colors.grey[200] : Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),

              // Mission Section
              _buildCardSection(
                context,
                title: 'Our Mission',
                icon: Icons.shield_outlined,
                content:
                'Our mission is to use advanced technology to prevent and control dengue fever, creating healthier communities through real-time surveillance, predictive analytics, and community engagement.',
              ),

              // Vision Section
              _buildCardSection(
                context,
                title: 'Our Vision',
                icon: Icons.visibility_outlined,
                content:
                'Our vision is a dengue-free world. We strive to achieve this through continuous innovation, collaboration with health organizations and governments, and community engagement in combating dengue.',
              ),

              // Services Section
              const SizedBox(height: 16),
              _buildSectionTitle(context, 'Our Services'),
              const SizedBox(height: 8),
              _buildServiceTile(context, Icons.videocam, 'Real-time Surveillance'),
              _buildServiceTile(context, Icons.insights, 'Predictive Analytics'),
              _buildServiceTile(context, Icons.people, 'Community Engagement'),
              _buildServiceTile(context, Icons.web, 'Web Application'),
            ],
          ),
        ),
      ),
    );
  }

  // App Title with Highlighted 'Q'
  Widget _buildAppTitle(BuildContext context, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'MOS',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
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
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(BuildContext context, String title) {
    final isDarkMode = Provider.of<ThemeNotifier>(context, listen: false).themeMode == ThemeMode.dark;
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? Colors.white : Colors.black,
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
                Icon(icon, color: Color(0xFF004DB9), size: 28),
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

  // Service Tile Widget
  Widget _buildServiceTile(BuildContext context, IconData icon, String title) {
    final isDarkMode = Provider.of<ThemeNotifier>(context, listen: false).themeMode == ThemeMode.dark;
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isDarkMode ? Colors.black : Colors.white,
      shadowColor: Colors.black26,
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF004DB9), size: 32),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
