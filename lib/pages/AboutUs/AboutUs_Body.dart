import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/utils/theme_notifier.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAppHeader(context, isDarkMode),
                  const SizedBox(height: 32),
                  _buildMissionVisionSection(context, isDarkMode),
                  const SizedBox(height: 24),
                  _buildServicesSection(context, isDarkMode),
                  const SizedBox(height: 32),
                  _buildFooterSection(context, isDarkMode),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppHeader(BuildContext context, bool isDarkMode) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Hero(
          tag: 'app_logo',
          child: Image.asset(
            'assets/icons/App_Icon.png',
            height: 120,
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'MOS',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              TextSpan(
                text: 'Q',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              TextSpan(
                text: 'GUARD',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Smart Mosquito Monitoring & Control System',
          textAlign: TextAlign.center,
          style: textTheme.titleMedium?.copyWith(
            color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildMissionVisionSection(BuildContext context, bool isDarkMode) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        return isWide
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildInfoCard(context, isDarkMode,
              icon: Icons.shield_outlined,
              title: 'Our Mission',
              content: 'Our mission is to use advanced technology to prevent and control dengue fever...',
            )),
            const SizedBox(width: 16),
            Expanded(child: _buildInfoCard(context, isDarkMode,
              icon: Icons.visibility_outlined,
              title: 'Our Vision',
              content: 'Our vision is a dengue-free world. We strive to achieve this through continuous innovation...',
            )),
          ],
        )
            : Column(
          children: [
            _buildInfoCard(context, isDarkMode,
              icon: Icons.shield_outlined,
              title: 'Our Mission',
              content: 'Our mission is to use advanced technology to prevent and control dengue fever...',
            ),
            const SizedBox(height: 16),
            _buildInfoCard(context, isDarkMode,
              icon: Icons.visibility_outlined,
              title: 'Our Vision',
              content: 'Our vision is a dengue-free world. We strive to achieve this through continuous innovation...',
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoCard(BuildContext context, bool isDarkMode, {
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      elevation: 2,
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.blue[800] : Colors.blue[50],
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: isDarkMode ? Colors.blue[200] : Colors.blue[700]),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context, bool isDarkMode) {
    return Column(
      children: [
        Text(
          'Our Services',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 24),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
          childAspectRatio: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _ServiceItem(Icons.videocam, 'Real-time Surveillance', isDarkMode),
            _ServiceItem(Icons.insights, 'Predictive Analytics', isDarkMode),
            _ServiceItem(Icons.people, 'Community Engagement', isDarkMode),
            _ServiceItem(Icons.web, 'Web Application', isDarkMode),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterSection(BuildContext context, bool isDarkMode) {
    return Column(
      children: [
        Text(
          '© 2024 MOSQGUARD. All rights reserved',
          style: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDarkMode;

  const _ServiceItem(this.icon, this.title, this.isDarkMode);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.blue[800] : Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: isDarkMode ? Colors.blue[200] : Colors.blue[700]),
        ),
        title: Text(title, style: TextStyle(
          fontWeight: FontWeight.w500,
          color: isDarkMode ? Colors.white : Colors.black,
        )),
        trailing: Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: isDarkMode ? Colors.blue[200] : Colors.blue[700]),
        onTap: () {},
      ),
    );
  }
}