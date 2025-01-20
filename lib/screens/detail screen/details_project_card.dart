import 'package:flutter/material.dart';
import 'package:trynocode_assignment/screens/detail%20screen/leaderboard.dart';
import 'package:trynocode_assignment/models/other_project.dart';
import 'package:trynocode_assignment/models/project.dart';
import 'package:trynocode_assignment/utils/constants.dart';

class DetailProjectCard extends StatelessWidget {
  final ProjectModel? project;
  final OtherProjectModel? otherProject;

  const DetailProjectCard({
    super.key,
    this.project,
    this.otherProject,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (project != null || otherProject != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    project != null ? project!.image : otherProject!.image,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: PopupMenuButton<String>(
                    icon: Image.asset('assets/icons/menu.png'),
                    onSelected: (value) {
                      print(value);
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Edit', 'Share QR Code'}.map((String option) {
                        return PopupMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              project != null
                  ? project!.projectName
                  : otherProject!.projectName,
              style: i14B,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              project != null ? project!.groupName : otherProject!.groupName,
              style: p20B,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF5F75EE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              project != null ? project!.type : otherProject!.type,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
          if (otherProject != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                otherProject!.description,
                style: i14G,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Add Participant',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          LeaderboardContainer()
        ],
      ),
    );
  }
}
