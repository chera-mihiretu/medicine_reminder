import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pill_reminder/features/auth/presentation/bloc/auth_bloc_events.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_bloc.dart';
import 'package:pill_reminder/features/medicine/presentation/bloc/medicine_event.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/account_page.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/add_medicine_page.dart';
import 'package:pill_reminder/features/medicine/presentation/pages/medicine_list_page.dart';
import 'package:pill_reminder/permissions.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/medicine-list';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final List<Widget> pages = [const MedicineListPage(), const AccountPage()];
  final List<String> titles = ['Medicine List', 'Profile'];
  void setTabIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MyPermissions.requestNotificationPermissionFirstTime(context);
    BlocProvider.of<MedicineBloc>(context).add(GetMedicineListEvent());
    final colors = Provider.of<ThemeProvider>(context).colors;
    BlocProvider.of<AuthBloc>(context).add(const AuthCheckEvent());
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colors.background,
        title: Text(
          titles[selectedIndex],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: colors.text,
            letterSpacing: 0.5,
          ),
        ),
      ),
      floatingActionButton:
          (selectedIndex == 0)
              ? Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: colors.buttonShadow,
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AddMedicinePage.router);
                  },
                  backgroundColor: colors.primaryButton,
                  shape: const CircleBorder(),
                  child: Icon(Icons.add, color: colors.primaryIcon, size: 28),
                ),
              )
              : null,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: setTabIndex,
        backgroundColor: colors.background,
        selectedItemColor: colors.primaryButton,
        unselectedItemColor: colors.text,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
