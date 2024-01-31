import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../models/repo.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    super.key,
    required this.repo,
  });

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey.shade700,
      ),
      child: Text(repo.language!,
          style: const TextStyle(
            fontSize: 12,
          )),
    );
  }
}

class StarGazerWidget extends StatelessWidget {
  const StarGazerWidget({
    super.key,
    required this.stargazersCount,
  });

  final int stargazersCount;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Icon(
        Icons.star,
        size: 18,
        color: Colors.amber,
      ),
      hGap5,
      Text(
        stargazersCount.toString(),
        style: TextStyle(
          color: Colors.grey.shade200,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  }
}
