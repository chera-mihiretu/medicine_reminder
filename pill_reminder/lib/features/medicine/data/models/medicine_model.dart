import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pill_reminder/features/medicine/domain/entities/medicine_entity.dart';

part 'medicine_model.g.dart';

@HiveType(typeId: 0)
class MedicineModel extends MedicineEntity {
  @override
  @HiveField(0)
  // ignore: overridden_fields
  final String medicineId;

  @override
  @HiveField(1)
  // ignore: overridden_fields
  final String name;

  @override
  @HiveField(2)
  // ignore: overridden_fields
  final int interval;

  @override
  @HiveField(3)
  // ignore: overridden_fields
  final List<TimeOfDay> time;

  @override
  @HiveField(4)
  // ignore: overridden_fields
  final DateTime startDate;

  const MedicineModel({
    required this.medicineId,
    required this.name,
    required this.interval,
    required this.time,
    required this.startDate,
  }) : super(
          medicineId: medicineId,
          name: name,
          interval: interval,
          time: time,
          startDate: startDate,
        );

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      medicineId: json['medicineId'],
      name: json['name'],
      interval: json['interval'],
      time: json['time'],
      startDate: DateTime.parse(json['startDate']),
    );
  }

  factory MedicineModel.fromEntity(MedicineEntity entity) {
    return MedicineModel(
      medicineId: entity.medicineId,
      name: entity.name,
      interval: entity.interval,
      time: entity.time,
      startDate: entity.startDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineId': medicineId,
      'name': name,
      'interval': interval,
      'time': time,
      'startDate': startDate.toIso8601String(),
    };
  }

  MedicineEntity toEntity() {
    return MedicineEntity(
      medicineId: medicineId,
      name: name,
      interval: interval,
      time: time,
      startDate: startDate,
    );
  }
}
