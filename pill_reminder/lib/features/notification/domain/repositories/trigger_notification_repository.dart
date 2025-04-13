import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';

abstract class TriggerNotificationRepository {
  Future<Either<Failure, bool>> triggerNotification();
  Future<Either<Failure, bool>> triggerNotificationTenMinuteBefore();
}
