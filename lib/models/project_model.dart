import 'package:hive/hive.dart';

part 'project_model.g.dart';

// ProjectModel for Hive
@HiveType(typeId: 0) // Unique typeId for Hive storage
class ProjectModel extends HiveObject {
  @HiveField(0)
  final String projectName;

  @HiveField(1)
  final String description;

  ProjectModel({
    required this.projectName,
    required this.description,
  });
}

// OtherProjectModel for Hive
@HiveType(typeId: 1) // Unique typeId for Hive storage
class OtherProjectModel extends HiveObject {
  @HiveField(0)
  final String projectId;

  @HiveField(1)
  final String projectName;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String groupName;

  @HiveField(5)
  final String groupId;

  @HiveField(6)
  final String description;

  @HiveField(7)
  final int memberCount;

  @HiveField(8)
  final int eventCount;

  @HiveField(9)
  final int soccsValue;

  OtherProjectModel({
    required this.projectId,
    required this.projectName,
    required this.type,
    required this.image,
    required this.groupName,
    required this.groupId,
    required this.description,
    required this.memberCount,
    required this.eventCount,
    required this.soccsValue,
  });

  factory OtherProjectModel.fromJson(Map<String, dynamic> json) {
    return OtherProjectModel(
      projectId: json['projectId'] ?? '',
      projectName: json['projectname'] ?? '',
      type: json['type'] ?? '',
      image: json['Image'] ?? '',
      groupName: json['group_name'] ?? '',
      groupId: json['groupid'] ?? '',
      description: json['description'] ?? '',
      memberCount: json['membercount'] ?? 0,
      eventCount: json['event_count'] ?? 0,
      soccsValue: json['soccsvalue'] ?? 0,
    );
  }
}
