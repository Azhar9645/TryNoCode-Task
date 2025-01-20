import 'package:flutter/material.dart';
import 'package:trynocode_assignment/models/project.dart';
import 'package:trynocode_assignment/screens/detail%20screen/details_screen.dart';
import 'package:trynocode_assignment/utils/constants.dart';
import 'package:trynocode_assignment/screens/widgets/my_project/stats_container.dart';

class MainProjectCard extends StatelessWidget {
  final ProjectModel project;

  const MainProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: kPink,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  project.image, 
                  width: double.infinity,
                  height: 222,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.projectName,
                        style: i10B), 
                    const SizedBox(height: 4),
                    Text(project.groupName,
                        style: p20B), 
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5F75EE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(project.type,
                          style: i14W), 
                    ),
                    const SizedBox(height: 20),
                    StatsContainer(
                      memberCount: project.memberCount,
                      eventCount: project.eventCount,
                      soccsValue: project.soccsValue,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                      project: project,
                                    )),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Open Project',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
