import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/theme_toggle.dart';
import '../resume/resume_analyzer_screen.dart';
import '../common/dummy_feature_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            actions: const [ThemeToggle(), SizedBox(width: 16)],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildProfileHeader(state, isDark),
                const SizedBox(height: 32),
                _buildResumeCard(context, isDark),
                const SizedBox(height: 32),
                _buildQuizzesSection(isDark),
                const SizedBox(height: 32),
                _buildSettingsSection(context, state, isDark),
                const SizedBox(height: 40),
                _buildLogoutBtn(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileHeader(AppStateProvider state, bool isDark) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
              child: const Text("A", style: TextStyle(color: AppColors.primaryBlue, fontSize: 32, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle),
              child: const Icon(Icons.edit, color: Colors.white, size: 16),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          state.user.name,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark)),
        ),
        Text(
          "${state.user.branch} • Year ${state.user.year}",
          style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildResumeCard(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ResumeAnalyzerScreen())),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            const Icon(LucideIcons.fileSearch, color: AppColors.primaryBlue, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Resume Analyzer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary(isDark))),
                  Text("Score: 84/100 • Optimize for ATS", style: TextStyle(fontSize: 12, color: AppColors.textSecondary(isDark))),
                ],
              ),
            ),
            const Icon(LucideIcons.chevronRight, color: AppColors.primaryBlue, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizzesSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Your Quizzes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
            Text("View All", style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 16),
        _buildQuizItem("Python Fundamentals", "Completed", 90, isDark),
        _buildQuizItem("Product Design 101", "Available", 0, isDark),
        _buildQuizItem("SQL for Data Analysis", "Available", 0, isDark),
      ],
    );
  }

  Widget _buildQuizItem(String title, String status, int score, bool isDark) {
    final isCompleted = status == "Completed";
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: isCompleted ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(isCompleted ? LucideIcons.checkCircle : LucideIcons.playCircle, color: isCompleted ? Colors.green : Colors.orange, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
                Text(isCompleted ? "Score: $score%" : "Take now to improve match", style: TextStyle(fontSize: 12, color: AppColors.textSecondary(isDark))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context, AppStateProvider state, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Account Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        const SizedBox(height: 16),
        _buildSettingTile(context, "Dark Mode", LucideIcons.moon, isDark, trailing: Switch(
          value: state.isDarkMode,
          onChanged: (_) => state.toggleTheme(),
          activeColor: AppColors.primaryBlue,
        )),
        _buildSettingTile(context, "Notification Settings", LucideIcons.bell, isDark),
        _buildSettingTile(context, "Privacy & Data", LucideIcons.shield, isDark),
      ],
    );
  }

  Widget _buildSettingTile(BuildContext context, String title, IconData icon, bool isDark, {Widget? trailing}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg(isDark),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor(isDark)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: AppColors.primaryBlue),
        title: Text(title, style: TextStyle(color: AppColors.textPrimary(isDark), fontWeight: FontWeight.w600)),
        trailing: trailing ?? Icon(LucideIcons.chevronRight, size: 16, color: AppColors.textMuted(isDark)),
        onTap: trailing == null ? () => Navigator.push(context, MaterialPageRoute(builder: (context) => DummyFeatureScreen(
          title: title,
          description: "Manage your $title here with advanced controls and sync options.",
          icon: icon,
        ))) : null,
      ),
    );
  }

  Widget _buildLogoutBtn(AppStateProvider state) {
    return TextButton.icon(
      onPressed: () => state.logout(),
      icon: const Icon(LucideIcons.logOut, color: Colors.red),
      label: const Text("Sign Out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    );
  }
}
