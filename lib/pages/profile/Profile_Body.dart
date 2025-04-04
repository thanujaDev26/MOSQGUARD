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
                SizedBox(height: 20),
                Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                ),
                SizedBox(height: 10),
                buildTextField("First Name", firstName, Icons.person),
                SizedBox(height: 10),
                buildTextField("Last Name", lastName, Icons.person),
                SizedBox(height: 10),
                buildTextField("Phone Number", phoneNumber, Icons.phone),
                SizedBox(height: 20),
                Text(
                  "Choose Language",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.white : Colors.black),
                ),
                Center(
                  child: Wrap(
                    spacing: 15.0,
                    children: ["English", "සිංහල", "தமிழ்"].map((language) {
                      return ChoiceChip(
                        label: Text(language),
                        selected: selectedLanguage == language,
                        onSelected: (selected) {
                          setState(() {
                            selectedLanguage = language;
                          });
                        },
                        selectedColor: isDarkMode ? Colors.black : Colors.white,
                        labelStyle: TextStyle(
                          color: selectedLanguage == language
                              ? (isDarkMode ? Colors.white : Colors.black)
                              : (isDarkMode ? Colors.white70 : Colors.black54),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.white : Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: isDarkMode ? Colors.black : Colors.white, width: 1),
                    ),
                    child: Text("SAVE", style: TextStyle(fontSize: 16, color: isDarkMode ? Colors.black : Colors.white)),
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
        prefixIcon: Icon(icon, color: isDarkMode ? Colors.white : Colors.black),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
