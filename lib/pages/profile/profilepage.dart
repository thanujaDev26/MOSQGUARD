import 'package:flutter/material.dart';
import 'profileHeader.dart'; // Import ProfileHeader

class ProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String language;
  final String email;

  const ProfilePage(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.language,
      required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _fnameController;
  late TextEditingController _lnameController;
  late TextEditingController _mobileController;
  String _selectedLanguage = 'English';
  late String Email;

  @override
  void initState() {
    super.initState();
    _fnameController = TextEditingController(text: widget.firstName);
    _lnameController = TextEditingController(text: widget.lastName);
    _mobileController = TextEditingController(text: widget.mobileNumber);
    _selectedLanguage = widget.language;
    Email = widget.email;
  }

  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    setState(() {
      print("Updated First Name: ${_fnameController.text}");
      print("Updated Last Name: ${_lnameController.text}");
      print("Updated Mobile Number: ${_mobileController.text}");
      print("Selected Language: $_selectedLanguage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title:
            const Text("Profile Page", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                fname: widget.firstName,
                lname: widget.lastName,
                email: Email, // Email not needed here
              ),
              const SizedBox(height: 24),
              const Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _fnameController,
                label: "First Name",
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _lnameController,
                label: "Last Name",
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              _buildMobileField(),
              const SizedBox(height: 24),
              const Text(
                "Choose Language",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              _buildLanguageOptions(),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                  ),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.teal, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  Widget _buildMobileField() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/icons/sri-lanka.png',
                width: 40,
                height: 30,
              ),
              const SizedBox(width: 5.0),
              const Icon(Icons.arrow_drop_down, color: Colors.teal),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: TextField(
            controller: _mobileController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Enter your mobile number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal),
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLanguageOption("English"),
        _buildLanguageOption("සිංහල"),
        _buildLanguageOption("தமிழ்"),
      ],
    );
  }

  Widget _buildLanguageOption(String language) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
      },
      child: Row(
        children: [
          Radio<String>(
            value: language,
            groupValue: _selectedLanguage,
            activeColor: Colors.teal,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
          Text(
            language,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
