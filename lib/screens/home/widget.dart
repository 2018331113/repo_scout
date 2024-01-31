import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../constants/asset_path.dart';
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


class RepoContainer extends StatelessWidget {
  final Repo repo;
  const RepoContainer({
    super.key,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade800,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage(assetImageOwner),
                  foregroundImage:
                      CachedNetworkImageProvider(repo.owner.avatarUrl),
                  radius: 10,
                ),
                hGap10,
                Text(repo.owner.login),
              ],
            ),
            vGap5,
            Text(
              repo.name,
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: titleStyle,
            ),
            vGap5,
            Text(
              repo.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 12,
              ),
            ),
            vGap5,
            Row(
              children: [
                StarGazerWidget(
                  stargazersCount: repo.stargazersCount,
                ),
                hGap10,
                if (repo.language != null) LanguageWidget(repo: repo),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
