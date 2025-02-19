import 'package:flutter/material.dart';

class CalendarInputField extends StatefulWidget {
  final Color inputFieldColor;
  final Color textColor;
  final Color borderColor;

  CalendarInputField({required this.inputFieldColor, required this.textColor, required this.borderColor});

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
    if (pickedDate != null && pickedDate != initialDate) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _dateController,
      onTap: () => _selectDate(context),
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
