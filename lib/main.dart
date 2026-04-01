import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/app_colors.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/dashboard_viewmodel.dart';
import 'viewmodels/leave_viewmodel.dart';
import 'viewmodels/route_viewmodel.dart';
import 'views/splash/splash_view.dart';

void main() {
  runApp(const MedizyApp());
}

class MedizyApp extends StatelessWidget {
  const MedizyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => RouteViewModel()),
        ChangeNotifierProvider(create: (_) => LeaveViewModel()),
      ],
      child: MaterialApp(
        title: 'Medizy Check',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primaryDark,
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'Inter', // Or any other modern font
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.background,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            titleTextStyle: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.primaryDark,
            secondary: AppColors.primaryLight,
          ),
        ),
        home: const SplashView(),
      ),
    );
  }
}
