// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SafeBoxModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SafeBoxModelAdapter extends TypeAdapter<SafeBoxModel> {
  @override
  final int typeId = 0;

  @override
  SafeBoxModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SafeBoxModel(
      userName: fields[9] as String,
      password: fields[8] as String,
      createdDateTime: fields[11] as String,
      modifiedDateTime: fields[12] as String,
      hashKey: fields[0] as String,
      rangeKey: fields[1] as String,
      gsiHk1: fields[2] as String,
      gsiHk2: fields[3] as String,
      gsiRk1: fields[4] as String,
      gsiRk2: fields[5] as String,
      id: fields[13] as String,
    )
      ..location = fields[6] as String?
      ..name = fields[7] as String?
      ..website = fields[10] as String?
      ..note = fields[14] as String?;
  }

  @override
  void write(BinaryWriter writer, SafeBoxModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.hashKey)
      ..writeByte(1)
      ..write(obj.rangeKey)
      ..writeByte(2)
      ..write(obj.gsiHk1)
      ..writeByte(3)
      ..write(obj.gsiHk2)
      ..writeByte(4)
      ..write(obj.gsiRk1)
      ..writeByte(5)
      ..write(obj.gsiRk2)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.name)
      ..writeByte(8)
      ..write(obj.password)
      ..writeByte(9)
      ..write(obj.userName)
      ..writeByte(10)
      ..write(obj.website)
      ..writeByte(11)
      ..write(obj.createdDateTime)
      ..writeByte(12)
      ..write(obj.modifiedDateTime)
      ..writeByte(13)
      ..write(obj.id)
      ..writeByte(14)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SafeBoxModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
