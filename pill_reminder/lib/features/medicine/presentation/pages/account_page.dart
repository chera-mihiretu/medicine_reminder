import 'package:flutter/material.dart';
import 'package:pill_reminder/cores/theme/theme_provider.dart';
import 'package:pill_reminder/features/medicine/presentation/widgets/cloud_sync_switch.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Provider.of<ThemeProvider>(context).colors;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colors.background,

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: colors.background,
        title: Text(
          'Account',
          style: TextStyle(
            color: colors.text,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile Section
              Column(
                children: [
                  // Avatar
                  Container(
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.primaryButton.withAlpha(30),
                    ),
                    child: Icon(
                      Icons.person,
                      size: size.width * 0.15,
                      color: colors.primaryButton,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Name
                  Text(
                    'Lucky Me', // Replace with actual user name
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors.text,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'luckyme@gmail.com', // Replace with actual email
                    style: TextStyle(color: colors.text.withAlpha(100)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Settings Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colors.card,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: colors.shadow,
                      blurRadius: 2,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Cloud Sync Toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.cloud_sync,
                              color: colors.primaryButton,
                              size: 18,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              'Cloud Sync',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: colors.text,
                              ),
                            ),
                          ],
                        ),
                        CloudSyncSwitch(
                          initialValue: true,
                          onChanged: (value) {
                            // Handle sync toggle
                          },
                        ),
                      ],
                    ),
                    // Logout Button
                    GestureDetector(
                      onTap: () {
                        // Handle logout
                        showDialog(
                          context: context,

                          builder:
                              (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: colors.card,
                                icon: Icon(Icons.warning, color: colors.error),
                                title: Text(
                                  'Logout',
                                  style: TextStyle(color: colors.text),
                                ),
                                content: Text(
                                  'Are you sure you want to logout?',
                                  style: TextStyle(color: colors.text),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: colors.text),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Handle logout logic
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Logout',
                                      style: TextStyle(color: colors.error),
                                    ),
                                  ),
                                ],
                              ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: colors.error, size: 18),
                          const SizedBox(width: 15),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: colors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
