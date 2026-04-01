import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/primary_button.dart';
import '../dashboard/dashboard_view.dart';
import 'create_account_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLogin() async {
    final authViewModel = context.read<AuthViewModel>();
    final success = await authViewModel.login(
      _usernameController.text,
      _passwordController.text,
    );
    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthViewModel>().isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              // Dummy Logo replacement
              Image.asset("assets/images/Group 268.png"),
              const SizedBox(height: 60),
              CustomTextField(
                hintText: 'Mobile Number',
                controller: _usernameController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'Password',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 40),
              if (isLoading)
                const CircularProgressIndicator()
              else ...[
                PrimaryButton(
                  text: 'Login',
                  onPressed: _onLogin,
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: 'Create Account',
                  isOutline: true,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateAccountView(),
                      ),
                    );
                  },
                ),
              ],
              const SizedBox(height: 60),
              const Text(
                'Powered by Mediezy',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
