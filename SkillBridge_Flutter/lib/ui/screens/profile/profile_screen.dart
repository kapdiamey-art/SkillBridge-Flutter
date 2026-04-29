import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/theme_toggle.dart';
import '../quiz/quiz_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("Your Profile"),
            actions: const [ThemeToggle(), SizedBox(width: 16)],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildProfileHeader(state, isDark),
                const SizedBox(height: 30),
                _buildQuizShortcut(context, isDark),
                const SizedBox(height: 30),
                _buildSettingsSection(state, isDark),
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
        Text(state.user.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        Text("${state.user.branch} • Year ${state.user.year}", style: TextStyle(color: AppColors.textSecondary(isDark))),
      ],
    );
  }

  Widget _buildQuizShortcut(BuildContext context, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizScreen()));
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            Icon(LucideIcons.award, color: Colors.white, size: 30),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Assess Yourself", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  Text("Take a quick quiz to update your score", style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(AppStateProvider state, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Settings", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        const SizedBox(height: 16),
        _buildSettingTile(context, "Dark Mode", LucideIcons.moon, isDark, trailing: Switch(
          value: state.isDarkMode,
          onChanged: (_) => state.toggleTheme(),
          activeColor: AppColors.primaryBlue,
        )),
        _buildSettingTile(context, "Notification Preferences", LucideIcons.bell, isDark),
        _buildSettingTile(context, "Security & Privacy", LucideIcons.shield, isDark),
        _buildSettingTile(context, "Help & Support", LucideIcons.helpCircle, isDark),
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
        onTap: trailing == null ? () => _showDummyDialog(context, title, "$title settings will be available in the next update.") : null,
      ),
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

  Widget _buildLogoutBtn(AppStateProvider state) {
    return TextButton(
      onPressed: () => state.logout(),
      child: const Text("Sign Out", style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}
