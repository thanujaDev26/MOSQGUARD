import 'package:flutter/material.dart';
import 'package:mosqguard/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Thanuja Priyadarshane',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Main Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.lightbulb, color: Colors.amber),
                    title: const Text('About Us'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.security, color: Colors.black),
                    title: const Text('Privacy and Policy'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.green),
                    title: const Text('Contact Us'),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Bottom Menu Items
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.help, color: Colors.blue),
                    title: const Text('Help'),
                    onTap: () {},
                  ),
                  SwitchListTile(
                    value: isDarkMode,
                    activeColor: Colors.black,
                    inactiveThumbColor: Colors.grey,
                    title: const Text('Dark Mode'),
                    secondary: const Icon(Icons.dark_mode, color: Colors.black),
                    onChanged: (bool value) {
                      themeNotifier.toggleTheme(value);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.orange),
                    title: const Text('Log Out'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
