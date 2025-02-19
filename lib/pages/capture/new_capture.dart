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
    void onCancle (){
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "REPORTING",
                        style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'MOS',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(
                              text: 'Q',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: 'GUARD',
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),


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
                  SizedBox(height: 40),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CalendarInputField(
                          inputFieldColor: inputFieldColor,
                          textColor: textColor,
                          borderColor: borderColor,
                          onDateSelected: (date){
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Color(0xffB01D00),
                        ),
                        onPressed: onCancle,
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Color(0xff004DB9),
                        ),
                        onPressed: () {
                          print("Name: ${nameController.text}");
                          print("NIC: ${nicController.text}");
                          print("Mobile: ${mobileController.text}");
                          print("Location: ${locationController.text}");
                          print("About: ${aboutController.text}");
                          print("Selected Date: ${selectedDate != null ? selectedDate.toString() : 'No date selected'}");
                        },
                        child: Transform.rotate(
                          angle: 45 * (-3.141592653589793 / 180),
                          child: Icon(Icons.send, color: Colors.white),
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
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}

