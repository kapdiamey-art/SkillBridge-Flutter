import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'home/home_screen.dart';
import 'explore/explore_screen.dart';
import 'roadmap/roadmap_screen.dart';
import 'progress/progress_screen.dart';
import 'ai_chat/ai_chat_screen.dart';
import '../../core/theme/app_colors.dart';

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
    const ProgressScreen(),
    const AIChatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.white.withOpacity(0.05),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.search), label: 'Explore'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.map), label: 'Roadmap'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.barChart3), label: 'Progress'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.messageSquare), label: 'AI Chat'),
          ],
        ),
      ),
    );
  }
}
