import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/theme_toggle.dart';

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
                Text(
                  "Career Readiness Score",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary(isDark)),
                ),
                const SizedBox(height: 8),
                Text(
                  "Based on skills, quiz results, and activity progress.",
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary(isDark)),
                ),
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
        Text(
          "${score.toInt()}",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary(isDark)),
        ),
      ],
    );
  }

  Widget _buildInsightsSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Weekly AI Insights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              const Icon(LucideIcons.zap, color: AppColors.primaryBlue, size: 20),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "You improved faster than 68% of users this week. Focus on SQL to unlock 5 new roles.",
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
    return Row(
      children: [
        Expanded(child: _buildActionBtn(LucideIcons.helpCircle, "Take Quiz", isDark, () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizScreen()));
        })),
        const SizedBox(width: 12),
        Expanded(child: _buildActionBtn(LucideIcons.bookOpen, "Skills", isDark, () {
          // Navigate to Profile tab (index 4)
          // Since I can't easily trigger parent state from here without a controller, 
          // I'll show a quick dialog for now to simulate "Update Skills"
          _showDummyDialog(context, "Update Skills", "Skill management will open here.");
        })),
        const SizedBox(width: 12),
        Expanded(child: _buildActionBtn(LucideIcons.map, "Roadmap", isDark, () {
          // In a real app, this would switch the BottomNav index to 2
          _showDummyDialog(context, "Your Roadmap", "Switching to your active learning path.");
        })),
      ],
    );
  }

  void _showDummyDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
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
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textPrimary(isDark))),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        const SizedBox(height: 16),
        _buildActivityTile("Completed Python Quiz", "2 hours ago", LucideIcons.checkCircle, isDark),
        _buildActivityTile("Added 'React' to skills", "Yesterday", LucideIcons.plusCircle, isDark),
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
