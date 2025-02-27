import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MedicineEntity extends Equatable {
  @override
  List<Object> get props => [medicineId, name, interval, time, startDate];
  final String medicineId;
  final String name;
  final int interval;
  final List<TimeOfDay> time;
  final DateTime startDate;

  const MedicineEntity({
    required this.medicineId,
    required this.name,
    required this.interval,
    required this.time,
    required this.startDate,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MedicineEntity &&
        other.medicineId == medicineId &&
        other.name == name &&
        other.interval == interval &&
        other.time == time &&
        other.startDate == startDate;
  }

  @override
  int get hashCode =>
      medicineId.hashCode ^
      name.hashCode ^
      interval.hashCode ^
      time.hashCode ^
      startDate.hashCode;
}
