import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../../data/mock/mock_data.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/skill_chip.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Done")),
        ],
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, state, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=user123'),
                ),
                const SizedBox(height: 16),
                Text(state.user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                Text("${state.user.branch} • Year ${state.user.year}", style: const TextStyle(color: AppColors.textSecondary)),
                
                const SizedBox(height: 30),
                _buildSectionHeader("My Skills"),
                const SizedBox(height: 12),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: state.user.skills.map((skill) => SkillChip(
                          label: skill.name,
                          isSelected: true,
                          onTap: () => state.toggleSkill(skill),
                        )).toList(),
                      ),
                      const SizedBox(height: 20),
                      OutlinedButton.icon(
                        onPressed: () => _showAddSkillDialog(context, state),
                        icon: const Icon(LucideIcons.plus, size: 16),
                        label: const Text("Add New Skill"),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primaryBlue),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                _buildSectionHeader("Interests"),
                const SizedBox(height: 12),
                GlassCard(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: state.user.interests.map((interest) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white.withOpacity(0.05)),
                      ),
                      child: Text(interest, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                    )).toList(),
                  ),
                ),
                
                const SizedBox(height: 40),
                _buildOptionTile(LucideIcons.settings, "Account Settings"),
                _buildOptionTile(LucideIcons.bell, "Notifications"),
                _buildOptionTile(LucideIcons.helpCircle, "Help & Support"),
                _buildOptionTile(LucideIcons.logOut, "Logout", color: AppColors.error),
                
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color ?? AppColors.textSecondary, size: 20),
            const SizedBox(width: 16),
            Text(title, style: TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.w500)),
            const Spacer(),
            Icon(LucideIcons.chevronRight, color: AppColors.textMuted, size: 16),
          ],
        ),
      ),
    );
  }

  void _showAddSkillDialog(BuildContext context, AppStateProvider state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Add Skills", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: MockData.allSkills.map((skill) {
                      final isSelected = state.user.skills.any((s) => s.id == skill.id);
                      return SkillChip(
                        label: skill.name,
                        isSelected: isSelected,
                        onTap: () => state.toggleSkill(skill),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Done"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
