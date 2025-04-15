import 'package:pill_reminder/features/medicine/domain/usecases/get_all_medicine_usecase.dart';
import 'package:pill_reminder/features/notification/domain/usecases/show_notification_usecase.dart';

class BackgroundTask {
  final GetAllMedicineUsecase getAllMedicineUsecase;
  final ShowNotificationUsecase showNotificationUsecase;

  BackgroundTask({
    required this.getAllMedicineUsecase,
    required this.showNotificationUsecase,
  });
}
