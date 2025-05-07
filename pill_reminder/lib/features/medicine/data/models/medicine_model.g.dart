// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineModelAdapter extends TypeAdapter<MedicineModel> {
  @override
  final int typeId = 1;

  @override
  MedicineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicineModel(
      medicineId: fields[0] as String,
      name: fields[1] as String,
      interval: fields[2] as double?,
      time: (fields[3] as List?)?.cast<TimeOfDay>(),
      startDate: fields[4] as DateTime,
      medicineAmount: fields[5] as int,
      medicineTaken: fields[6] as int,
      lastTriggered: fields[7] as TimeOfDay,
      scheduled: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.medicineId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.interval)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.medicineAmount)
      ..writeByte(6)
      ..write(obj.medicineTaken)
      ..writeByte(7)
      ..write(obj.lastTriggered)
      ..writeByte(8)
      ..write(obj.scheduled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
