import 'package:hive/hive.dart';

part 'project_model.g.dart';

@HiveType(typeId: 0)
class ProjectModel {
  @HiveField(0)
  final String projectName;

  @HiveField(1)
  final String description;

  ProjectModel({
    required this.projectName,
    required this.description,
  });
}

@HiveType(typeId: 1)
class OtherProjectModel {
  @HiveField(0)
  final String projectName;

  @HiveField(1)
  final String description;

  OtherProjectModel({
    required this.projectName,
    required this.description,
  });
}
