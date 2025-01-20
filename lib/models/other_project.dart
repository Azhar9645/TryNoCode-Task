class OtherProjectModel {
  final String projectId;
  final String projectName;
  final String type;
  final String image;
  final String groupName;
  final String groupId;
  final String description;
  final int memberCount;
  final int eventCount;
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

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectname': projectName,
      'type': type,
      'Image': image,
      'group_name': groupName,
      'groupid': groupId,
      'description': description,
      'membercount': memberCount,
      'event_count': eventCount,
      'soccsvalue': soccsValue,
    };
  }
}