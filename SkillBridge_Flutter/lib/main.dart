import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'data/providers/app_state_provider.dart';
import 'ui/screens/onboarding/onboarding_screen.dart';
import 'ui/screens/main_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
      ],
      child: const SkillBridgeApp(),
    ),
  );
}

class SkillBridgeApp extends StatelessWidget {
  const SkillBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillBridge',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: Consumer<AppStateProvider>(
        builder: (context, state, _) {
          // If onboarding is not complete, show onboarding screen
          if (!state.user.isOnboardingComplete) {
            return const OnboardingScreen();
          }
          // Otherwise, show the main app with bottom navigation
          return const MainWrapperScreen();
        },
      ),
    );
  }
}
