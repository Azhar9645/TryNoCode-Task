import 'package:flutter/material.dart';
import 'package:trynocode_assignment/utils/constants.dart';

class StatsContainer extends StatelessWidget {
  final int memberCount;
  final int eventCount;
  final int soccsValue;

  const StatsContainer({
    Key? key,
    required this.memberCount,
    required this.eventCount,
    required this.soccsValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 199,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200, // Outline border color
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                StatsColumn(
                  icon: 'assets/icons/Frame 34180.png',
                  label: 'Members',
                  value: memberCount.toString(),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  thickness: .2,
                  width: 1,
                ),
                StatsColumn(
                  icon: 'assets/icons/1.png',
                  label: 'Total events',
                  value: eventCount.toString(),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.shade200,
            thickness: 1,
            height: 1,
          ),
          Expanded(
            child: Center(
              child: StatsColumn(
                icon: 'assets/icons/AI COIN 1.png',
                label: 'SoCCs Value',
                value: soccsValue.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatsColumn extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const StatsColumn({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  icon,
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 8),
                Text(label, style: i12G),
              ],
            ),
            Center(
              child: SizedBox(
                height: 40,
                child: Text(value, style: p32B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
