import 'package:flutter/material.dart';
import '../models/models.dart';
import '../mock/mock_data.dart';

class AppStateProvider extends ChangeNotifier {
  UserProfile _user = UserProfile();
  List<Career> _recommendedCareers = [];
  Career? _selectedCareer;
  CareerRoadmap? _activeRoadmap;
  List<ChatMessage> _chatMessages = [
    ChatMessage(text: "Hello! I'm your AI career counsellor. How can I help you today?", isUser: false),
  ];

  UserProfile get user => _user;
  List<Career> get recommendedCareers => _recommendedCareers;
  Career? get selectedCareer => _selectedCareer;
  CareerRoadmap? get activeRoadmap => _activeRoadmap;
  List<ChatMessage> get chatMessages => _chatMessages;

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
    _calculateRecommendations();
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
    _calculateRecommendations();
    notifyListeners();
  }

  void _calculateRecommendations() {
    // Simple matching logic: count overlapping skills
    final List<MapEntry<Career, double>> scores = [];

    for (final career in MockData.careers) {
      int matchCount = 0;
      for (final reqSkill in career.requiredSkills) {
        if (_user.skills.any((s) => s.name.toLowerCase() == reqSkill.toLowerCase())) {
          matchCount++;
        }
      }
      double score = (matchCount / career.requiredSkills.length) * 100;
      // Bonus score if user interests match career title or description
      for (final interest in _user.interests) {
        if (career.title.toLowerCase().contains(interest.toLowerCase()) || 
            career.description.toLowerCase().contains(interest.toLowerCase())) {
          score += 10;
        }
      }
      scores.add(MapEntry(career, score.clamp(0.0, 100.0)));
    }

    scores.sort((a, b) => b.value.compareTo(a.value));
    _recommendedCareers = scores.map((e) => e.key).toList();
  }

  double getMatchPercentage(Career career) {
    int matchCount = 0;
    for (final reqSkill in career.requiredSkills) {
      if (_user.skills.any((s) => s.name.toLowerCase() == reqSkill.toLowerCase())) {
        matchCount++;
      }
    }
    double score = (matchCount / career.requiredSkills.length) * 100;
    for (final interest in _user.interests) {
      if (career.title.toLowerCase().contains(interest.toLowerCase()) || 
          career.description.toLowerCase().contains(interest.toLowerCase())) {
        score += 10;
      }
    }
    return score.clamp(0.0, 100.0);
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
    notifyListeners();
  }

  void sendMessage(String text) {
    _chatMessages.add(ChatMessage(text: text, isUser: true));
    notifyListeners();

    // Mock AI response delay
    Future.delayed(const Duration(seconds: 1), () {
      String response = "That's a great question about ${text.toLowerCase()}. ";
      if (text.toLowerCase().contains('career') || text.toLowerCase().contains('job')) {
        response += "Based on your current skills in ${_user.skills.map((s) => s.name).join(', ')}, you might want to look into ${MockData.careers[0].title}.";
      } else if (text.toLowerCase().contains('skill')) {
        response += "I recommend checking out the roadmap for ${MockData.careers[1].title} to see which skills you should prioritize next.";
      } else {
        response += "I'm here to help you navigate your career path. Would you like to see your top matches or analyze a skill gap?";
      }
      
      _chatMessages.add(ChatMessage(text: response, isUser: false));
      notifyListeners();
    });
  }
}
