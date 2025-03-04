import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/utils/theme_notifier.dart';

class StatusBody extends StatelessWidget {
  const StatusBody({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF24B686),
          brightness: Brightness.dark,
          primary: const Color(0xFF24B686),
          secondary: const Color(0xFF1E3D6B),
          tertiary: const Color(0xFFFFA726),
        ),
        fontFamily: 'Poppins',
      ),
      themeMode: themeNotifier.themeMode,
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
      body: CustomScrollView(
        slivers: [
          _buildReportsList(),
        ],
      ),
    );
  }

  Widget _buildReportsList() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final status = ['In Progress', 'Completed', 'Rejected'][index % 3];
            return ReportCard(
              location: 'Kedawas Area ${index + 1}',
              time: '06/01/2023 04:05PM',
              status: status,
              imageUrl: 'https://picsum.photos/200/200?random=$index',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportDetailsScreen()),
              ),
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
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color borderColor;
    switch (status.toLowerCase()) {
      case 'completed':
        borderColor = colorScheme.secondary;
        break;
      case 'rejected':
        borderColor = colorScheme.error;
        break;
      default:
        borderColor = colorScheme.primary;
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
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.black.withOpacity(0.05),
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
                          colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        _buildInfoRow(
                          context,
                          Icons.access_time,
                          'Time',
                          time,
                          colorScheme.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(height: 8),
                        _buildStatusBadge(context),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
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
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 8),
        Text('$label: ', style: textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        )),
        Expanded(
          child: Text(value,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Color statusColor;
    IconData statusIcon;

    switch (status.toLowerCase()) {
      case 'completed':
        statusColor = colorScheme.secondary;
        statusIcon = Icons.check_circle;
        break;
      case 'rejected':
        statusColor = colorScheme.error;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = colorScheme.primary;
        statusIcon = Icons.refresh;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, size: 16, color: statusColor),
          const SizedBox(width: 6),
          Text(status,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w500,
              )),
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
      body: Center(
        child: Text('Report details go here.',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
      ),
    );
  }
}