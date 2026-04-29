import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../../data/mock/mock_data.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/skill_chip.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  void _nextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.read<AppStateProvider>().completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: [
                  AppColors.primaryPurple.withOpacity(0.1),
                  AppColors.background(isDark),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: List.generate(5, (index) {
                        return Expanded(
                          child: Container(
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: index <= _currentPage
                                  ? AppColors.primaryBlue
                                  : AppColors.textMuted(isDark).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (page) => setState(() => _currentPage = page),
                      children: [
                        _buildBasicInfo(isDark),
                        _buildSkillSelection(),
                        _buildInterestSelection(),
                        _buildPreferenceQuestions(isDark),
                        _buildResumeUpload(isDark),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: GradientButton(
                      text: _currentPage == 4 ? "Get Started" : "Continue",
                      onPressed: _nextPage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBasicInfo(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            "Let's get to know you",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary(isDark),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Tell us a bit about your academic background to personalize your experience.",
            style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 16),
          ),
          const SizedBox(height: 40),
          _buildTextField("Full Name", _nameController, LucideIcons.user, isDark),
          const SizedBox(height: 20),
          _buildTextField("Branch / Major", _branchController, LucideIcons.bookOpen, isDark),
          const SizedBox(height: 20),
          _buildTextField("Current Year", _yearController, LucideIcons.calendar, isDark),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, IconData icon, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface(isDark),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor(isDark).withOpacity(0.5)),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: AppColors.textPrimary(isDark)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textMuted(isDark)),
          prefixIcon: Icon(icon, color: AppColors.primaryBlue, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(18),
        ),
        onChanged: (val) {
          context.read<AppStateProvider>().updateBasicInfo(
            _nameController.text,
            _branchController.text,
            _yearController.text,
          );
        },
      ),
    );
  }

  Widget _buildSkillSelection() {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Your Skills",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark)),
              ),
              const SizedBox(height: 12),
              Text(
                "Select skills you already have. This helps us calculate your match score.",
                style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 16),
              ),
              const SizedBox(height: 30),
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
            ],
          ),
        );
      },
    );
  }

  Widget _buildInterestSelection() {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "What interests you?",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark)),
              ),
              const SizedBox(height: 12),
              Text(
                "Pick areas you'd like to explore in your career.",
                style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 16),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: MockData.interests.length,
                  itemBuilder: (context, index) {
                    final interest = MockData.interests[index];
                    final isSelected = state.user.interests.contains(interest);
                    return GestureDetector(
                      onTap: () => state.toggleInterest(interest),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryPurple.withOpacity(0.2) : AppColors.surface(isDark),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? AppColors.primaryPurple : AppColors.borderColor(isDark).withOpacity(0.5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            interest,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected ? AppColors.primaryPurple : AppColors.textSecondary(isDark),
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPreferenceQuestions(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            "Quick Preferences",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark)),
          ),
          const SizedBox(height: 12),
          Text(
            "Help us refine your matches with these quick questions.",
            style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 16),
          ),
          const SizedBox(height: 40),
          _buildQuestionCard("How much do you enjoy coding?", ["Love it", "It's okay", "Not for me"], isDark),
          const SizedBox(height: 24),
          _buildQuestionCard("How comfortable are you with Math?", ["Expert", "Competent", "Beginner"], isDark),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(String question, List<String> options, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: TextStyle(color: AppColors.textPrimary(isDark), fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),
        Row(
          children: options.map((opt) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surface(isDark),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor(isDark).withOpacity(0.5)),
                ),
                child: Center(child: Text(opt, style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 12))),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildResumeUpload(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.fileUp, size: 80, color: AppColors.primaryBlue),
          const SizedBox(height: 30),
          Text(
            "Upload your Resume",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark)),
          ),
          const SizedBox(height: 12),
          Text(
            "Optional: We can extract skills automatically from your PDF or Word document.",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 16),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.surface(isDark),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
            ),
            child: const Column(
              children: [
                Icon(LucideIcons.plus, color: AppColors.primaryBlue),
                SizedBox(height: 10),
                Text("Select File", style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
