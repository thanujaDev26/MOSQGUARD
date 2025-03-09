import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/utils/theme_notifier.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  bool _isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 600; // Tablet/desktop breakpoint
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderSection(context, isDarkMode),
              const SizedBox(height: 24),
              _buildPolicySection(
                context,
                icon: Icons.security_rounded,
                title: "Data Collection",
                content: "We collect only necessary information to provide and improve our services...",
                isDarkMode: isDarkMode,
              ),
              _buildPolicySection(
                context,
                icon: Icons.analytics_rounded,
                title: "Usage Data",
                content: "We automatically collect usage information when you use our app...",
                isDarkMode: isDarkMode,
              ),
              _buildPolicySection(
                context,
                icon: Icons.share_rounded,
                title: "Data Sharing",
                content: "We do not sell your personal data. We may share anonymized...",
                isDarkMode: isDarkMode,
              ),
              _buildPolicySection(
                context,
                icon: Icons.lock_rounded,
                title: "Security",
                content: "We implement industry-standard security measures to protect...",
                isDarkMode: isDarkMode,
              ),
              const SizedBox(height: 32),
              _buildContactSection(context, isDarkMode),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, bool isDarkMode) {
    return Card(
      elevation: 2,
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(Icons.privacy_tip_rounded,
                  size: 48, color: isDarkMode ? Colors.blue[200] : Colors.blue[700]),
              const SizedBox(height: 16),
              Text(
                'Your Privacy Matters',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Last Updated: January 1, 2024',
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPolicySection(BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
    required bool isDarkMode,
  }) {
    final bool isLargeScreen = _isLargeScreen(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(isLargeScreen ? 12 : 8),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.blue[800] : Colors.blue[50],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: isLargeScreen ? 36 : 32,
                      color: isDarkMode ? Colors.blue[200] : Colors.blue[700]),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isLargeScreen ? 22 : 18,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: isLargeScreen ? 16 : 12),
            Text(
              content,
              style: TextStyle(
                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                fontSize: isLargeScreen ? 16 : 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context, bool isDarkMode) {
    return Card(
      elevation: 2,
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Contact Us',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'For any questions about our privacy policy:',
              style: TextStyle(
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.email),
                  color: isDarkMode ? Colors.blue[200] : Colors.blue[700],
                  onPressed: () => _launchUrl('mailto:privacy@mosqguard.com'),
                ),
                IconButton(
                  icon: const Icon(Icons.language),
                  color: isDarkMode ? Colors.blue[200] : Colors.blue[700],
                  onPressed: () => _launchUrl('https://mosqguard.com/privacy'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}