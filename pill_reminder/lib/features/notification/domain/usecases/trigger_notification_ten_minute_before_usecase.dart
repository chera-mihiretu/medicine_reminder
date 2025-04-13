import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/notification/domain/repositories/trigger_notification_repository.dart';

class TriggerNotificationTenMinuteBeforeUsecase {
  TriggerNotificationRepository triggerNotificationRepository;

  TriggerNotificationTenMinuteBeforeUsecase(
      {required this.triggerNotificationRepository});

  Future<Either<Failure, bool>> execute() async {
    return await triggerNotificationRepository
        .triggerNotificationTenMinuteBefore();
  }
}
