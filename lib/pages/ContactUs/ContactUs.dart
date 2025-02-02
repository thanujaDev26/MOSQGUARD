import 'package:flutter/material.dart';

import 'ContactUs_Body.dart';

class Contactus extends StatelessWidget {
  const Contactus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ContactUsPage(),
    );
  }
}
