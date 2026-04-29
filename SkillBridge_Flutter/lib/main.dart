import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'data/providers/app_state_provider.dart';
import 'ui/screens/main_wrapper.dart';
import 'ui/screens/auth/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
      ],
      child: const CareerCompassApp(),
    ),
  );
}

class CareerCompassApp extends StatelessWidget {
  const CareerCompassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        return MaterialApp(
          title: 'Career Compass',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme(false),
          darkTheme: AppTheme.theme(true),
          themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: state.isLoggedIn ? const MainWrapperScreen() : const LoginScreen(),
        );
      },
    );
  }
}
