import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pill_reminder/cores/theme/color_data.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/add_medicine_page.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/medicine_detail.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/medicine_list_screen.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/edit_medicine_page.dart';
import 'package:pill_reminder/injection.dart';
import 'package:pill_reminder/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  const relaseMode = false;

  WidgetsFlutterBinding.ensureInitialized();
  //! This is for requesting permission on IOS wich not going to be visible on android mobiles
  // Initialize notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Request iOS permissions
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin
      >()
      ?.requestPermissions(alert: true, badge: true, sound: true);

  await init();
  runApp(
    // DevicePreview(
    //   enabled: !relaseMode,
    //   builder: (context) => const
    MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<ThemeProvider>()),
      ],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => locator<MedicineBloc>())],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pill Reminder',
          builder: (context, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final brightness = MediaQuery.of(context).platformBrightness;
              final themeProvider = Provider.of<ThemeProvider>(
                context,
                listen: false,
              );

              if (brightness == Brightness.dark &&
                  themeProvider.colorMode != ColorMode.DARK) {
                themeProvider.setColorMode(ColorMode.DARK);
              } else if (brightness == Brightness.light &&
                  themeProvider.colorMode != ColorMode.LIGHT) {
                themeProvider.setColorMode(ColorMode.LIGHT);
              }
            });
            return child!;
          },
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            MedicineListScreen.routeName:
                (context) => const MedicineListScreen(),
            AddMedicinePage.router: (context) => AddMedicinePage(),
            MedicineDetail.routeName: (context) => const MedicineDetail(),
            EditMedicinePage.routeName:
                (context) => EditMedicinePage(
                  medicineIndex:
                      ModalRoute.of(context)!.settings.arguments as int,
                ),
            // Add other routes here
          },
        ),
      ),
    );
  }
}
