import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/glass_card.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Progress"),
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, state, _) {
          final roadmap = state.activeRoadmap;
          final overallProgress = roadmap?.overallProgress ?? 0.0;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildOverviewCard(overallProgress),
                const SizedBox(height: 30),
                const Text("Skill Growth", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 16),
                _buildGrowthChart(),
                const SizedBox(height: 30),
                const Text("Achievements", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 16),
                _buildAchievementsGrid(),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverviewCard(double progress) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 10,
                  backgroundColor: AppColors.surface,
                  color: AppColors.primaryBlue,
                ),
              ),
              Column(
                children: [
                  Text("${(progress * 100).toInt()}%", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                  const Text("Done", style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat("12", "Tasks Done"),
              Container(width: 1, height: 30, color: Colors.white.withOpacity(0.1)),
              _buildStat("5", "Badges"),
              Container(width: 1, height: 30, color: Colors.white.withOpacity(0.1)),
              _buildStat("3", "Streaks"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
      ],
    );
  }

  Widget _buildGrowthChart() {
    return GlassCard(
      height: 200,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 1),
                FlSpot(1, 1.5),
                FlSpot(2, 1.4),
                FlSpot(3, 2.8),
                FlSpot(4, 3.5),
                FlSpot(5, 4.2),
              ],
              isCurved: true,
              gradient: const LinearGradient(colors: [AppColors.primaryBlue, AppColors.primaryPurple]),
              barWidth: 4,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [AppColors.primaryBlue.withOpacity(0.2), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsGrid() {
    final achievements = [
      {'name': 'Early Bird', 'icon': LucideIcons.zap, 'color': Colors.amber},
      {'name': 'Skill Hunter', 'icon': LucideIcons.target, 'color': Colors.blue},
      {'name': 'Consistent', 'icon': LucideIcons.calendarCheck, 'color': Colors.green},
      {'name': 'Top Match', 'icon': LucideIcons.award, 'color': Colors.purple},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2.5,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        final ach = achievements[index];
        return GlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(ach['icon'] as IconData, color: ach['color'] as Color, size: 20),
              const SizedBox(width: 10),
              Text(ach['name'] as String, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }
}
