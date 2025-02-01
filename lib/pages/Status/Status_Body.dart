import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/utils/theme_notifier.dart';

class StatusBody extends StatelessWidget {
  const StatusBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.themeMode == ThemeMode.dark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mosquard',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF24B686),
          primary: const Color(0xFF24B686),
          secondary: const Color(0xFF1E3D6B),
          tertiary: const Color(0xFFFFA726),
        ),
        fontFamily: 'Poppins',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildReportsList(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        print("Clicked Plus Mark!");
      },
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(100),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.secondary.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildReportsList() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            String status = index % 3 == 0
                ? 'In Progress'
                : index % 3 == 1
                    ? 'Completed'
                    : 'Rejected';

            return ReportCard(
              location: 'Kedawas Area ${index + 1}',
              time: '06/01/2023 04:05PM',
              status: status,
              imageUrl: 'https://picsum.photos/200/200?random=$index',
              onTap: () {
                // Navigate to a detailed screen (example)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReportDetailsScreen()),
                );
              },
            );
          },
          childCount: 10,
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String location;
  final String time;
  final String status;
  final String imageUrl;
  final VoidCallback onTap;

  const ReportCard({
    super.key,
    required this.location,
    required this.time,
    required this.status,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the border color based on the status
    Color borderColor;
    switch (status.toLowerCase()) {
      case 'completed':
        borderColor = Colors.yellow;
        break;
      case 'rejected':
        borderColor = Colors.red;
        break;
      default:
        borderColor = Colors.green;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: borderColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                          context,
                          Icons.location_on,
                          'Location',
                          location,
                          Colors.blue,
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          context,
                          Icons.access_time,
                          'Time',
                          time,
                          Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        _buildStatusBadge(context),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    Color getStatusColor() {
      switch (status.toLowerCase()) {
        case 'completed':
          return Colors.green;
        case 'rejected':
          return Colors.red;
        default:
          return Colors.blue;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status.toLowerCase() == 'completed'
                ? Icons.check_circle
                : status.toLowerCase() == 'rejected'
                    ? Icons.cancel
                    : Icons.refresh,
            size: 16,
            color: getStatusColor(),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: getStatusColor(),
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}


class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to home screen and clear stack
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false, // Clear stack
            );
          },
        ),
        title: const Text('Report Details'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: const Center(
        child: Text('Report details go here.'),
      ),
    );
  }
}
