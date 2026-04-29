import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/theme_toggle.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        final roadmap = state.activeRoadmap;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("Your Roadmap"),
            actions: const [ThemeToggle(), SizedBox(width: 16)],
          ),
          body: roadmap == null ? _buildEmptyState(isDark) : _buildRoadmapContent(state, isDark),
        );
      },
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.map, size: 64, color: AppColors.textMuted(isDark)),
          const SizedBox(height: 16),
          Text("No active roadmap", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
          const SizedBox(height: 8),
          Text("Select a career in Explore to generate one.", style: TextStyle(color: AppColors.textSecondary(isDark))),
        ],
      ),
    );
  }

  Widget _buildRoadmapContent(AppStateProvider state, bool isDark) {
    final roadmap = state.activeRoadmap!;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGoalHeader(roadmap, isDark),
          const SizedBox(height: 30),
          Text("Learning Journey", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
          const SizedBox(height: 16),
          ...roadmap.months.map((month) => _buildMonthSection(state, month, isDark)).toList(),
        ],
      ),
    );
  }

  Widget _buildGoalHeader(dynamic roadmap, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("ACTIVE GOAL", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white70)),
          const SizedBox(height: 8),
          Text(roadmap.careerTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: roadmap.overallProgress,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 6,
          ),
          const SizedBox(height: 8),
          Text("${(roadmap.overallProgress * 100).toInt()}% Milestone completion", style: const TextStyle(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildMonthSection(AppStateProvider state, dynamic month, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.primaryPurple.withOpacity(0.1), shape: BoxShape.circle),
                child: Text("M${month.month}", style: const TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Text("Month ${month.month}", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
            ],
          ),
        ),
        ...month.tasks.map((task) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBg(isDark),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderColor(isDark)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (val) => state.toggleTask(month.month.toString(), task.id),
                    activeColor: AppColors.primaryBlue,
                  ),
                  Expanded(
                    child: Text(
                      task.title,
                      style: TextStyle(
                        color: task.isCompleted ? AppColors.textMuted(isDark) : AppColors.textPrimary(isDark),
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                ],
              ),
              if (!task.isCompleted)
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, top: 4),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.link, size: 12, color: AppColors.primaryBlue),
                      const SizedBox(width: 4),
                      Text("Recommended: Documentation", style: TextStyle(color: AppColors.primaryBlue, fontSize: 12)),
                    ],
                  ),
                ),
            ],
          ),
        )).toList(),
      ],
    );
  }
}
