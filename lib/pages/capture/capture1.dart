import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Capture extends StatefulWidget {
  const Capture({super.key});

  @override
  _CaptureState createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  File? _capturedImage;
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _capturedImage = File(pickedFile.path);
      });
    } else {
      print("No image captured.");
    }
  }

  Future<void> _sendImageToServer() async {
    if (_capturedImage != null) {
      final caption = _captionController.text.trim();
      final location = _locationController.text.trim();
      final notes = _notesController.text.trim();

      print("Sending image to server: ${_capturedImage!.path}");
      print("Caption: $caption");
      print("Location: $location");
      print("Notes: $notes");

      // Clear fields after sending
      setState(() {
        _capturedImage = null;
        _captionController.clear();
        _locationController.clear();
        _notesController.clear();
      });
    } else {
      print("No image to send.");
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Capture Image",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xff002353),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _capturedImage != null
                  ? Column(
                children: [
                  Image.file(
                    _capturedImage!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(_captionController, "Enter Your Name..."),
                  _buildTextField(_locationController, "Enter Address..."),
                  _buildTextField(_notesController, "Enter notes (if any)..."),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 85),
                    child: ElevatedButton(
                      onPressed: _sendImageToServer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff002353),
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Ensures the Row takes up minimal width
                          mainAxisAlignment: MainAxisAlignment.center, // Centers the Row content
                          children: [
                            Text(
                              "Submit",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(width: 8), // Add spacing between text and icon
                            Transform.rotate(
                              angle: -0.785398, // Rotate the icon
                              child: GestureDetector(
                                onTap: () =>{
                                  print("Submitted"),
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : const Text(
                "No image captured",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              if (_capturedImage == null)
                ElevatedButton(
                  onPressed: _openCamera,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff002353),
                    padding: const EdgeInsets.all(15),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
