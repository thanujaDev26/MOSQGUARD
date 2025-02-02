import 'package:flutter/material.dart';

class EditableField extends StatefulWidget {
  final String initialValue;
  final String labelText;
  final TextInputType inputType;
  final Function(String) onSaved;

  const EditableField({
    super.key,
    required this.initialValue,
    required this.labelText,
    required this.inputType,
    required this.onSaved,
  });

  @override
  _EditableFieldState createState() => _EditableFieldState();
}

class _EditableFieldState extends State<EditableField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the initial value
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: _controller,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          labelText: widget.labelText,
          border: const UnderlineInputBorder(),
        ),
        onSaved: (newValue) => widget.onSaved(newValue ?? ""),
      ),
    );
  }
}
