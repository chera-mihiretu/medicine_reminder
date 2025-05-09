import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class LoadingPopup extends StatelessWidget {
  const LoadingPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(color: colors.shadow, spreadRadius: 1, blurRadius: 1),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitPulse(color: colors.primaryButton, size: 50),
              const SizedBox(height: 10),
              Text('Loading...', style: TextStyle(color: colors.text)),
            ],
          ),
        ),
      ),
    );
  }
}
