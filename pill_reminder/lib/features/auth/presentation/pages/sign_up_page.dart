import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pill_reminder/features/auth/presentation/bloc/auth_bloc_events.dart';
import 'package:pill_reminder/features/auth/presentation/bloc/auth_bloc_states.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/home_page.dart';
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
      body: BlocListener<AuthBloc, AuthBlocStates>(
        listener: (context, state) {
          log(state.toString());
          if (state is AuthSignedInState) {
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          }
        },
        child: SafeArea(
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
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(
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
                    BlocBuilder<AuthBloc, AuthBlocStates>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed:
                              state is! AuthLoadingState
                                  ? () async {
                                    context.read<AuthBloc>().add(
                                      const AuthSignInEvent(),
                                    );
                                  }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.card,
                            foregroundColor: colors.text,

                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),

                              side: BorderSide(color: colors.divider, width: 1),
                            ),
                            shadowColor: colors.shadow,
                          ),
                          child: SizedBox(
                            width: size.width * 0.5,
                            child:
                                (state is! AuthLoadingState)
                                    ? Row(
                                      mainAxisSize: MainAxisSize.min,

                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/google.svg',
                                          width: 24,
                                          height: 24,
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          'Sign in with Google',
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                        ),
                                      ],
                                    )
                                    : const Center(child: Text('Loading..')),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
