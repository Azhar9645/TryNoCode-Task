// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trynocode_assignment/utils/constants.dart';

class LeaderboardContainer extends StatelessWidget {
  const LeaderboardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kPink,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                'Leaderboard',
                style: p18B,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: LeaderboardEntry(
                            position: '${index + 1}',
                            score: index < 2 ? '183 SoCCs' : '177 SoCCs',
                            isTopThree: true,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: LeaderboardEntry(
                              position: '${index + 4}',
                              score: '170 SoCCs',
                              isTopThree: false,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LeaderboardEntry extends StatelessWidget {
  final String position;
  final String score;
  final bool isTopThree;

  const LeaderboardEntry({
    super.key,
    required this.position,
    required this.score,
    required this.isTopThree,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4E3),
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/icons/profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (isTopThree)
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFD233),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    position,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rubal Soni',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                score,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
        if (!isTopThree)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'RANK ${int.parse(position)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
      ],
    );
  }
}
