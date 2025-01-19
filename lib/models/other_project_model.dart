import 'package:hive/hive.dart';

part 'other_project_model.g.dart'; // This will be the generated file

@HiveType(typeId: 1) // Make sure the typeId is unique
class OtherProjectModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String description;

  OtherProjectModel({
    required this.name,
    required this.description,
  });
}
