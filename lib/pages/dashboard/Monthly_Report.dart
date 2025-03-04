import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlyReportPage extends StatefulWidget {
  const MonthlyReportPage({super.key});

  @override
  State<MonthlyReportPage> createState() => _MonthlyReportPageState();
}

class _MonthlyReportPageState extends State<MonthlyReportPage> {
  final List<String> _districts = [
    'Colombo',
    'Gampaha',
    'Kalutara',
    'Kandy',
    'Matale',
    'Nuwara Eliya'
  ];
  String? _selectedDistrict;
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  final List<Map<String, dynamic>> _reportData = [
    {'category': 'Total Cases', 'count': 2450},
    {'category': 'Total Investigations', 'count': 1980},
    {'category': 'Recoveries', 'count': 2150},
    {'category': 'Deaths', 'count': 42},
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Monthly Report',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSearchSection(isDarkMode, colorScheme),
            const SizedBox(height: 24),
            _buildReportTable(colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection(bool isDarkMode, ColorScheme colorScheme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Row(
                children: [
                  Expanded(child: _buildDateField(colorScheme)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildDistrictDropdown(colorScheme)),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildDateField(colorScheme),
                  const SizedBox(height: 16),
                  _buildDistrictDropdown(colorScheme),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildDateField(ColorScheme colorScheme) {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        labelText: 'Search by Date',
        prefixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _selectedDate = null;
              _dateController.clear();
            });
          },
        ),
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }

  Widget _buildDistrictDropdown(ColorScheme colorScheme) {
    return DropdownButtonFormField<String>(
      value: _selectedDistrict,
      decoration: InputDecoration(
        labelText: 'Select District',
        prefixIcon: const Icon(Icons.location_on),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: _districts
          .map((district) => DropdownMenuItem(
        value: district,
        child: Text(district),
      ))
          .toList(),
      onChanged: (value) => setState(() => _selectedDistrict = value),
      dropdownColor: colorScheme.surface,
    );
  }

  Widget _buildReportTable(ColorScheme colorScheme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTableHeader(colorScheme),
            const SizedBox(height: 8),
            ..._reportData.map((data) => _buildTableRow(
              data['category'],
              data['count'].toString(),
              colorScheme,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                fontSize: 16,
              )),
          Text('Count',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                fontSize: 16,
              )),
        ],
      ),
    );
  }

  Widget _buildTableRow(String label, String value, ColorScheme colorScheme) {
    IconData icon;
    Color iconColor;

    switch(label) {
      case 'Total Cases':
        icon = Icons.assignment;
        iconColor = Colors.orange;
        break;
      case 'Total Investigations':
        icon = Icons.search;
        iconColor = Colors.blue;
        break;
      case 'Recoveries':
        icon = Icons.health_and_safety;
        iconColor = Colors.green;
        break;
      case 'Deaths':
        icon = Icons.warning;
        iconColor = Colors.red;
        break;
      default:
        icon = Icons.info;
        iconColor = colorScheme.primary;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 12),
              Text(label,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 14,
                  )),
            ],
          ),
          Text(value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                fontSize: 14,
              )),
        ],
      ),
    );
  }
}