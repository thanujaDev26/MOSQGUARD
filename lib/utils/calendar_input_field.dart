import 'package:flutter/material.dart';

class CalendarInputField extends StatefulWidget {
  final Color inputFieldColor;
  final Color textColor;
  final Color borderColor;
  final Function(String) onDateSelected; // Callback function

  CalendarInputField({
    required this.inputFieldColor,
    required this.textColor,
    required this.borderColor,
    required this.onDateSelected, // Accept the callback
  });

  @override
  _CalendarInputFieldState createState() => _CalendarInputFieldState();
}

class _CalendarInputFieldState extends State<CalendarInputField> {
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2101);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      String formattedDate = "${pickedDate.toLocal()}".split(' ')[0];
      setState(() {
        _dateController.text = formattedDate;
      });
      widget.onDateSelected(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _dateController,
      onTap: () => _selectDate(context),
      readOnly: true,
      decoration: InputDecoration(
        labelText: "DATE",
        labelStyle: TextStyle(color: widget.textColor),
        fillColor: widget.inputFieldColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: widget.borderColor),
        ),
      ),
    );
  }
}

