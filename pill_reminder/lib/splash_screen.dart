import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

import 'package:pill_reminder/features/medicine/presentation/pages/medicine_list_screen.dart';

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
    Timer(const Duration(milliseconds: 6000), () {
      Navigator.of(context).pushReplacementNamed(MedicineListScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              repeat: false,
              'assets/animations/pill_anim.json',
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            Text('Pill Reminder',
                style: Theme.of(context).textTheme.displayLarge),
          ],
        ),
      ),
    );
  }
}
