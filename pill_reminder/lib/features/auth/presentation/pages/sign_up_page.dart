import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  static final String routeName = '/sign-up';
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Icon
                  Container(
                    width: size.width * 0.4,
                    height: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: colors.primaryButton.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.medical_services_rounded,
                      size: size.width * 0.2,
                      color: colors.primaryButton,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // App Title
                  Text(
                    'Pill Reminder',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.text,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Never miss your medication',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colors.text.withAlpha(150),
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Google Sign In Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle Google sign in
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.card,
                      foregroundColor: colors.text,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),

                        side: BorderSide(color: colors.divider, width: 1),
                      ),
                      shadowColor: colors.shadow,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/images/google.svg'),
                        const SizedBox(width: 12),
                        Text(
                          'Sign in with Google',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
