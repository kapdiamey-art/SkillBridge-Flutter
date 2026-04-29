import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/providers/app_state_provider.dart';
import '../../widgets/gradient_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Account",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary(isDark),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Join Career Compass and start your journey",
              style: TextStyle(color: AppColors.textSecondary(isDark), fontSize: 16),
            ),
            const SizedBox(height: 40),
            _buildTextField("Full Name", Icons.person_outline, _nameController, isDark),
            const SizedBox(height: 20),
            _buildTextField("Email", Icons.email_outlined, _emailController, isDark),
            const SizedBox(height: 20),
            _buildTextField("Password", Icons.lock_outline, _passwordController, isDark, isPassword: true),
            const SizedBox(height: 40),
            GradientButton(
              text: "Register",
              onPressed: () {
                context.read<AppStateProvider>().login(_emailController.text, _passwordController.text);
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ", style: TextStyle(color: AppColors.textSecondary(isDark))),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text("Login", style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, TextEditingController controller, bool isDark, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg(isDark),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor(isDark)),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(color: AppColors.textPrimary(isDark)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textMuted(isDark)),
          prefixIcon: Icon(icon, color: AppColors.primaryBlue),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(18),
        ),
      ),
    );
  }
}
