import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/notification/domain/entities/notification_entity.dart';
import 'package:pill_reminder/features/notification/domain/repositories/notification_repository.dart';

class ShowNotificationUsecase {
  final NotificationRepository notificationRepository;

  ShowNotificationUsecase(this.notificationRepository);

  Future<Either<Failure, bool>> execute(NotificationEntity notification) async {
    return await notificationRepository.showNotification(notification);
  }
}
