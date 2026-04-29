import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/theme_toggle.dart';
import '../../widgets/mentor_card.dart';
import 'career_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        final isDark = state.isDarkMode;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text("Explore"),
            actions: const [ThemeToggle(), SizedBox(width: 16)],
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.primaryBlue,
              labelColor: AppColors.primaryBlue,
              unselectedLabelColor: AppColors.textMuted(isDark),
              tabs: const [
                Tab(text: "Careers"),
                Tab(text: "Mentorship"),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildCareersList(state, isDark),
              _buildMentorsList(isDark),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCareersList(AppStateProvider state, bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: state.recommendedCareers.length,
      itemBuilder: (context, index) {
        final career = state.recommendedCareers[index];
        final match = (60 + (index * 5)) % 100;
        
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
                    Text(career.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary(isDark))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("$match% Match", style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(career.description, style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 14)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMentorsList(bool isDark) {
    final mentors = [
      {"name": "Sarah Chen", "role": "Senior Product Designer", "company": "Google", "match": 92},
      {"name": "David Miller", "role": "Tech Lead", "company": "Meta", "match": 88},
      {"name": "Elena Rodriguez", "role": "Senior Flutter Developer", "company": "Airbnb", "match": 85},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: mentors.length,
      itemBuilder: (context, index) {
        final m = mentors[index];
        return MentorCard(
          name: m["name"] as String,
          role: m["role"] as String,
          company: m["company"] as String,
          matchPercentage: m["match"] as int,
        );
      },
    );
  }
}
