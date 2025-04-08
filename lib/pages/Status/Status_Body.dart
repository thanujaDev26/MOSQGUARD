import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mosqguard/utils/theme_notifier.dart';
import 'api_service.dart';
import 'complaint_model.dart';

class StatusBody extends StatelessWidget {
  const StatusBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeNotifier>(context).themeMode == ThemeMode.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        body: const StatusScreen(),
      ),
    );
  }
}

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key});
  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  Future<List<Complaint>>? _complaintsFuture;

  @override
  void initState() {
    super.initState();
    _complaintsFuture = ApiService.fetchComplaints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Complaint>>(
        future: _complaintsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No complaints found.'));
          }

          final complaints = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final complaint = complaints[index];
                      return ReportCard(
                        location: complaint.location,
                        time: complaint.datetime,
                        status: complaint.status,
                        imageUrl: complaint.imageUrl,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ReportDetailsScreen(),
                          ),
                        ),
                      );
                    },
                    childCount: complaints.length,
                  ),
                ),
              ),
            ],
          );
        },
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

  bool isNewComplaint(String datetimeStr) {
    try {
      final complaintDate = DateTime.parse(datetimeStr);
      final now = DateTime.now();
      final difference = now.difference(complaintDate);
      return difference.inHours < 24;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = _getBorderColor(status, colorScheme);

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
                        _buildInfoRow(context, Icons.location_on, 'Location', location, colorScheme.primary),
                        const SizedBox(height: 8),
                        _buildInfoRow(context, Icons.access_time, 'Date', time, colorScheme.onSurface.withOpacity(0.6)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            StatusBadge(status: status),
                            const SizedBox(width: 8),
                            if (isNewComplaint(time)) const NewBadge(),
                          ],
                        ),
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
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 100);
                      },
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

  Color _getBorderColor(String status, ColorScheme colorScheme) {
    switch (status.toLowerCase()) {
      case 'completed':
        return colorScheme.secondary;
      case 'rejected':
        return colorScheme.error;
      default:
        return colorScheme.primary;
    }
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value, Color iconColor) {
    final textTheme = Theme.of(context).textTheme;
    final mutedTextColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.7);

    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: textTheme.bodySmall?.copyWith(color: mutedTextColor),
        ),
        Expanded(
          child: Text(
            value,
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
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color badgeColor;
    IconData badgeIcon;

    switch (status.toLowerCase()) {
      case 'completed':
        badgeColor = colorScheme.secondary;
        badgeIcon = Icons.check_circle;
        break;
      case 'rejected':
        badgeColor = colorScheme.error;
        badgeIcon = Icons.cancel;
        break;
      default:
        badgeColor = colorScheme.primary;
        badgeIcon = Icons.refresh;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badgeIcon, size: 16, color: badgeColor),
          const SizedBox(width: 6),
          Text(
            status,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class NewBadge extends StatelessWidget {
  const NewBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.fiber_new, size: 16, color: Colors.orange),
          SizedBox(width: 4),
          Text(
            'New',
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w500,
              fontSize: 12,
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
      body: Center(
        child: Text(
          'Report details go here.',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
