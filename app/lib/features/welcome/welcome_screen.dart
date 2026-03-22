import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lumani/app_theme.dart';
import 'package:lumani/features/dashboard/dashboard_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('👋', style: TextStyle(fontSize: 64)),
              const SizedBox(height: 24),
              Text(
                'Welcome, Jane Doe',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Your account has been successfully linked to Dr. Smith\'s clinic.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppTheme.textLight, height: 1.5),
              ),
              const SizedBox(height: 32),
              const Text(
                'Getting your dashboard ready...',
                style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
