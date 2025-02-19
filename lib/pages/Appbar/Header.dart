import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/utils/theme_notifier.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return AppBar(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      titleTextStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          // Main row for the title, menu, and actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left section: Menu icon and title
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: isDarkMode ? Colors.white : Colors.black),
                    onPressed: () {
                      // Open the end drawer (ensuring the scaffold context is found properly)
                      Scaffold.maybeOf(context)?.openDrawer();
                    },
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      text: 'MOS',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                          text: 'Q',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: 'GUARD',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Right section: News icon
              IconButton(
                icon: Icon(Icons.article, color: isDarkMode ? Colors.white : Colors.black),
                onPressed: () {
                  // Action for news button
                  debugPrint('News button clicked');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
