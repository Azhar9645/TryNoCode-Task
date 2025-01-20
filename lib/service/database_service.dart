import 'package:trynocode_assignment/models/other_project.dart';
import 'package:trynocode_assignment/models/main_project.dart';

abstract class DatabaseService {
  Future<void> insertMyProjects(List<ProjectModel> projects);
  Future<void> insertOtherProjects(List<OtherProjectModel> projects);
  Future<List<ProjectModel>> fetchMyProjects();
  Future<List<OtherProjectModel>> fetchOtherProjects();
}
