import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/theme_toggle.dart';
import '../quiz/quiz_screen.dart';
import '../resume/resume_analyzer_screen.dart';
import '../common/dummy_feature_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("Career Compass"),
            actions: [
              const ThemeToggle(),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                child: const Text("A", style: TextStyle(color: AppColors.primaryBlue, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWelcomeHeader(state, isDark),
                const SizedBox(height: 30),
                _buildReadinessCard(state, isDark),
                const SizedBox(height: 30),
                _buildSkillGapSummary(state, isDark),
                const SizedBox(height: 30),
                _buildInsightsSection(isDark),
                const SizedBox(height: 30),
                _buildQuickActions(context, isDark),
                const SizedBox(height: 30),
                _buildRecentActivity(isDark),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeHeader(AppStateProvider state, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome back, ${state.user.name} 👋",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary(isDark),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "You are 72% aligned with your target career.",
          style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildReadinessCard(AppStateProvider state, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBg(isDark),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderColor(isDark)),
      ),
      child: Row(
        children: [
          _buildScoreGauge(state.readinessScore, isDark),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Career Readiness", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textPrimary(isDark))),
                const SizedBox(height: 4),
                Text("Based on your latest skills & quizzes.", style: TextStyle(fontSize: 12, color: AppColors.textSecondary(isDark))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreGauge(double score, bool isDark) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            value: score / 100,
            strokeWidth: 8,
            backgroundColor: isDark ? Colors.white10 : Colors.black12,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            strokeCap: StrokeCap.round,
          ),
        ),
        Text("${score.toInt()}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary(isDark))),
      ],
    );
  }

  Widget _buildSkillGapSummary(AppStateProvider state, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Skill Gap Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBg(isDark),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderColor(isDark)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Top missing skills for 'Product Designer':", style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 13)),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  _buildMissingSkillTag("User Research", isDark),
                  _buildMissingSkillTag("Figma Pro", isDark),
                  _buildMissingSkillTag("A/B Testing", isDark),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMissingSkillTag(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.red.withOpacity(0.2))),
      child: Text(label, style: const TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInsightsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("AI Insights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryPurple.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primaryPurple.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              const Icon(LucideIcons.sparkles, color: AppColors.primaryPurple, size: 20),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "Users with 'Figma' skills are seeing 40% higher match scores this week.",
                  style: TextStyle(color: AppColors.textPrimary(isDark), fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Quick Modules", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildActionBtn(LucideIcons.fileSearch, "Resume Analyzer", isDark, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ResumeAnalyzerScreen()));
            })),
            const SizedBox(width: 12),
            Expanded(child: _buildActionBtn(LucideIcons.helpCircle, "Quizzes", isDark, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()));
            })),
            const SizedBox(width: 12),
            Expanded(child: _buildActionBtn(LucideIcons.users, "Mentorship", isDark, () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DummyFeatureScreen(
                title: "Mentorship Engine",
                description: "Connect with top industry professionals to accelerate your career growth.",
                icon: LucideIcons.users,
              )));
            })),
          ],
        ),
      ],
    );
  }

  Widget _buildActionBtn(IconData icon, String label, bool isDark, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBg(isDark),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor(isDark)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primaryPurple, size: 24),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textPrimary(isDark))),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        const SizedBox(height: 16),
        _buildActivityTile("Analyzed Resume", "Just now", LucideIcons.fileText, isDark),
        _buildActivityTile("Completed Skill Gap Check", "2 hours ago", LucideIcons.target, isDark),
      ],
    );
  }

  Widget _buildActivityTile(String title, String time, IconData icon, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textMuted(isDark), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary(isDark))),
                Text(time, style: TextStyle(fontSize: 12, color: AppColors.textMuted(isDark))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
