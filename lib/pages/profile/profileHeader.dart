import 'package:flutter/material.dart';

class ProfileHeader extends StatefulWidget {
  final String fname;
  final String lname;
  final String email;

  const ProfileHeader({
    super.key,
    required this.fname,
    required this.lname,
    required this.email,
  });

  @override
  State<ProfileHeader> createState() {
    return ProfileHeaderState();
  }
}

class ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Icon (Profile Picture)
            CircleAvatar(
              radius: 45, // Increased size for a more prominent appearance
              backgroundColor:
                  Colors.blueAccent, // Background color of the icon
              child: Icon(
                Icons.person, // Default user icon
                size: 60,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 18), // Increased space between the icon and text

            // Full Name (fname + lname)
            Text(
              '${widget.fname} ${widget.lname}',
              style: TextStyle(
                fontSize: 26, // Larger font for name
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                letterSpacing:
                    1.2, // Slight spacing between letters for elegance
              ),
            ),
            SizedBox(
                height: 6), // Slightly smaller space between name and email

            // Email
            Text(
              widget.email,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500, // Semi-bold for emphasis
              ),
            ),
          ],
        ),
      ),
    );
  }
}
