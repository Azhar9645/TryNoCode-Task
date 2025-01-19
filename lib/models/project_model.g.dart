// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectModelAdapter extends TypeAdapter<ProjectModel> {
  @override
  final int typeId = 0;

  @override
  ProjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectModel(
      projectName: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProjectModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.projectName)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      projectId: fields[0] as String,
      projectName: fields[1] as String,
      type: fields[2] as String,
      image: fields[3] as String,
      groupName: fields[4] as String,
      groupId: fields[5] as String,
      description: fields[6] as String,
      memberCount: fields[7] as int,
      eventCount: fields[8] as int,
      soccsValue: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OtherProjectModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.projectId)
      ..writeByte(1)
      ..write(obj.projectName)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.groupName)
      ..writeByte(5)
      ..write(obj.groupId)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.memberCount)
      ..writeByte(8)
      ..write(obj.eventCount)
      ..writeByte(9)
      ..write(obj.soccsValue);
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
