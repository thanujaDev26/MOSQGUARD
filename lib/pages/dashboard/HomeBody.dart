import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomHome extends StatelessWidget {
  const CustomHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                                "12",
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
                                  Icon(Icons.access_time, color: Colors.red),
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
                                "2",
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
          // Map Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200],
                  ),
                ),
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
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({
    required this.color,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
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