import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ReportingScreen extends StatefulWidget {
  const ReportingScreen({super.key});

  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ReportingScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedLanguage = "English";
  List<File> _selectedImages = [];
  DateTime? _selectedDate;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController();

  Future<void> _pickImages() async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  Future<void> _captureImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _clearForm() {
    setState(() {
      _selectedImages.clear();
      _selectedDate = null;
      _firstNameController.clear();
      _lastNameController.clear();
      _nicController.clear();
      _mobileController.clear();
      _locationController.clear();
      _complaintController.clear();
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse("http://172.20.10.2:3000/api/complain");
      List<String> base64Images = _selectedImages.map((image) {
        List<int> imageBytes = image.readAsBytesSync();
        return base64Encode(imageBytes);
      }).toList();

      final Map<String, dynamic> complaintData = {
        "fName": _firstNameController.text,
        "lName": _lastNameController.text,
        "NIC": _nicController.text,
        "mobileNumber": _mobileController.text,
        "location": _locationController.text,
        "type": selectedLanguage,
        "complain": _complaintController.text,
        "images": base64Images,
      };

      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: json.encode(complaintData),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Complaint Submitted Successfully!")),
          );
          _clearForm();
        } else {
          print("Failed: ${response.body}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${response.statusCode}")),
          );
        }
      } catch (e) {
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong: $e")),
        );
      }
    }
  }


  Color getPrimaryButtonColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xff002353);

  Color getPrimaryTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? const Color(0xff002353) : Colors.white;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fieldWidth = screenWidth > 600 ? (screenWidth / 2) - 30 : screenWidth - 32;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Complaint Form"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Select Language",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10.0,
                      children: ["English", "සිංහල", "தமிழ்"].map((language) {
                        return ChoiceChip(
                          label: Text(
                            language,
                            style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          selected: selectedLanguage == language,
                          onSelected: (selected) {
                            setState(() {
                              selectedLanguage = language;
                            });
                          },
                          selectedColor: Theme.of(context).brightness == Brightness.dark
                              ? Color(0xff002353)
                              : Color(0xff004a99),
                          backgroundColor: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[800]!
                              : Colors.grey[300]!,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          onPressed: _pickImages,
                          icon: const Icon(Icons.image),
                          label: const Text("Upload Images"),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton.icon(
                          onPressed: _captureImage,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text("Take Photo"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (_selectedImages.isNotEmpty)
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _selectedImages[index],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: const Icon(Icons.cancel, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        _selectedImages.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 15,
                      runSpacing: 15,
                      alignment: WrapAlignment.center,
                      children: [
                        SizedBox(
                          width: fieldWidth,
                          child: _buildTextField(_firstNameController, "First Name"),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: _buildTextField(_lastNameController, "Last Name"),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: _buildTextField(_nicController, "NIC/Passport"),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: _buildTextField(_mobileController, "Mobile No", keyboardType: TextInputType.phone),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: _buildTextField(_locationController, "Location"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(_complaintController, "About the Complaint", maxLines: 3),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: _clearForm,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            side: BorderSide(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          child: const Text("Clear"),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: getPrimaryButtonColor(context),
                            foregroundColor: getPrimaryTextColor(context),
                          ),
                          child: const Text("Submit"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) => value!.isEmpty ? "Enter $label" : null,
    );
  }
}
