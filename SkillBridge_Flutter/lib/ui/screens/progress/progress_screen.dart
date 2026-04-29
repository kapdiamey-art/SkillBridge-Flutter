import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/theme_toggle.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("Your Progress"),
            actions: const [ThemeToggle(), SizedBox(width: 16)],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryHeader(state, isDark),
                const SizedBox(height: 30),
                Text("Weekly Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
                const SizedBox(height: 16),
                _buildActivityChart(isDark),
                const SizedBox(height: 30),
                Text("Milestones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
                const SizedBox(height: 16),
                _buildMilestoneList(isDark),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryHeader(AppStateProvider state, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBg(isDark),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderColor(isDark)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStat("Tasks", "12/20", LucideIcons.checkSquare, isDark),
              _buildStat("Quizzes", "4", LucideIcons.helpCircle, isDark),
              _buildStat("Level", "7", LucideIcons.award, isDark),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(LucideIcons.trendingUp, color: AppColors.success, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "You are 12% ahead of your schedule this week!",
                  style: TextStyle(color: AppColors.textPrimary(isDark), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon, bool isDark) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryPurple, size: 20),
        const SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        Text(label, style: TextStyle(fontSize: 12, color: AppColors.textMuted(isDark))),
      ],
    );
  }

  Widget _buildActivityChart(bool isDark) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg(isDark),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderColor(isDark)),
      ),
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            _buildBarGroup(0, 8, isDark),
            _buildBarGroup(1, 10, isDark),
            _buildBarGroup(2, 14, isDark),
            _buildBarGroup(3, 12, isDark),
            _buildBarGroup(4, 18, isDark),
            _buildBarGroup(5, 15, isDark),
            _buildBarGroup(6, 9, isDark),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y, bool isDark) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: AppColors.primaryGradient,
          width: 12,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildMilestoneList(bool isDark) {
    return Column(
      children: [
        _buildMilestoneTile("Foundational Skills", "Completed", true, isDark),
        _buildMilestoneTile("Core Projects", "In Progress", false, isDark),
        _buildMilestoneTile("Portfolio Ready", "Locked", false, isDark),
      ],
    );
  }

  Widget _buildMilestoneTile(String title, String status, bool isDone, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg(isDark),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor(isDark)),
      ),
      child: Row(
        children: [
          Icon(isDone ? LucideIcons.checkCircle2 : LucideIcons.circle, color: isDone ? AppColors.success : AppColors.textMuted(isDark), size: 20),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark)))),
          Text(status, style: TextStyle(fontSize: 12, color: AppColors.textMuted(isDark))),
        ],
      ),
    );
  }
}
