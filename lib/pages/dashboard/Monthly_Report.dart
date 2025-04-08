import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MonthlyReportPage extends StatefulWidget {
  @override
  _MonthlyReportPageState createState() => _MonthlyReportPageState();
}

class _MonthlyReportPageState extends State<MonthlyReportPage> {
  String? selectedDistrict;
  Map<String, dynamic> reportData = {};
  bool isLoading = false;
  String errorMessage = '';

  // Replace with your actual district list from API if available
  final List<String> districts = [
    'Ampara',
    'Anuradhapura',
    'Badulla',
    'Batticaloa',
    'Colombo',
    'Galle',
    'Gampaha',
    'Hambantota',
    'Jaffna',
    'Kalutara',
    'Kandy',
    'Kegalle',
    'Kilinochchi',
    'Kurunegala',
    'Mannar',
    'Matale',
    'Matara',
    'Monaragala',
    'Mullaitivu',
    'Nuwara Eliya',
    'Polonnaruwa',
    'Puttalam',
    'Ratnapura',
    'Trincomalee',
    'Vavuniya',
  ];

  Future<void> fetchReport() async {
    if (selectedDistrict == null) return;

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(Uri.parse(
          'http://localhost:3000/api/monthly_report?district=$selectedDistrict'));

      if (response.statusCode == 200) {
        setState(() {
          reportData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load report');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error fetching data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Monthly Health Report',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDistrictSelector(),
            SizedBox(height: 20),
            if (isLoading) LinearProgressIndicator(),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            if (reportData.isNotEmpty) _buildReportGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildDistrictSelector() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Select District',
            prefixIcon: Icon(Icons.location_on),
          ),
          value: selectedDistrict,
          items: districts
              .map((district) => DropdownMenuItem(
            value: district,
            child: Text(district),
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedDistrict = value;
            });
            fetchReport();
          },
        ),
      ),
    );
  }

  Widget _buildReportGrid() {
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
        childAspectRatio: 2.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      children: [
        _StatCard(
          title: 'Total Cases',
          value: reportData['totalCases'].toString(),
          icon: Icons.assignment,
          color: Colors.blue,
        ),
        _StatCard(
          title: 'Investigations',
          value: reportData['totalInvestigations'].toString(),
          icon: Icons.assignment_turned_in,
          color: Colors.orange,
        ),
        _StatCard(
          title: 'Deaths',
          value: reportData['totalDeaths'].toString(),
          icon: Icons.warning,
          color: Colors.red,
        ),
        _StatCard(
          title: 'Recoveries',
          value: reportData['totalRecoveries'].toString(),
          icon: Icons.health_and_safety,
          color: Colors.green,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}