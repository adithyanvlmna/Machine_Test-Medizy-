import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onTap;
  final bool isPrimary;

  const DashboardCard({
    super.key,
    required this.title,
    required this.iconData,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isPrimary ? null : AppColors.white,
          gradient: isPrimary ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isPrimary ? Colors.white.withOpacity(0.2) : AppColors.primaryDark,
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: AppColors.white,
                size: 24,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color: isPrimary ? AppColors.white : AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
