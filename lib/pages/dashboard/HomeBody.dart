import 'package:flutter/material.dart';
import 'package:mosqguard/pages/dashboard/map_screen.dart';
import 'Home_Body_Api.dart';


class CustomHome extends StatefulWidget {
  const CustomHome({super.key});

  @override
  State<CustomHome> createState() => _CustomHomeState();
}

class _CustomHomeState extends State<CustomHome> {
  int totalCount = 0;
  int past24HourCount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCounts();
  }

  Future<void> loadCounts() async {
    try {
      final counts = await ApiService.fetchMessageCounts();
      print("Fetched counts: ${counts.totalCount}, ${counts.past24HourCount}");
      setState(() {
        totalCount = counts.totalCount;
        past24HourCount = counts.past24HourCount;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching counts: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
      child: Column(
        children: [
          // Your cards here
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Color(0xFF004DB9),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Reportings",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "$totalCount",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/mosqguard/Reporting Person.png',
                          height: 90,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Color(0xFFFFCC66),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "24",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(Icons.access_time,
                                      color: Colors.red),
                                ],
                              ),
                              Text(
                                "Past 24 Hours",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "$past24HourCount",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/monthly_report');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: Colors.green),
            ),
            child: Text(
              "Monthly Report",
              style: TextStyle(color: Colors.green),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MapScreen(),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLegendItem("Reported Area", Colors.red),
                    _buildLegendItem("On Progress", Colors.green),
                    _buildLegendItem("Rejected", Colors.black),
                    _buildLegendItem("Completed", Colors.yellow),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

