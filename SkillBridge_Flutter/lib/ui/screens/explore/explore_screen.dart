import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/theme_toggle.dart';
import 'career_detail_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("Explore Careers"),
            actions: const [ThemeToggle(), SizedBox(width: 16)],
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: state.recommendedCareers.length,
            itemBuilder: (context, index) {
              final career = state.recommendedCareers[index];
              final match = (60 + (index * 5)) % 100; // Simulated match
              
              return GestureDetector(
                onTap: () {
                  state.selectCareer(career);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CareerDetailScreen()));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg(isDark),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.borderColor(isDark)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            career.title,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark)),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "$match% Match",
                              style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        career.description,
                        style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        children: career.requiredSkills.take(3).map((skill) => _buildSkillTag(skill, isDark)).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSkillTag(String label, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.black12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: TextStyle(fontSize: 11, color: AppColors.textSecondary(isDark))),
    );
  }
}
