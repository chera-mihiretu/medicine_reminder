import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class MedicineEvent extends Equatable {
  const MedicineEvent();

  @override
  List<Object> get props => [];
}

class GetMedicineListEvent extends MedicineEvent {}

class AddMedicineEvent extends MedicineEvent {
  final String name;
  final int interval;
  final List<TimeOfDay> time;
  final DateTime startDate;
  final int medicineAmount;
  final int medicineTaken;
  final TimeOfDay lastTriggered;

  const AddMedicineEvent({
    required this.name,
    required this.interval,
    required this.time,
    required this.startDate,
    required this.medicineAmount,
    required this.medicineTaken,
    required this.lastTriggered,
  });

  @override
  List<Object> get props => [
        name,
        interval,
        time,
        startDate,
        medicineAmount,
        medicineTaken,
        lastTriggered
      ];
}

class GetMedicineEvent extends MedicineEvent {
  final String medicineId;

  const GetMedicineEvent({
    required this.medicineId,
  });

  @override
  List<Object> get props => [medicineId];
}

class UpdataeMedicineEvent extends MedicineEvent {
  final String medicineId;
  final String name;
  final int interval;
  final List<TimeOfDay> time;
  final DateTime startDate;
  final int medicineAmount;
  final int medicineTaken;
  final TimeOfDay lastTriggered;

  const UpdataeMedicineEvent(
      {required this.medicineId,
      required this.name,
      required this.interval,
      required this.time,
      required this.startDate,
      required this.medicineAmount,
      required this.medicineTaken,
      required this.lastTriggered});

  @override
  List<Object> get props => [
        medicineId,
        name,
        interval,
        time,
        startDate,
        medicineAmount,
        medicineTaken,
        lastTriggered
      ];
}

class DeleteMedicineEvent extends MedicineEvent {
  final String medicineId;

  const DeleteMedicineEvent({
    required this.medicineId,
  });

  @override
  List<Object> get props => [medicineId];
}
