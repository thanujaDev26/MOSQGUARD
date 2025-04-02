import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:mosqguard/utils/calendar_input_field.dart';
import 'package:mosqguard/utils/dotted_border_painter.dart';
import 'package:mosqguard/utils/theme_notifier.dart';

class ReportingScreen extends StatefulWidget {
  @override
  _ReportingScreenState createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
  List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  String selectedLanguage = "English";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    nameController.dispose();
    nicController.dispose();
    mobileController.dispose();
    locationController.dispose();
    aboutController.dispose();
    super.dispose();
  }

  Future<void> showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(15),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take a photo"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Choose from gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void onCancel() {
      setState(() {
        selectedDate = null;
        nameController.clear();
        nicController.clear();
        mobileController.clear();
        locationController.clear();
        aboutController.clear();
        _images.clear();
      });
    }

    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final inputFieldColor = (isDarkMode ? Colors.grey[900] : Colors.white) ?? Colors.grey;
    final borderColor = isDarkMode ? Colors.white54 : Colors.black54;
    final cameraIconColor = isDarkMode ? Colors.white : Colors.black;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reporting Section',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Wrap(
                    spacing: 10.0,
                    children: ["English", "සිංහල", "தமிழ்"].map((language) {
                      return ChoiceChip(
                        label: SizedBox(
                          width: 50,
                          child: Center(child: Text(language)),
                        ),
                        selected: selectedLanguage == language,
                        onSelected: (selected) {
                          setState(() {
                            selectedLanguage = language;
                          });
                        },
                        selectedColor: Colors.black,
                        labelStyle: TextStyle(
                          color: selectedLanguage == language ? Colors.white : isDarkMode ? Colors.white : Colors.black,
                        ),
                        labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ..._images.map(
                              (image) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.file(image, width: 80, height: 80, fit: BoxFit.cover),
                          ),
                        ),
                        GestureDetector(
                          onTap: showImageSourceDialog,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.3),
                            ),
                            child: CustomPaint(
                              painter: DottedBorderPainter(color: borderColor, strokeWidth: 1.0),
                              child: Icon(Icons.camera_alt, color: cameraIconColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CalendarInputField(
                          inputFieldColor: inputFieldColor,
                          textColor: textColor,
                          borderColor: borderColor,
                          onDateSelected: (date) {
                            setState(() {
                              selectedDate = DateTime.tryParse(date) ?? selectedDate;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        _buildTextField("NAME", nameController, inputFieldColor, textColor, borderColor),
                        SizedBox(height: 10),
                        _buildTextField("NIC", nicController, inputFieldColor, textColor, borderColor),
                        SizedBox(height: 10),
                        _buildTextField("MOBILE NO.", mobileController, inputFieldColor, textColor, borderColor),
                        SizedBox(height: 10),
                        _buildTextField("LOCATION", locationController, inputFieldColor, textColor, borderColor),
                        SizedBox(height: 10),
                        _buildTextField(
                          "ABOUT COMPLAIN",
                          aboutController,
                          inputFieldColor,
                          textColor,
                          borderColor,
                          maxLines: 3,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),

                  // Buttons Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.transparent, // No background, purely text
                          side: BorderSide(color: Colors.blue.shade400, width: 1.5), // Blue border
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.blue.shade400, // Text color matches the border
                          ),
                        ),
                        onPressed: (){

                        },
                        child: Row(
                          children: [
                            Icon(Icons.close, color: Colors.blue.shade400),
                            SizedBox(width: 8),
                            Text('Clear'),
                          ],
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                          ),
                          backgroundColor: Colors.blue.shade600,
                          elevation: 2,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white
                          ),
                        ),
                        onPressed: () {
                          print("Name: ${nameController.text}");
                          print("NIC: ${nicController.text}");
                          print("Mobile: ${mobileController.text}");
                          print("Location: ${locationController.text}");
                          print("About: ${aboutController.text}");
                          print("Selected Date: ${selectedDate != null ? selectedDate.toString() : 'No date selected'}");
                        },
                        child: Row(
                          children: [
                            Text('Submit'),
                            SizedBox(width: 8),
                            Transform.rotate(
                              angle: 45 * (-3.141592653589793 / 180),
                              child: Icon(Icons.send, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String hintText,
      TextEditingController controller,
      Color fillColor,
      Color textColor,
      Color borderColor, {
        int maxLines = 1,
      }) {
    return TextField(
      controller: controller,
      style: TextStyle(color: textColor),
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        hintText: hintText,
        hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: borderColor, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}
