import 'package:flutter/material.dart';
import 'package:repo_scout/widgets/option_widget.dart';

class ForkWidget extends StatelessWidget {
  final int forksCount;
  final bool? expanded;
  final Color color = Colors.green;
  const ForkWidget({super.key, required this.forksCount, this.expanded});

  @override
  Widget build(BuildContext context) {
    return OptionWidget(
      icon: Icons.fork_right,
      color: color,
      value: forksCount,
      expanded: expanded,
    );
  }
}

class WatcherWidget extends StatelessWidget {
  final int watchersCount;
  final bool? expanded;
  final Color color = Colors.white;
  const WatcherWidget({super.key, required this.watchersCount, this.expanded});

  @override
  Widget build(BuildContext context) {
    return OptionWidget(
      icon: Icons.remove_red_eye_outlined,
      color: color,
      value: watchersCount,
      expanded: expanded,
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final String title;
  final String value;
  const ContainerWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(
        value,
        style: const TextStyle(fontSize: 14),
      )
    ]);
  }
}
