import 'package:flutter/material.dart';
import 'package:trynocode_assignment/models/other_project.dart';
import 'package:trynocode_assignment/models/project.dart';
import 'package:trynocode_assignment/screens/detail%20screen/details_project_card.dart';
import 'package:trynocode_assignment/widgets/my_project/app_bar.dart';
import 'package:trynocode_assignment/widgets/my_project/my_project_header.dart';

class DetailsScreen extends StatelessWidget {
  final ProjectModel? project; // Can be nullable
  final OtherProjectModel? otherProject; // Can be nullable

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
              DetailProjectCard(project: project) // When it's a ProjectModel
            else if (otherProject != null)
              DetailProjectCard(otherProject: otherProject) // When it's an OtherProjectModel
          ],
        ),
      ),
    );
  }
}
