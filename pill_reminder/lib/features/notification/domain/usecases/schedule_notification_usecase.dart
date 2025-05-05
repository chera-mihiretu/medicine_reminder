import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/notification/domain/repositories/trigger_notification_repository.dart';

class ScheduleNotificationUsecase {
  TriggerNotificationRepository triggerNotificationRepository;

  ScheduleNotificationUsecase({required this.triggerNotificationRepository});

  Future<Either<Failure, void>> execute() async {
    return await triggerNotificationRepository.scheduleNotification();
  }
}
