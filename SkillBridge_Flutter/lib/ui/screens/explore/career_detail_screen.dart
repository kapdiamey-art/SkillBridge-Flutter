import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/gradient_button.dart';

class CareerDetailScreen extends StatefulWidget {
  const CareerDetailScreen({Key? key}) : super(key: key);

  @override
  State<CareerDetailScreen> createState() => _CareerDetailScreenState();
}

class _CareerDetailScreenState extends State<CareerDetailScreen> {
  bool _isSimulating = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final career = state.selectedCareer;
        final isDark = state.isDarkMode;
        
        if (career == null) return const Scaffold();

        return Scaffold(
          appBar: AppBar(title: Text(career.title)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMatchHeader(isDark, _isSimulating),
                const SizedBox(height: 30),
                _buildSectionTitle("Why this career?", isDark),
                Text(career.whyThisCareer, style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 15, height: 1.5)),
                const SizedBox(height: 30),
                _buildMarketInsights(isDark),
                const SizedBox(height: 30),
                _buildWhatIfSimulator(isDark),
                const SizedBox(height: 30),
                _buildSectionTitle("Skill Gap Analysis", isDark),
                _buildSkillList(career, state, isDark),
                const SizedBox(height: 40),
                GradientButton(
                  text: "Generate Roadmap",
                  onPressed: () {
                    state.generateRoadmap(career);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMatchHeader(bool isDark, bool isSimulating) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          _buildMatchCircle(isSimulating ? 92 : 72),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSimulating ? "SIMULATED MATCH" : "CURRENT MATCH",
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white70),
                ),
                const SizedBox(height: 4),
                const Text("High Alignment", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCircle(int percent) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: CircularProgressIndicator(
            value: percent / 100,
            strokeWidth: 6,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            strokeCap: StrokeCap.round,
          ),
        ),
        Text("$percent%", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buildMarketInsights(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Job Market Insights", isDark),
        Row(
          children: [
            _buildInsightItem("Demand", "High", LucideIcons.trendingUp, isDark, AppColors.success),
            const SizedBox(width: 12),
            _buildInsightItem("Salary", "\$90k+", LucideIcons.dollarSign, isDark, AppColors.primaryBlue),
          ],
        ),
      ],
    );
  }

  Widget _buildInsightItem(String label, String val, IconData icon, bool isDark, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBg(isDark),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor(isDark)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 8),
            Text(val, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
            Text(label, style: TextStyle(fontSize: 12, color: AppColors.textMuted(isDark))),
          ],
        ),
      ),
    );
  }

  Widget _buildWhatIfSimulator(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(LucideIcons.flaskConical, color: AppColors.primaryBlue, size: 20),
              const SizedBox(width: 12),
              Text("What-if Simulator", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
              const Spacer(),
              Switch(
                value: _isSimulating,
                onChanged: (val) => setState(() => _isSimulating = val),
                activeColor: AppColors.primaryBlue,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Toggle skills to see how they impact your career trajectory and salary projections.",
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary(isDark)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
    );
  }

  Widget _buildSkillList(dynamic career, AppStateProvider state, bool isDark) {
    return Column(
      children: career.requiredSkills.map<Widget>((skill) {
        final hasSkill = state.user.skills.any((s) => s.name.toLowerCase() == skill.toLowerCase());
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Icon(hasSkill ? Icons.check_circle : Icons.circle_outlined, color: hasSkill ? AppColors.success : AppColors.textMuted(isDark), size: 20),
              const SizedBox(width: 12),
              Text(skill, style: TextStyle(color: hasSkill ? AppColors.textPrimary(isDark) : AppColors.textSecondary(isDark))),
              const Spacer(),
              if (!hasSkill)
                TextButton(onPressed: () {}, child: const Text("Learn", style: TextStyle(fontSize: 12))),
            ],
          ),
        );
      }).toList(),
    );
  }
}
