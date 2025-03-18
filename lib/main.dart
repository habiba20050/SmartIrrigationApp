import 'package:flutter/material.dart';
import 'farmer_details.dart' as farmer;
import 'home_page.dart' as home;
import 'login_page.dart';
import 'onboarding_page.dart';
import 'register_page.dart';
import 'settings_page.dart';
import 'notifications_page.dart';
import 'irriga_schedule_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Irrigation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.lightGreen[50],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingPage(),
        '/login': (context) => const LoginPage(),
        '/farmer_details': (context) => const farmer.FarmerDetailsPage(), // Specify the correct import
        '/home': (context) => const home.HomePage(),
        '/register_page': (context) => const RegisterPage(),
        '/schedule': (context) => const IrrigaSchedulePage(),
        '/settings': (context) => const SettingsPage(),
        '/notifications': (context) => const NotificationsPage(),
      },
    );
  }
}
