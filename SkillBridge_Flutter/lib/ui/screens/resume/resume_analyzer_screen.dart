import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/glass_card.dart';

class ResumeAnalyzerScreen extends StatelessWidget {
  const ResumeAnalyzerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("Resume Analyzer"),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUploadCard(isDark),
                const SizedBox(height: 30),
                _buildScoreOverview(isDark),
                const SizedBox(height: 30),
                _buildAnalysisSections(isDark),
                const SizedBox(height: 30),
                _buildAtsTips(isDark),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUploadCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2), style: BorderStyle.solid),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(LucideIcons.fileText, size: 48, color: AppColors.primaryBlue),
            const SizedBox(height: 16),
            Text("resume_v2_final.pdf", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
            const SizedBox(height: 4),
            Text("Uploaded 2 days ago", style: TextStyle(fontSize: 12, color: AppColors.textMuted(isDark))),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.refreshCw, size: 16, color: Colors.white),
              label: const Text("Re-upload Resume", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreOverview(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBg(isDark),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderColor(isDark)),
      ),
      child: Row(
        children: [
          _buildScoreCircle(84, isDark),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Resume Score", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
                const SizedBox(height: 4),
                Text("Your resume is better than 84% of candidates in our database.", style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCircle(int score, bool isDark) {
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
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryPurple),
            strokeCap: StrokeCap.round,
          ),
        ),
        Text("$score", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary(isDark))),
      ],
    );
  }

  Widget _buildAnalysisSections(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Detailed Analysis", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        const SizedBox(height: 16),
        _buildAnalysisTile("Content Quality", "Excellent", 0.9, Colors.green, isDark),
        _buildAnalysisTile("Visual Structure", "Good", 0.75, Colors.blue, isDark),
        _buildAnalysisTile("ATS Compatibility", "Needs Work", 0.6, Colors.orange, isDark),
      ],
    );
  }

  Widget _buildAnalysisTile(String title, String status, double progress, Color color, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary(isDark))),
              Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: isDark ? Colors.white10 : Colors.black12,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildAtsTips(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("ATS Optimization Tips", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
        const SizedBox(height: 16),
        _buildTipCard("Avoid using tables or columns as some older ATS might struggle to parse them.", isDark),
        _buildTipCard("Include keywords found in the job description to improve your relevance score.", isDark),
      ],
    );
  }

  Widget _buildTipCard(String tip, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface(isDark),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(LucideIcons.lightbulb, size: 18, color: AppColors.primaryBlue),
          const SizedBox(width: 12),
          Expanded(child: Text(tip, style: TextStyle(fontSize: 13, color: AppColors.textSecondary(isDark)))),
        ],
      ),
    );
  }
}
