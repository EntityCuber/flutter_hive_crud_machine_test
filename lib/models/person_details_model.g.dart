// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonDetailsModelAdapter extends TypeAdapter<PersonDetailsModel> {
  @override
  final int typeId = 1;

  @override
  PersonDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonDetailsModel(
      name: fields[0] as String,
      age: fields[1] as int,
      sex: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonDetailsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.sex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
