import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/glass_card.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Roadmap"),
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, state, _) {
          final roadmap = state.activeRoadmap;
          if (roadmap == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LucideIcons.map, size: 64, color: AppColors.textMuted),
                  const SizedBox(height: 16),
                  const Text("No active roadmap", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text("Go to Explore and generate a roadmap for a career.", style: TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {}, // Switch to explore tab would be better handled by a controller
                    child: const Text("Explore Careers"),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roadmap.careerTitle,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text("3-Month Intensive Plan", style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Text("${(roadmap.overallProgress * 100).toInt()}% Complete", style: const TextStyle(color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: roadmap.overallProgress,
                    minHeight: 8,
                    backgroundColor: AppColors.surface,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 30),
                ...roadmap.months.map((month) => _buildMonthSection(context, state, month)).toList(),
                
                const SizedBox(height: 20),
                _buildCoachingCard(),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMonthSection(BuildContext context, AppStateProvider state, dynamic month) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.primaryPurple.withOpacity(0.1), shape: BoxShape.circle),
                child: Text("M${month.month}", style: const TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Text("Month ${month.month}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
        ...month.tasks.map((task) => Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (val) => state.toggleTask(month.month.toString(), task.id),
                  activeColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          color: task.isCompleted ? AppColors.textMuted : Colors.white,
                          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (task.resourceUrl.isNotEmpty)
                        Text("Resource Link", style: TextStyle(color: AppColors.primaryBlue, fontSize: 12)),
                    ],
                  ),
                ),
                Icon(LucideIcons.externalLink, size: 14, color: AppColors.textMuted),
              ],
            ),
          ),
        )).toList(),
      ],
    );
  }

  Widget _buildCoachingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.mapPin, color: AppColors.primaryBlue, size: 32),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Need extra help?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text("Find local coaching centers near you", style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(LucideIcons.chevronRight, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
