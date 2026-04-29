import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/glass_card.dart';

class CareerDetailScreen extends StatefulWidget {
  const CareerDetailScreen({Key? key}) : super(key: key);

  @override
  State<CareerDetailScreen> createState() => _CareerDetailScreenState();
}

class _CareerDetailScreenState extends State<CareerDetailScreen> {
  final Set<String> _simulatedSkills = {};

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final career = state.selectedCareer;
        if (career == null) return const Scaffold(body: Center(child: Text("No career selected")));
        final isDark = state.isDarkMode;

        // Calculate simulated match
        int baseMatch = 65;
        int currentMatch = baseMatch + (_simulatedSkills.length * 8);
        if (currentMatch > 100) currentMatch = 100;

        return Scaffold(
          appBar: AppBar(title: Text(career.title)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(career, isDark),
                const SizedBox(height: 30),
                _buildSectionTitle("Skill Gap Analysis", isDark),
                const SizedBox(height: 16),
                _buildSkillGap(career, state, isDark),
                const SizedBox(height: 30),
                _buildSectionTitle("Career Simulator", isDark),
                const SizedBox(height: 16),
                _buildSimulator(career, state, currentMatch, isDark),
                const SizedBox(height: 30),
                _buildSectionTitle("Market Insights", isDark),
                const SizedBox(height: 16),
                _buildMarketInsights(career, isDark),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomAction(state),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark)),
    );
  }

  Widget _buildHeader(dynamic career, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(career.description, style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 16)),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _buildInfoChip(LucideIcons.briefcase, career.salaryRange, isDark),
            _buildInfoChip(LucideIcons.trendingUp, "High Demand", isDark),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: AppColors.primaryPurple.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primaryPurple),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildSkillGap(dynamic career, AppStateProvider state, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBg(isDark),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderColor(isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Missing Skills", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: career.requiredSkills.map<Widget>((skill) {
              final hasSkill = state.user.skills.any((s) => s.name == skill);
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: hasSkill ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: hasSkill ? Colors.green.withOpacity(0.3) : Colors.red.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(hasSkill ? LucideIcons.check : LucideIcons.x, size: 12, color: hasSkill ? Colors.green : Colors.red),
                    const SizedBox(width: 6),
                    Text(skill, style: TextStyle(color: hasSkill ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text("AI Tip: Focus on SQL first to increase your match by 15%.", style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 12, fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  Widget _buildSimulator(dynamic career, AppStateProvider state, int currentMatch, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.primaryBlue.withOpacity(0.1), AppColors.primaryPurple.withOpacity(0.1)]),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Match Score", style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 12)),
                  Text("$currentMatch%", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.primaryBlue)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Salary Preview", style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 12)),
                  Text("\$${(80 + (currentMatch * 0.5)).toInt()}k/yr", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryPurple)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),
          Text("Simulate acquiring new skills:", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: career.requiredSkills.where((s) => !state.user.skills.any((us) => us.name == s)).map<Widget>((skill) {
              final isSimulated = _simulatedSkills.contains(skill);
              return FilterChip(
                label: Text(skill, style: TextStyle(color: isSimulated ? Colors.white : AppColors.textPrimary(isDark))),
                selected: isSimulated,
                onSelected: (val) => setState(() => val ? _simulatedSkills.add(skill) : _simulatedSkills.remove(skill)),
                selectedColor: AppColors.primaryBlue,
                checkmarkColor: Colors.white,
                backgroundColor: isDark ? Colors.white10 : Colors.black12,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMarketInsights(dynamic career, bool isDark) {
    return Column(
      children: [
        _buildInsightTile(LucideIcons.users, "500+ job openings in your area", isDark),
        _buildInsightTile(LucideIcons.clock, "Avg. hiring time: 3 weeks", isDark),
      ],
    );
  }

  Widget _buildInsightTile(IconData icon, String text, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardBg(isDark), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.borderColor(isDark))),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primaryPurple),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: TextStyle(color: AppColors.textPrimary(isDark), fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildBottomAction(AppStateProvider state) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () {
          state.generateRoadmap(state.selectedCareer!);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text("Generate Learning Path", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
