import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/glass_card.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SkillBridge"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            icon: const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=user123'),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, state, _) {
          final topMatches = state.recommendedCareers.take(2).toList();
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, ${state.user.name.isEmpty ? 'Student' : state.user.name} 👋",
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Ready to bridge your skill gap today?",
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                ),
                const SizedBox(height: 30),
                
                _buildSectionHeader("Top Career Matches"),
                const SizedBox(height: 16),
                ...topMatches.map((career) {
                  final matchPercent = state.getMatchPercentage(career);
                  return _buildCareerCard(context, career, matchPercent);
                }).toList(),
                
                const SizedBox(height: 30),
                _buildSectionHeader("Skill Gap Summary"),
                const SizedBox(height: 16),
                _buildSkillGapCard(state),
                
                const SizedBox(height: 30),
                if (state.activeRoadmap != null)
                  _buildContinueRoadmap(state),
                
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("See All", style: TextStyle(color: AppColors.primaryBlue)),
        ),
      ],
    );
  }

  Widget _buildCareerCard(BuildContext context, dynamic career, double match) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GlassCard(
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(LucideIcons.briefcase, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    career.title,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    career.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                Text(
                  "${match.toInt()}%",
                  style: const TextStyle(color: AppColors.primaryBlue, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text("Match", style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillGapCard(AppStateProvider state) {
    // Determine missing skills from top career
    final topCareer = state.recommendedCareers.isNotEmpty ? state.recommendedCareers.first : null;
    if (topCareer == null) return const SizedBox();

    final missingSkills = topCareer.requiredSkills.where(
      (req) => !state.user.skills.any((s) => s.name.toLowerCase() == req.toLowerCase())
    ).toList();

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(LucideIcons.alertTriangle, color: AppColors.warning, size: 20),
              SizedBox(width: 10),
              Text(
                "Critical Missing Skills",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: missingSkills.map((skill) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.error.withOpacity(0.3)),
              ),
              child: Text(skill, style: const TextStyle(color: AppColors.error, fontSize: 12)),
            )).toList(),
          ),
          const SizedBox(height: 16),
          const Text(
            "Acquiring these will increase your match for Full Stack Developer by 15%",
            style: TextStyle(color: AppColors.textMuted, fontSize: 13, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueRoadmap(AppStateProvider state) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryBlue.withOpacity(0.2), AppColors.primaryPurple.withOpacity(0.2)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("ACTIVE ROADMAP", style: TextStyle(color: AppColors.primaryBlue, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                const SizedBox(height: 4),
                Text(state.activeRoadmap!.careerTitle, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: state.activeRoadmap!.overallProgress,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    color: AppColors.primaryBlue,
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const Icon(LucideIcons.play, color: AppColors.background, size: 20),
          ),
        ],
      ),
    );
  }
}
