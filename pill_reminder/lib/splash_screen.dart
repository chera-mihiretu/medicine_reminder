import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'dart:async';

import 'package:pill_reminder/features/medicine/presentation/pages/medicine_list_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed(MedicineListScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                repeat: false,
                'assets/animations/pill_anim.json',
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 20),
              Text(
                'Pill Reminder',
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: colors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
