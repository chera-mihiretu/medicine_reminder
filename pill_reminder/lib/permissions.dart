import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';

class MyPermissions {
  static Future<void> requestNotificationPermissionFirstTime(
    BuildContext context,
  ) async {
    PermissionStatus status = await Permission.notification.request();
    log(status.toString());
    while (status.isDenied) {
      status = await Permission.notification.request();
    }

    if (status.isPermanentlyDenied) {
      // ignore: use_build_context_synchronously
      log('Permanently denied');
      await requestNotificationPermission(context);
    }
  }

  static Future<void> requestNotificationPermission(
    BuildContext context,
  ) async {
    final result = await Permission.notification.request();
    if (result.isPermanentlyDenied) {
      log('Permanently denied, in dialog');
      if (context.mounted) {
        log('Showing dialog');
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Permission Required'),
                content: const Text(
                  'This app needs notification permission to remind you about your medicines. Without this permission, the app will not be able to function properly.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      AppSettings.openAppSettings();
                    },
                    child: const Text('Open Settings'),
                  ),
                ],
              ),
        );
      } else {
        log('Context is moinetd');
      }
    }
  }
}
