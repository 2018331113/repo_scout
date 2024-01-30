import 'package:flutter/material.dart';
import 'package:repo_scout/repository/remote_repository.dart';

import '../api/api.dart';
import '../models/query.dart';
import '../models/repo.dart';

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
        body: Center(
      child: (repos != null)
          ? ListView.builder(
            itemCount: repos!.length,
            itemBuilder: (context, index) {

              return Text(repos![index].name);
            })
          : CircularProgressIndicator(),
    ));
  }

  Future getData() async {
    repos = await RemoteRepository().getRepositories(
      Query(
        q: "topic:flutter",
        sort: "stars",
        order: "desc",
        page: 1,
        perPage: 10,
      ),
    );
    setState(() {
      
    });
  }
}
