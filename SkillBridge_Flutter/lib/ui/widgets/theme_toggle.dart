import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/providers/app_state_provider.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, state, _) {
        return IconButton(
          onPressed: () => state.toggleTheme(),
          icon: Icon(
            state.isDarkMode ? LucideIcons.sun : LucideIcons.moon,
            size: 20,
          ),
          tooltip: 'Toggle Theme',
        );
      },
    );
  }
}
