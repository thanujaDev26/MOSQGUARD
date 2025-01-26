import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile section
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey[200],
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150', // Replace with user profile image URL
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'UOR Group 13',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          // Options
          ListTile(
            leading: const Icon(Icons.lightbulb_outline, color: Colors.yellow),
            title: const Text('About Us'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: Colors.black),
            title: const Text('Privacy and Policy'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.green),
            title: const Text('Contact Us'),
            onTap: () {},
          ),
          const Spacer(),
          // Additional options at the bottom
          ListTile(
            leading: const Icon(Icons.help, color: Colors.blue),
            title: const Text('Help'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode, color: Colors.black),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: false,
              onChanged: (bool value) {
                // Handle dark mode toggle
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.orange),
            title: const Text('Log Out'),
            onTap: () {
              // Handle log out action
            },
          ),
        ],
      ),
    );
  }
}
