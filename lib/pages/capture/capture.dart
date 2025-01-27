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
      print("Sending image to server: ${_capturedImage!.path}");
      print("Caption: $caption");
      // Clear the image and caption after sending
      setState(() {
        _capturedImage = null;
        _captionController.clear();
      });
    } else {
      print("No image to send.");
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
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
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _captionController,
                            decoration: InputDecoration(
                              hintText: "Enter a caption...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _sendImageToServer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff002353),
                            padding: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Transform.rotate(
                            angle: -0.785398,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  : const Text(
                "No image captured",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              if (_capturedImage == null)
                ElevatedButton(
                  onPressed: _openCamera,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff002353),
                    padding: const EdgeInsets.all(15),
                    shape: const CircleBorder(),
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
      ),
    );
  }
}
