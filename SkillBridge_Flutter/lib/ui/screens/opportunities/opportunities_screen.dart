import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/theme_toggle.dart';

class OpportunitiesScreen extends StatelessWidget {
  const OpportunitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("Opportunities"),
            actions: const [ThemeToggle(), SizedBox(width: 16)],
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildOpportunityCard(index, isDark);
            },
          ),
        );
      },
    );
  }

  Widget _buildOpportunityCard(int index, bool isDark) {
    final roles = ["Frontend Intern", "Product Designer", "Flutter Developer", "Data Analyst", "UI Engineer"];
    final companies = ["Google", "Notion", "Linear", "Airbnb", "Slack"];
    
    return GestureDetector(
      onTap: () => _showDummyDialog(context, roles[index], "Company: ${companies[index]}\nLocation: Remote\nType: Full-time\n\nDetailed job description and requirements will be displayed here."),
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
                Text(roles[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
                const Icon(LucideIcons.bookmark, size: 20, color: AppColors.primaryBlue),
              ],
            ),
            const SizedBox(height: 4),
            Text(companies[index], style: const TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildTag("Remote", isDark),
                const SizedBox(width: 8),
                _buildTag("Paid", isDark),
                const SizedBox(width: 8),
                _buildTag("Internship", isDark),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$2k - \$5k / mo", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
                ElevatedButton(
                  onPressed: () => _showDummyDialog(context, "Apply for ${roles[index]}", "Your application has been sent to ${companies[index]}!"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text("Apply", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
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

  Widget _buildTag(String label, bool isDark) {
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
