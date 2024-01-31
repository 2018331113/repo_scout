import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:repo_scout/constants/app_constants.dart';
import 'package:repo_scout/constants/asset_path.dart';
import 'package:repo_scout/repository/remote_repository.dart';

import '../../api/api.dart';
import '../../models/query.dart';
import '../../models/repo.dart';
import 'widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Repo>? repos;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Center(
        child: (repos != null)
            ? ListView.builder(
                itemCount: repos!.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 20,
                ),
                itemBuilder: (context, index) {
                  return RepoContainer(repo: repos![index]);
                })
            : const CircularProgressIndicator(),
      ),
    );
  }

  Future getData() async {
    repos = await RemoteRepository(
      api: Api(),
    ).getRepositories(
      Query(
        q: "topic:flutter",
        sort: "stars",
        order: "desc",
        page: 1,
        perPage: 10,
      ),
    );
    setState(() {});
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
                if (repo.language != null)
                  LanguageWidget(repo: repo),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

