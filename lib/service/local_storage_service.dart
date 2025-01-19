import 'package:hive/hive.dart';
import 'package:trynocode_assignment/models/project.dart';

class LocalStorage {
  static const String boxName = 'projectsBox';

  // Store Projects to Hive
  Future<void> storeProjects(List<ProjectModel> projects) async {
    var box = await Hive.openBox(boxName);
    List<Map<String, dynamic>> projectList = projects.map((project) => project.toJson()).toList();
    await box.put('projects', projectList);
  }

  // Retrieve Projects from Hive
  Future<List<ProjectModel>> loadProjects() async {
    var box = await Hive.openBox(boxName);
    List<dynamic> data = box.get('projects', defaultValue: []);
    return data.map((e) => ProjectModel.fromJson(e)).toList();
  }
}
