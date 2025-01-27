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

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _capturedImage = File(pickedFile.path);
      });

      _sendImageToServer(File(pickedFile.path));
    } else {
      print("No image captured.");
    }
  }

  Future<void> _sendImageToServer(File image) async {
    print("Sending image to server: ${image.path}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Capture Image", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500
        ),),
        backgroundColor: Color(0xff002353),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _capturedImage != null
                ? Image.file(
              _capturedImage!,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            )
                : const Text(
              "No image captured",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _openCamera,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff002353),
                padding: EdgeInsets.all(15),
                shape: CircleBorder(),
              ),
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
