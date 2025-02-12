import 'package:flutter/material.dart';

class ContactUsForm extends StatefulWidget {
  const ContactUsForm({super.key});

  @override
  _ContactUsFormState createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission logic (e.g., send data to backend)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: _nameController,
              label: "Your Name",
              hintText: "Enter your name",
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _subjectController,
              label: "Subject",
              hintText: "Enter the subject",
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _messageController,
              label: "Message",
              hintText: "Enter your message",
              maxLines: 5,
            ),
            const SizedBox(height: 16),

            // Image Upload Button
            ElevatedButton.icon(
              onPressed: () {
                // Implement image selection logic
              },
              icon: const Icon(Icons.image),
              label: const Text("Attach Image"),
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "$label cannot be empty";
            }
            return null;
          },
        ),
      ],
    );
  }
}
