import 'package:flutter/material.dart';
import 'package:lumani/app_theme.dart';

enum ScanDetailType { reviewed, pending }

class ScanDetailScreen extends StatelessWidget {
  final ScanDetailType type;

  const ScanDetailScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final filename = type == ScanDetailType.reviewed ? "img_2023_09_14.dcm" : "img_2023_10_12.dcm";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          type == ScanDetailType.reviewed ? 'Week 18 Anatomy' : 'Week 22 Check-up',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // DICOM Placeholder
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    bottom: -50,
                    child: Icon(
                      Icons.signal_wifi_4_bar, // Mock ultrasound cone
                      size: 200,
                      color: Colors.white24,
                    ),
                  ),
                  Text(
                    'DICOM VIEWER\n$filename',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Section Title
            Text(
              type == ScanDetailType.reviewed ? "Doctor's Notes" : "Analysis",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            // Note Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: type == ScanDetailType.reviewed ? const Color(0xFFf0fdf4) : AppTheme.infoBg,
                border: Border(
                  left: BorderSide(
                    color: type == ScanDetailType.reviewed ? AppTheme.success : AppTheme.info,
                    width: 4,
                  ),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: type == ScanDetailType.reviewed
                  ? const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dr. Smith says:",
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Everything looks great, Jane. Fetal Heart Rate (FHR) is steady at 145 bpm. Fluid levels look normal. Keep up the good work!",
                          style: TextStyle(color: AppTheme.textDark, height: 1.5),
                        ),
                      ],
                    )
                  : const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Awaiting Review",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1e3a8a)),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Dr. Smith has received your scan. Clinical metrics and annotations will appear here once the review is complete.",
                          style: TextStyle(color: Color(0xFF1e3a8a), height: 1.5),
                        ),
                      ],
                    ),
            ),

            const SizedBox(height: 24),

            // Metrics
            Opacity(
              opacity: type == ScanDetailType.reviewed ? 1.0 : 0.4,
              child: Column(
                children: [
                  _buildMetricRow('FHR', type == ScanDetailType.reviewed ? '145 bpm' : '--- bpm'),
                  _buildMetricRow('Duration', '4m 12s'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFe5e7eb))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppTheme.textLight)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark)),
        ],
      ),
    );
  }
}
