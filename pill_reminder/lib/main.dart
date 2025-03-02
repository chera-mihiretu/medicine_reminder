import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/my_theme.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/medicine_list_screen.dart';
import 'package:pill_reminder/splash_screen.dart';

void main() {
  const relaseMode = false;
  runApp(
    DevicePreview(
      enabled: !relaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pill Reminder',
      theme: MyTheme.lightThem,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        MedicineListScreen.routeName: (context) => const MedicineListScreen(),
        // Add other routes here
      },
    );
  }
}
