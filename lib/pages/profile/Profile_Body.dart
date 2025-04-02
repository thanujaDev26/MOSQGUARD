import 'package:flutter/material.dart';
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
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "John Doe",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "john.doe@example.com",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
      
              Text(
                "Edit Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
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
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/sri-lanka.png',
                          width: 40,
                          height: 50,
                        ),
                        const SizedBox(width: 1.0),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(child: buildTextField("Phone Number", "0764567891", Icons.phone)),
                ],
              ),
              SizedBox(height: 20),
      
              Text(
                "Choose Language",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Wrap(
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
                    selectedColor: Colors.teal, // Highlight selected language
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
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text("SAVE", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
