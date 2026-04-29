import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'home/home_screen.dart';
import 'explore/explore_screen.dart';
import 'roadmap/roadmap_screen.dart';
import 'progress/progress_screen.dart';
import 'profile/profile_screen.dart';
import 'opportunities/opportunities_screen.dart';

class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({Key? key}) : super(key: key);

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const RoadmapScreen(),
    const OpportunitiesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.compass), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.map), label: 'Roadmap'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.briefcase), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Profile'),
        ],
      ),
    );
  }
}
