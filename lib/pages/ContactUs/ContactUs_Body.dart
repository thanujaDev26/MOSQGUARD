import 'package:flutter/material.dart';

class ContactUsBody extends StatelessWidget {
  const ContactUsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // Contact Information
          const Text(
            "Get in Touch",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.email, color: Colors.blue),
              SizedBox(width: 10),
              Text("support@example.com"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.phone, color: Colors.blue),
              SizedBox(width: 10),
              Text("+123 456 7890"),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
