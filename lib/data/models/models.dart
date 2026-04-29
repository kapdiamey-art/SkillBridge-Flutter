import 'package:flutter/material.dart';

class Skill {
  final String id;
  final String name;
  final String category;

  Skill({required this.id, required this.name, this.category = 'General'});
}

class UserProfile {
  String name;
  String branch;
  String year;
  List<Skill> skills;
  List<String> interests;
  bool isOnboardingComplete;

  UserProfile({
    this.name = '',
    this.branch = '',
    this.year = '',
    this.skills = const [],
    this.interests = const [],
    this.isOnboardingComplete = false,
  });

  UserProfile copyWith({
    String? name,
    String? branch,
    String? year,
    List<Skill>? skills,
    List<String>? interests,
    bool? isOnboardingComplete,
  }) {
    return UserProfile(
      name: name ?? this.name,
      branch: branch ?? this.branch,
      year: year ?? this.year,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
    );
  }
}

enum JobDemand { high, medium, low }

class Mentor {
  final String id;
  final String name;
  final String role;
  final String company;
  final String avatarUrl;

  Mentor({
    required this.id,
    required this.name,
    required this.role,
    required this.company,
    required this.avatarUrl,
  });
}

class Career {
  final String id;
  final String title;
  final String description;
  final List<String> requiredSkills;
  final JobDemand demand;
  final String salaryRange;
  final String growthTrend;
  final String whyThisCareer;
  final List<Mentor> mentors;
  final String dayInLife;

  Career({
    required this.id,
    required this.title,
    required this.description,
    required this.requiredSkills,
    required this.demand,
    required this.salaryRange,
    required this.growthTrend,
    required this.whyThisCareer,
    required this.mentors,
    required this.dayInLife,
  });
}

class RoadmapTask {
  final String id;
  final String title;
  final String resourceUrl;
  bool isCompleted;

  RoadmapTask({
    required this.id,
    required this.title,
    this.resourceUrl = '',
    this.isCompleted = false,
  });
}

class RoadmapMonth {
  final int month;
  final List<RoadmapTask> tasks;

  RoadmapMonth({required this.month, required this.tasks});

  double get progress {
    if (tasks.isEmpty) return 0.0;
    return tasks.where((t) => t.isCompleted).length / tasks.length;
  }
}

class CareerRoadmap {
  final String careerId;
  final String careerTitle;
  final List<RoadmapMonth> months;

  CareerRoadmap({
    required this.careerId,
    required this.careerTitle,
    required this.months,
  });

  double get overallProgress {
    if (months.isEmpty) return 0.0;
    final totalTasks = months.fold(0, (sum, m) => sum + m.tasks.length);
    final completedTasks = months.fold(0, (sum, m) => sum + m.tasks.where((t) => t.isCompleted).length);
    return totalTasks == 0 ? 0.0 : completedTasks / totalTasks;
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
