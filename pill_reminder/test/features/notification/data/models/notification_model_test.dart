import 'package:flutter_test/flutter_test.dart';
import 'package:pill_reminder/features/notification/data/models/notification_model.dart';
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';

import '../../../../test_data/notification_test_data.dart';

void main() {
  final tNotificationModel = NotificationTestData.notificationModel;
  final tNotificationEntity = NotificationTestData.notificationEntity;

  group('Notification model should work properly', () {
    test('should be a subclass of NotificationEntity', () {
      expect(tNotificationModel, isA<NotificationEntity>());
    });

    test('should return a valid model from entity', () {
      final result = NotificationModel.fromEntity(tNotificationEntity);
      expect(result, tNotificationModel);
    });

    test('should return a valid entity from model', () {
      final result = tNotificationModel.toEntity();
      expect(result, tNotificationEntity);
    });

    test('should have correct properties', () {
      expect(tNotificationModel.id, tNotificationEntity.id);
      expect(tNotificationModel.title, tNotificationEntity.title);
      expect(tNotificationModel.body, tNotificationEntity.body);
      expect(tNotificationModel.channelName, tNotificationEntity.channelName);
    });
  });
}
