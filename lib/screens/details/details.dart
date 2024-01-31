import 'package:flutter/material.dart';
import 'package:repo_scout/constants/app_constants.dart';
import 'package:repo_scout/widgets/option_widget.dart';
import 'package:repo_scout/widgets/owner_widget.dart';

import '../../models/repo.dart';
import 'widgets.dart';

class DetailsScreen extends StatelessWidget {
  final Repo repo;
  const DetailsScreen({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repository Details"),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            OwnerWidget(
              owner: repo.owner,
              expanded: true,
            ),
            vGap20,
            Text(
              repo.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
            ),
            vGap10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Icon(
                    Icons.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  hGap5,
                  Text(
                    (repo.language != null) ? repo.language! : "Undifined",
                  )
                ]),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                  child: Text(
                    (repo.private) ? "Private" : "Public",
                  ),
                ),
              ],
            ),
            vGap10,
            Text(
              repo.description,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14,
              ),
            ),
            vGap10,
            Row(children: [
              Flexible(
                child: StarGazerWidget(
                  stargazersCount: repo.stargazersCount,
                  expanded: true,
                ),
              ),
              Flexible(
                child: ForkWidget(
                  forksCount: repo.forksCount,
                  expanded: true,
                ),
              ),
              Flexible(
                child: WatcherWidget(
                  watchersCount: repo.watchersCount,
                  expanded: true,
                ),
              ),
            ]),
            vGap20,
            Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: ContainerWidget(
                  title: "Open Issues",
                  value: repo.openIssuesCount.toString(),
                )),
            vGap20,
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Column(children: [
                ContainerWidget(
                  title: "Last Updated",
                  value:
                      "${repo.updatedAt.day} ${getMonth(repo.updatedAt.month)}, ${repo.updatedAt.year} at ${getTime(repo.updatedAt.hour, repo.updatedAt.minute)}",
                ),
                vGap10,
                ContainerWidget(
                  title: "Last Push",
                  value:
                      "${repo.pushedAt.day} ${getMonth(repo.pushedAt.month)}, ${repo.pushedAt.year} at ${getTime(repo.pushedAt.hour, repo.pushedAt.minute)}",
                ),
                vGap10,
                ContainerWidget(
                  title: "Last Updated",
                  value:
                      "${repo.createdAt.day} ${getMonth(repo.createdAt.month)}, ${repo.createdAt.year} at ${getTime(repo.createdAt.hour, repo.createdAt.minute)}",
                ),
              ]),
            )
          ]),
    );
  }
}

String getMonth(int month) {
  final months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return months[month - 1];
}

String getTime(int hour, int minute) {
  if (hour > 12) {
    return "${hour - 12}:$minute PM";
  } else {
    if (hour == 0) {
      return "${hour + 12}:$minute AM";
    }
    return "$hour:$minute AM";
  }
}
