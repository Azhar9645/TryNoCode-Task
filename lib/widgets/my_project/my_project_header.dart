import 'package:flutter/material.dart';
import 'package:trynocode_assignment/utils/constants.dart';

class MyProject extends StatelessWidget {
  const MyProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);  // Navigate back if possible
                } else {
                  // Optionally, handle the case where there is no screen to go back to
                  print("No screen to go back to");  // Or show a message, or exit app
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Text('My Projects', style: p20B),
        ],
      ),
    );
  }
}
