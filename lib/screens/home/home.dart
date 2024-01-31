
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_scout/repository/remote_repository.dart';

import '../../api/api.dart';
import '../../bloc/repo_bloc.dart';
import '../../models/query.dart';
import '../../models/repo.dart';
import 'widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  List<Repo>? repos;
  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: BlocBuilder<RepoBloc, RepoState>(
      builder: (context, state) {
        switch (state.status) {
          case RepoStatus.failure:
            return const Center(child: Text('failed to fetch repositories'));
          case RepoStatus.success:
            if (state.repos.isEmpty) {
              return const Center(child: Text('no repository found'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.repos.length
                    ? const BottomLoader()
                    : RepoContainer(repo: state.repos[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.repos.length
                  : state.repos.length + 1,
              controller: _scrollController,
            );
          case RepoStatus.initial:
            


            return const Center(child: CircularProgressIndicator());
        }
      },
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
   @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<RepoBloc>().add(RepoFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}



