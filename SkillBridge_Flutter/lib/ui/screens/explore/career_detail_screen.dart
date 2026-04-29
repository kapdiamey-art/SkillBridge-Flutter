import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';

class CareerDetailScreen extends StatelessWidget {
  const CareerDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final career = state.selectedCareer;
        if (career == null) return const Scaffold();
        final match = state.getMatchPercentage(career);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: AppColors.primaryGradient,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            "${match.toInt()}%",
                            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const Text("Match Score", style: TextStyle(color: Colors.white70, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(career.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 12),
                      _buildSectionTitle("Why this career?"),
                      Text(career.whyThisCareer, style: const TextStyle(color: AppColors.textSecondary, fontSize: 15, height: 1.5)),
                      
                      const SizedBox(height: 30),
                      _buildSectionTitle("Skill Match Breakdown"),
                      _buildSkillMatchList(state, career.requiredSkills),
                      
                      const SizedBox(height: 30),
                      _buildSectionTitle("Job Market Insights"),
                      _buildMarketInsights(career),
                      
                      const SizedBox(height: 30),
                      _buildSectionTitle("Meet Alumni & Mentors"),
                      _buildMentorsList(career.mentors),
                      
                      const SizedBox(height: 30),
                      _buildSectionTitle("A Day in this Role"),
                      GlassCard(
                        child: Text(career.dayInLife, style: const TextStyle(color: AppColors.textSecondary, fontStyle: FontStyle.italic)),
                      ),
                      
                      const SizedBox(height: 40),
                      GradientButton(
                        text: "Generate 3-Month Roadmap",
                        onPressed: () {
                          state.generateRoadmap(career);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Roadmap generated! Check the Roadmap tab.")),
                          );
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildSkillMatchList(AppStateProvider state, List<String> required) {
    return Column(
      children: required.map((skill) {
        final hasSkill = state.user.skills.any((s) => s.name.toLowerCase() == skill.toLowerCase());
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: [
              Icon(
                hasSkill ? LucideIcons.checkCircle2 : LucideIcons.circle,
                size: 18,
                color: hasSkill ? AppColors.success : AppColors.textMuted,
              ),
              const SizedBox(width: 12),
              Text(skill, style: TextStyle(color: hasSkill ? Colors.white : AppColors.textSecondary)),
              const Spacer(),
              if (!hasSkill)
                const Text("Gap", style: TextStyle(color: AppColors.error, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMarketInsights(dynamic career) {
    return Row(
      children: [
        Expanded(child: _buildInsightCard("Demand", career.demand.name.toUpperCase(), LucideIcons.barChart)),
        const SizedBox(width: 12),
        Expanded(child: _buildInsightCard("Salary", career.salaryRange, LucideIcons.dollarSign)),
      ],
    );
  }

  Widget _buildInsightCard(String title, String val, IconData icon) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: AppColors.primaryBlue),
              const SizedBox(width: 6),
              Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildMentorsList(List<dynamic> mentors) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mentors.length,
        itemBuilder: (context, index) {
          final mentor = mentors[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: 16),
            child: GlassCard(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(backgroundImage: NetworkImage(mentor.avatarUrl), radius: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mentor.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(mentor.company, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryBlue),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      minimumSize: const Size(double.infinity, 30),
                    ),
                    child: const Text("Connect", style: TextStyle(color: AppColors.primaryBlue, fontSize: 12)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}
