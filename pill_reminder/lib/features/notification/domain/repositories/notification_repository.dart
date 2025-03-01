import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<Failure, bool>> showNotification(
      NotificationEntity notification);
}
