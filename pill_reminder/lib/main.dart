import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pill_reminder/cores/theme/color_data.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pill_reminder/features/auth/presentation/pages/sign_up_page.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/add_medicine_page.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/medicine_detail.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/home_page.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/edit_medicine_page.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/medicine_taken.dart';
import 'package:pill_reminder/features/notification/domain/usecases/schedule_notification_usecase.dart';
import 'package:pill_reminder/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:pill_reminder/injection.dart';
import 'package:pill_reminder/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  // const relaseMode = false;

  WidgetsFlutterBinding.ensureInitialized();
  //! This is for requesting permission on IOS wich not going to be visible on android mobiles
  // Initialize notification
  await init();

  // Handle notification when app is launched from terminated state
  final notificationAppLaunchDetails =
      await locator<FlutterLocalNotificationsPlugin>()
          .getNotificationAppLaunchDetails();

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    notificationActionHandler(
      notificationAppLaunchDetails!.notificationResponse!,
    );
  }
  await Firebase.initializeApp();
  locator<ScheduleNotificationUsecase>().execute();

  runApp(
    // DevicePreview(
    //   enabled: !relaseMode,
    //   builder: (context) => const
    MyApp(navState: locator<GlobalKey<NavigatorState>>()),
    // ),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navState;
  const MyApp({super.key, required this.navState});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<ThemeProvider>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => locator<MedicineBloc>()),
          BlocProvider(create: (context) => locator<NotificationBloc>()),
          BlocProvider(create: (context) => locator<AuthBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pill Reminder',
          navigatorKey: navState,
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
            SignUpPage.routeName: (context) => const SignUpPage(),
            HomePage.routeName: (context) => const HomePage(),
            AddMedicinePage.router: (context) => AddMedicinePage(),
            MedicineDetail.routeName: (context) => const MedicineDetail(),
            EditMedicinePage.routeName:
                (context) => EditMedicinePage(
                  medicineIndex:
                      ModalRoute.of(context)!.settings.arguments as int,
                ),
            MedicineTaken.routeName: (context) => const MedicineTaken(),
            // Add other routes here
          },
        ),
      ),
    );
  }
}
