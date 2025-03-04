import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/utils/theme_notifier.dart';

class NewsBody extends StatelessWidget {
  const NewsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCommunityDrivesButton(context),
            _buildFeaturedEvent(context, isDarkMode),
            _buildEventList(context, isDarkMode),
          ],
        ),
      ),
    );
  }

  Widget _buildCommunityDrivesButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Text(
            'Community Drives',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: colorScheme.onSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedEvent(BuildContext context, bool isDarkMode) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Image.asset(
              'assets/mosqguard/News1.png',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      colorScheme.surface.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Blood Donation - 12 February 2025',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Mr. Saman Perera - January 1, 2025',
                      style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList(BuildContext context, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(
          3,
              (index) => _buildEventCard(context, isDarkMode),
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, bool isDarkMode) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shramadhana Campaign - Jan 24',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Mr. Saman Perera - January 1, 2025',
                    style: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.6),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Read More',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child: Image.asset(
              'assets/mosqguard/News2.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}