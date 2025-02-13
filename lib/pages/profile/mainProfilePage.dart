import 'package:flutter/material.dart';
import 'profilepage.dart'; // Import your ProfilePage here

class MainProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //we need to get this data from database
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(
        firstName: 'John',
        lastName: 'Doe',
        mobileNumber: '0764567891',
        language: 'English',
        email: 'john.doe@example.com',
      ),
    );
  }
}
