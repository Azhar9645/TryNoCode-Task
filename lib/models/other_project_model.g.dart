// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_project_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OtherProjectModelAdapter extends TypeAdapter<OtherProjectModel> {
  @override
  final int typeId = 1;

  @override
  OtherProjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OtherProjectModel(
      name: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OtherProjectModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OtherProjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
