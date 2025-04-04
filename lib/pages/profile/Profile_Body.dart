import 'package:flutter/material.dart';
import 'package:mosqguard/auth/auth.dart';
import 'package:mosqguard/utils/theme_notifier.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    final user = AuthService().getCurrentUser();
    final String userName = user?.displayName ?? "";
    final String? userImageUrl = user?.photoURL;
    final String userEmail = user?.email ?? "";
    final String phoneNumber = user?.phoneNumber ?? "";
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;
    List<String> nameParts = userName.split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Add functionality for tap on profile image if needed
                        },
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: isDarkMode ? Colors.white : Colors.black,
                          backgroundImage: userImageUrl != null
                              ? NetworkImage(userImageUrl)
                              : null,
                          child: userImageUrl == null
                              ? Icon(Icons.person, size: 55, color: isDarkMode ? Colors.black : Colors.white)
                              : null,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        userName,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                      ),
                      Text(
                        userEmail,
                        style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                      ),
                    ],
                  ),
                ),

              ),
              SizedBox(height: 20),
      
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF004DB9)),
              ),
              SizedBox(height: 10),
      
              // First Name
              buildTextField("First Name", "John", Icons.person),
              SizedBox(height: 10),
      
              // Last Name
              buildTextField("Last Name", "Doe", Icons.person),
              SizedBox(height: 10),
      
              // Phone Number with Country Code
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF004DB9)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/sri-lanka.png',
                          width: 40,
                          height: 50,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20),
                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Save action here
                    },

                    selectedColor: Color(0xFF004DB9), // Highlight selected language
                    labelStyle: TextStyle(
                      color: selectedLanguage == language ? Colors.white : isDarkMode ? Colors.white : Colors.black,
                    ),
                  );
                }).toList(),
              ),
      
              SizedBox(height: 20),
      
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Save action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF004DB9),
                    padding: EdgeInsets.symmetric(vertical: 14),

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, IconData icon) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return TextField(
      controller: TextEditingController(text: hint),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Color(0xFF004DB9)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
