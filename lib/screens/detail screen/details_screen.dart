import 'package:flutter/material.dart';
import 'package:trynocode_assignment/models/other_project.dart';
import 'package:trynocode_assignment/models/main_project.dart';
import 'package:trynocode_assignment/screens/detail%20screen/details_project_card.dart';
import 'package:trynocode_assignment/screens/widgets/my_project/app_bar.dart';
import 'package:trynocode_assignment/screens/widgets/my_project/my_project_header.dart';

class DetailsScreen extends StatelessWidget {
  final ProjectModel? project; 
  final OtherProjectModel? otherProject; 

  const DetailsScreen({
    super.key,
    this.project,
    this.otherProject,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyProject(),
            if (project != null) 
              DetailProjectCard(project: project) 
            else if (otherProject != null)
              DetailProjectCard(otherProject: otherProject) 
          ],
        ),
      ),
    );
  }
}
