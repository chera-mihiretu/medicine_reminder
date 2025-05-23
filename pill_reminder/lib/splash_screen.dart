import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/auth/domain/usecases/auth_state_usecase.dart';
import 'package:pill_reminder/features/auth/presentation/pages/sign_up_page.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/home_page.dart';
import 'package:pill_reminder/injection.dart';
import 'dart:async';

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

    Timer(const Duration(seconds: 4), () async {
      final result = await locator<AuthStateUsecase>().call();

      result.fold(
        (failure) {
          Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
        },
        (user) {
          if (user == null) {
            Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
          } else {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          }
        },
      );
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
