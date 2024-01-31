import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class OptionWidget extends StatelessWidget {
  final IconData icon;
  final int value;
  final Color color;
  final bool? expanded;
  const OptionWidget(
      {super.key,
      required this.icon,
      required this.value,
      this.expanded,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(
        icon,
        size: (expanded != null) ? 24 : 18,
        color: color,
      ),
      hGap5,
      Text(
        (value > 9999)
            ? "${(value / 1000).toStringAsFixed(2)}k"
            : value.toString(),
        style: TextStyle(
          color: Colors.grey.shade200,
          fontSize: (expanded != null) ? 18 : 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  }
}

class StarGazerWidget extends StatelessWidget {
  const StarGazerWidget({
    super.key,
    required this.stargazersCount,
    this.expanded,
  });

  final int stargazersCount;
  final bool? expanded;
  final Color color = Colors.amber;
  @override
  Widget build(BuildContext context) {
    return OptionWidget(
      icon: Icons.star,
      value: stargazersCount,
      color: color,
      expanded: expanded,
    );
  }
}
