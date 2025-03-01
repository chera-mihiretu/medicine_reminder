import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum MyImportance {
  high(Importance.high),
  low(Importance.low);

  final Importance value;
  const MyImportance(this.value);

  Importance get importance {
    switch (this) {
      case MyImportance.high:
        return Importance.high;
      case MyImportance.low:
        return Importance.low;
    }
  }
}

enum MyPriority {
  high(Priority.high),
  low(Priority.low);

  final Priority value;
  const MyPriority(this.value);

  Priority get priority {
    switch (this) {
      case MyPriority.high:
        return Priority.high;
      case MyPriority.low:
        return Priority.low;
    }
  }
}
