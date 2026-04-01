import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryDark = Color(0xFF042222);
  static const Color primaryLight = Color(0xFF03624C);
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDark, primaryLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color background = Color(0xFFF8F9FA); // Assuming a light gray bg
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF757575);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFFBC02D);
  static const Color white = Colors.white;
}
