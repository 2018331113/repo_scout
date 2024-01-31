import 'package:bloc_event_transformers/bloc_event_transformers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_scout/models/query.dart';
import 'package:repo_scout/repository/repository.dart';
import '../models/repo.dart';
import 'package:stream_transform/stream_transform.dart';
import 'dart:async';

part 'repo_event.dart';
part 'repo_state.dart';

const _repoLimit = 20;

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  RepoBloc({required this.repository}) : super(const RepoState()) {
    on<RepoFetched>(_onRepoFetched,
        transformer: throttle(const Duration(milliseconds: 500)));
  }

  Future<void> _onRepoFetched(RepoEvent event, Emitter<RepoState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == RepoStatus.initial) {
        final repos = await _fetchPosts();
        return emit(state.copyWith(
          status: RepoStatus.success,
          repos: repos,
          hasReachedMax: false,
        ));
      }
      final repos = await _fetchPosts(state.repos.length);
      emit(repos.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: RepoStatus.success,
              repos: List.of(state.repos)..addAll(repos),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: RepoStatus.failure));
    }
  }

  Future<List<Repo>> _fetchPosts([int startIndex = 0]) async {
    final Query query = Query(q: 'topic:Flutter');
    final repos = await repository.getRepositories(query);
    return repos;
  }

  final Repository repository;
}