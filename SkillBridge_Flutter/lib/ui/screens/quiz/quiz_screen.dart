import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestion = 0;
  int _score = 0;
  bool _showResult = false;

  final List<Map<String, dynamic>> _questions = [
    {
      "question": "Which of the following is NOT a core Flutter widget?",
      "options": ["Container", "Scaffold", "StatefulWidget", "HTMLDiv"],
      "answer": 3
    },
    {
      "question": "What does 'Dart' primarily compile to for web?",
      "options": ["C++", "JavaScript", "Python", "Assembly"],
      "answer": 1
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(title: const Text("Career Assessment")),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: _showResult ? _buildResult(state, isDark) : _buildQuestion(isDark),
          ),
        );
      },
    );
  }

  Widget _buildQuestion(bool isDark) {
    final q = _questions[_currentQuestion];
    double progress = (_currentQuestion + 1) / _questions.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: isDark ? Colors.white10 : Colors.black12,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
        ),
        const SizedBox(height: 40),
        Text(
          "Question ${_currentQuestion + 1}/${_questions.length}",
          style: const TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          q['question'],
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark)),
        ),
        const SizedBox(height: 40),
        ...List.generate(q['options'].length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (index == q['answer']) _score++;
                if (_currentQuestion < _questions.length - 1) {
                  setState(() => _currentQuestion++);
                } else {
                  setState(() => _showResult = true);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cardBg(isDark),
                foregroundColor: AppColors.textPrimary(isDark),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppColors.borderColor(isDark)),
                ),
              ),
              child: Text(q['options'][index], style: const TextStyle(fontSize: 16)),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildResult(AppStateProvider state, bool isDark) {
    int totalScore = (_score / _questions.length * 10).toInt();
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(LucideIcons.award, size: 80, color: AppColors.success),
          const SizedBox(height: 24),
          Text("Quiz Completed!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
          const SizedBox(height: 12),
          Text("You scored $_score / ${_questions.length}", style: TextStyle(fontSize: 18, color: AppColors.textSecondary(isDark))),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              state.updateScoreAfterQuiz(totalScore);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Collect Points", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
