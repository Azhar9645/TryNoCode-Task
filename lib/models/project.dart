class ProjectModel {
  final String projectId;
  final String projectName;
  final String type;
  final String image;
  final String groupName;
  final String description;
  final int memberCount;
  final int eventCount;
  final int soccsValue;

  ProjectModel({
    required this.projectId,
    required this.projectName,
    required this.type,
    required this.image,
    required this.groupName,
    required this.description,
    required this.memberCount,
    required this.eventCount,
    required this.soccsValue,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectId: json['projectId'] ?? '',
      projectName: json['projectname'] ?? '',
      type: json['type'] ?? '',
      image: json['Image'] ?? '',
      groupName: json['group_name'] ?? '',
      description: json['description'] ?? '',
      memberCount: json['membercount'] ?? 0,
      eventCount: json['event_count'] ?? 0,
      soccsValue: json['soccsvalue'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectname': projectName,
      'type': type,
      'Image': image,
      'group_name': groupName,
      'membercount': memberCount,
      'event_count': eventCount,
      'soccsvalue': soccsValue,
    };
  }
}
