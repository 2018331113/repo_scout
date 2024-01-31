import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/repo_bloc.dart';
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
    return BlocBuilder<RepoBloc, RepoState>(
      builder: (context, state) {
        switch (state.status) {
          case RepoStatus.initial:
            return const InitialView();
          case RepoStatus.failure:
            return const OnFailedView();
          case RepoStatus.success:
            return OnSuccessView(
                scrollController: _scrollController, state: state);
        }
      },
    );
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

class OnSuccessView extends StatelessWidget {
  const OnSuccessView({
    super.key,
    required ScrollController scrollController,
    required this.state,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final RepoState state;

  void showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50.0,
        right: 50.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item ${index + 1}'),
                );
              },
            ),
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 5), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () {
        //   context.read<RepoBloc>().add(SortRepo(sort: 'stars', order: 'desc'));
        // }),
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: (state.repos.isEmpty)
            ? const Center(
                child: Text('no repository found'),
              )
            : Stack(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 18),
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.repos.length
                          ? const BottomLoader()
                          : RepoContainer(repo: state.repos[index]);
                    },
                    itemCount: state.hasReachedMax
                        ? state.repos.length
                        : state.repos.length + 1,
                    controller: _scrollController,
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: MyPopupMenuButton(
                      sort: state.sort,
                      order: state.order,
                    ),
                  ),
                ],
              ));
  }
}

class InitialView extends StatelessWidget {
  const InitialView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: const Center(child: CircularProgressIndicator()));
  }
}

class OnFailedView extends StatelessWidget {
  const OnFailedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: const Center(child: Text('failed to fetch repositories')),
    );
  }
}
