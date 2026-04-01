import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/auth_repository.dart';
import '../../utils/app_colors.dart';
import '../auth/login_view.dart';
import '../dashboard/dashboard_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  final AuthRepository _authRepo = AuthRepository();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
       vsync: this, 
       duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    _animController.forward();

    _navigateAfterSplash();
  }

  void _navigateAfterSplash() async {
    // Wait for the animation to finish + a little delay
    await Future.delayed(const Duration(milliseconds: 2500));
    
    final isLoggedIn = await _authRepo.isLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardView()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginView()),
      );
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/Group 268.png"),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
