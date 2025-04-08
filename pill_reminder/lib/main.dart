import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/cores/theme/my_theme.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/add_medicine_page.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/medicine_list_screen.dart';
import 'package:pill_reminder/injection.dart';
import 'package:pill_reminder/splash_screen.dart';

void main() async {
  const relaseMode = false;
  WidgetsFlutterBinding().ensureSemantics();

  // setWorkManager();
  await init();
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
    return BlocProvider(
      create: (_) =>
          locator<MedicineBloc>(), // Replace MyBloc with your actual bloc class
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pill Reminder',
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          MedicineListScreen.routeName: (context) => const MedicineListScreen(),
          AddMedicinePage.router: (context) => const AddMedicinePage(),
          // Add other routes here
        },
      ),
    );
  }
}
