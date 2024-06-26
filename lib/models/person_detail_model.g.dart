// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonDetailModelAdapter extends TypeAdapter<PersonDetailModel> {
  @override
  final int typeId = 1;

  @override
  PersonDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonDetailModel(
      name: fields[0] as String,
      age: fields[1] as int,
      gender: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonDetailModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
