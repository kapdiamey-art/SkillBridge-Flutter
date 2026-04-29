import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';

class DummyFeatureScreen extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const DummyFeatureScreen({
    Key? key,
    required this.title,
    required this.description,
    this.icon = LucideIcons.layers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 64, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: 30),
            Text(
              title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary(isDark)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBg(isDark),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.borderColor(isDark)),
              ),
              child: Column(
                children: [
                  _buildPlaceholderRow("Active Sessions", "0", isDark),
                  const Divider(height: 30),
                  _buildPlaceholderRow("Pending Requests", "2", isDark),
                  const Divider(height: 30),
                  _buildPlaceholderRow("Last Sync", "Just now", isDark),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("Go Back", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderRow(String label, String value, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: AppColors.textSecondary(isDark))),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
      ],
    );
  }
}
