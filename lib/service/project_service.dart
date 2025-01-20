import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trynocode_assignment/models/other_project.dart';
import 'package:trynocode_assignment/models/main_project.dart';

class ProjectService {
  static const String baseUrl =
      'https://socss-phone-no--asiainitiatives-84snx4.us-central1.hosted.app/api/v1/manager';
  static const String userId = 'XFumcuHdpTNplU5a4XoWSHRxLC12';

  Future<List<ProjectModel>> fetchMyProjects() async {
    final response = await http.get(
      Uri.parse('$baseUrl/myprojects?userId=$userId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List projects = data['projectData'];
      return projects.map((e) => ProjectModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load My Projects');
    }
  }

  Future<List<OtherProjectModel>> fetchOtherProjects({required int page, required int limit}) async {
    final url = '$baseUrl/otherprojects?userId=$userId&page=$page&limit=$limit';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> projectList = data['projects'];
      return projectList.map((e) => OtherProjectModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load other projects');
    }
  }
}
