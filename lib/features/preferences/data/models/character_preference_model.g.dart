// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_preference_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterPreferenceModelAdapter
    extends TypeAdapter<CharacterPreferenceModel> {
  @override
  final int typeId = 0;

  @override
  CharacterPreferenceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterPreferenceModel(
      apiId: fields[0] as int,
      originalName: fields[1] as String,
      customName: fields[2] as String,
      image: fields[3] as String,
      gender: fields[4] as String,
      status: fields[5] as String,
      species: fields[6] as String,
      origin: fields[7] as String,
      location: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterPreferenceModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.apiId)
      ..writeByte(1)
      ..write(obj.originalName)
      ..writeByte(2)
      ..write(obj.customName)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.species)
      ..writeByte(7)
      ..write(obj.origin)
      ..writeByte(8)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterPreferenceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
