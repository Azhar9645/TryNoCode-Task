import 'package:hive/hive.dart';
import 'package:trynocode_assignment/models/other_project.dart';
import 'package:trynocode_assignment/models/project.dart';

class LocalStorage {
  static const String myProjectsKey = 'myProjects';
  static const String otherProjectsKey = 'otherProjects';

  final Box box;

  LocalStorage(this.box);

  Future<void> saveMyProjects(List<ProjectModel> projects) async {
    try {
      await box.put(myProjectsKey, projects);
    } catch (e) {
      throw LocalStorageException('Failed to save my projects: $e');
    }
  }

  Future<void> saveOtherProjects(List<OtherProjectModel> projects) async {
    try {
      await box.put(otherProjectsKey, projects);
    } catch (e) {
      throw LocalStorageException('Failed to save other projects: $e');
    }
  }

  List<ProjectModel> getMyProjects() {
    try {
      return (box.get(myProjectsKey, defaultValue: <ProjectModel>[]) as List)
          .cast<ProjectModel>();
    } catch (e) {
      throw LocalStorageException('Failed to load my projects: $e');
    }
  }

  List<OtherProjectModel> getOtherProjects() {
    try {
      return (box.get(otherProjectsKey, defaultValue: <OtherProjectModel>[]) as List)
          .cast<OtherProjectModel>();
    } catch (e) {
      throw LocalStorageException('Failed to load other projects: $e');
    }
  }

  Future<void> clearAll() async {
    await box.clear();
  }
}

class LocalStorageException implements Exception {
  final String message;
  LocalStorageException(this.message);
  
  @override
  String toString() => message;
}