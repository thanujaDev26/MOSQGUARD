import 'package:flutter/material.dart';
import 'package:mosqguard/pages/dashboard/map_screen.dart';


class CustomHome extends StatelessWidget {
  const CustomHome({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.02,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWideScreen = constraints.maxWidth > 600;
                return Column(
                  children: [
                    _buildStatsCard(
                      context,
                      title: "Total Reportings",
                      value: "12",
                      color: const Color(0xFF004DB9),
                      imagePath: 'assets/mosqguard/Reporting Person.png',
                      isWideScreen: isWideScreen,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildStatsCard(
                      context,
                      title: "Past 24 Hours",
                      value: "2",
                      color: const Color(0xFFFFCC66),
                      isWideScreen: isWideScreen,
                      extraContent: Row(
                        children: [
                          Text(
                            "24",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.access_time,
                              color: Colors.red, size: screenWidth * 0.06),
                        ],
                      ),
                    ),
                  ],
                );
              },
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
                  if (extraContent != null) extraContent,
                  Text(
                  title,
                  style: TextStyle(
                  color: color.computeLuminance() > 0.5
                  ? Colors.black
                      : Colors.white,
                  fontSize: screenWidth * 0.04,
                  ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                  value,
                  style: TextStyle(
                  color: color.computeLuminance() > 0.5
                  ? Colors.black
                      : Colors.white,
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.bold,
                  ),
                  ),
                  ],
                  ),
                ),
                if (imagePath != null)
                Image.asset(
                imagePath,
                height: isWideScreen ? screenWidth * 0.2 : screenWidth * 0.25,
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildMonthlyReportButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.9,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/monthly_report'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          side: const BorderSide(color: Colors.green),
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
        ),
        child: Text(
          "Monthly Report",
          style: TextStyle(
            color: Colors.green,
            fontSize: screenWidth * 0.04,
          ),
        ),
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        children: [
          Container(
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.05),
              color: Colors.grey[200],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Wrap(
            spacing: screenWidth * 0.04,
            runSpacing: screenWidth * 0.02,
            alignment: WrapAlignment.center,
            children: const [
              LegendItem(label: "Reported Area", color: Colors.red),
              LegendItem(label: "On Progress", color: Colors.green),
              LegendItem(label: "Rejected", color: Colors.black),
              LegendItem(label: "Completed", color: Colors.yellow),
            ],
          ),
        ],
      ),
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