import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../mock/mock_data.dart';

class AppStateProvider extends ChangeNotifier {
  // Theme state
  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  // Auth state
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  // User state
  UserProfile _user = UserProfile(name: 'Amey');
  UserProfile get user => _user;

  // Career state
  List<Career> _recommendedCareers = [];
  Career? _selectedCareer;
  CareerRoadmap? _activeRoadmap;
  List<ChatMessage> _chatMessages = [];

  // New Upgrade features state
  double _readinessScore = 65.0;
  double get readinessScore => _readinessScore;

  List<Career> get recommendedCareers => _recommendedCareers.isEmpty ? MockData.careers : _recommendedCareers;
  Career? get selectedCareer => _selectedCareer;
  CareerRoadmap? get activeRoadmap => _activeRoadmap;
  List<ChatMessage> get chatMessages => _chatMessages;

  AppStateProvider() {
    _loadTheme();
    _calculateRecommendations();
  }

  // --- Theme Logic ---
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    notifyListeners();
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  // --- Auth Logic ---
  void login(String email, String password) {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  // --- Core Logic ---
  void updateBasicInfo(String name, String branch, String year) {
    _user = _user.copyWith(name: name, branch: branch, year: year);
    notifyListeners();
  }

  void toggleSkill(Skill skill) {
    final List<Skill> currentSkills = List.from(_user.skills);
    if (currentSkills.any((s) => s.id == skill.id)) {
      currentSkills.removeWhere((s) => s.id == skill.id);
    } else {
      currentSkills.add(skill);
    }
    _user = _user.copyWith(skills: currentSkills);
    _calculateReadinessScore();
    _calculateRecommendations();
    notifyListeners();
  }

  void _calculateReadinessScore() {
    // Mock logic: skills + progress
    double score = 40.0;
    score += (_user.skills.length * 5);
    if (_activeRoadmap != null) {
      score += (_activeRoadmap!.overallProgress * 20);
    }
    _readinessScore = score.clamp(0.0, 100.0);
  }

  void updateScoreAfterQuiz(int score) {
    _readinessScore = (_readinessScore + score).clamp(0.0, 100.0);
    notifyListeners();
  }

  void toggleInterest(String interest) {
    final List<String> currentInterests = List.from(_user.interests);
    if (currentInterests.contains(interest)) {
      currentInterests.remove(interest);
    } else {
      currentInterests.add(interest);
    }
    _user = _user.copyWith(interests: currentInterests);
    notifyListeners();
  }

  void completeOnboarding() {
    _user = _user.copyWith(isOnboardingComplete: true);
    notifyListeners();
  }

  void _calculateRecommendations() {
    // Simple logic: matches by skill count
    final List<MapEntry<Career, int>> scores = [];
    for (final career in MockData.careers) {
      int match = 0;
      for (final reqSkill in career.requiredSkills) {
        if (_user.skills.any((s) => s.name.toLowerCase() == reqSkill.toLowerCase())) {
          match++;
        }
      }
      scores.add(MapEntry(career, match));
    }
    scores.sort((a, b) => b.value.compareTo(a.value));
    _recommendedCareers = scores.map((e) => e.key).toList();
  }

  void selectCareer(Career career) {
    _selectedCareer = career;
    notifyListeners();
  }

  void generateRoadmap(Career career) {
    _activeRoadmap = MockData.getMockRoadmap(career.id, career.title);
    notifyListeners();
  }

  void toggleTask(String monthId, String taskId) {
    if (_activeRoadmap == null) return;
    for (var month in _activeRoadmap!.months) {
      for (var task in month.tasks) {
        if (task.id == taskId) {
          task.isCompleted = !task.isCompleted;
          break;
        }
      }
    }
    _calculateReadinessScore();
    notifyListeners();
  }

  void sendMessage(String text) {
    _chatMessages.add(ChatMessage(text: text, isUser: true));
    notifyListeners();
    Future.delayed(const Duration(seconds: 1), () {
      _chatMessages.add(ChatMessage(text: "That's a great question! Based on your profile, I recommend focusing on Data Structures first.", isUser: false));
      notifyListeners();
    });
  }
}
