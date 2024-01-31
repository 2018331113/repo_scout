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
                  const Positioned(
                    bottom: 20,
                    right: 20,
                    child: MyPopupMenuButton(),
                  ),
                ],
              ));
  }
}

class MyPopupMenuButton extends StatefulWidget {
  const MyPopupMenuButton({super.key});

  @override
  _MyPopupMenuButtonState createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  List<bool> selectedValues = [true, false, false, false, true];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade900,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ]),
      child: PopupMenuButton<int>(
        itemBuilder: (context) => <PopupMenuEntry<int>>[
          CheckedPopupMenuItem<int>(
            value: 0,
            checked: selectedValues[0],
            child: const Text('Stars'),
          ),
          CheckedPopupMenuItem<int>(
            value: 1,
            checked: selectedValues[1],
            child: const Text('Forks'),
          ),
          CheckedPopupMenuItem<int>(
            value: 2,
            checked: selectedValues[2],
            child: const Text('Updated'),
          ),
          const PopupMenuDivider(),
          CheckedPopupMenuItem<int>(
            value: 3,
            checked: selectedValues[3],
            child: const Text('Ascending'),
          ),
          CheckedPopupMenuItem<int>(
            value: 4,
            checked: selectedValues[4],
            child: const Text('Descending'),
          ),
        ],
        onSelected: (value) {
          setState(() {
            if (value < 3) {
              for (int i = 0; i < 3; i++) {
                if (i != value) {
                  selectedValues[i] = false;
                } else {
                  selectedValues[i] = true;
                }
              }
            }
            if (value == 3) {
              selectedValues[4] = !selectedValues[3];
            }
            if (value == 4) {
              selectedValues[3] = !selectedValues[4];
            }
          });
        },
        icon: const Icon(Icons.more_vert),
      ),
    );
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
