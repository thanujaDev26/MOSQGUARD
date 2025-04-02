import 'package:flutter/material.dart';
import 'package:mosqguard/auth/auth.dart';
import 'package:mosqguard/pages/login/login.dart';
import 'package:mosqguard/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  void _signOut(BuildContext context) async {
    AuthService().signOut();

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;
    final user = AuthService().getCurrentUser();
    final String userName = user?.displayName ?? "Guest";
    final String? userImageUrl = user?.photoURL;

    return Drawer(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      child: Padding(
        padding: EdgeInsets.all(10.0),
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
                    backgroundImage: userImageUrl != null && userImageUrl.isNotEmpty
                        ? NetworkImage(userImageUrl)
                        : AssetImage('assets/icons/default_image_url.png') as ImageProvider,
                    child: userImageUrl == null || userImageUrl.isEmpty
                        ? const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    )
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.white : Colors.black,
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
                    title: Text(
                      'About Us',
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/aboutus');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.security, color: isDarkMode ? Colors.white : Colors.black),
                    title: Text(
                      'Privacy and Policy',
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/privacyandpolicy');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.green),
                    title: Text(
                      'Contact Us',
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/contactus');
                    },
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
                    title: Text(
                      'Help',
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    onTap: () {},
                  ),
                  SwitchListTile(
                    value: isDarkMode,
                    activeColor: isDarkMode ? Colors.white : Colors.black, // Change thumb color
                    inactiveThumbColor: Colors.grey,
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    secondary: Icon(
                      Icons.dark_mode,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onChanged: (bool value) {
                      themeNotifier.toggleTheme(value);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.orange),
                    title: Text(
                      'Log Out',
                      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                    ),
                    onTap: () => _signOut(context),
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

