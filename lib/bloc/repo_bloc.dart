import 'dart:developer';

import 'package:bloc_event_transformers/bloc_event_transformers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repo_scout/models/query.dart';
import 'package:repo_scout/repository/repository.dart';
import '../models/repo.dart';
import 'dart:async';
part 'repo_event.dart';
part 'repo_state.dart';

const _repoLimit = 10;

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  RepoBloc({required this.repository}) : super(const RepoState()) {
    on<RepoFetched>(_onRepoFetched,
        transformer: throttle(const Duration(milliseconds: 500)));

    on<SortRepo>(_onRepoFetched,
        transformer: throttle(const Duration(milliseconds: 500)));
  }

  Future<void> _onRepoFetched(RepoEvent event, Emitter<RepoState> emit) async {
    if (state.hasReachedMax) return;

    
    try {
      if (event is SortRepo) {
        final repos = await _fetchPosts(sort: event.sort, order: event.order);
        return emit(state.copyWith(
          status: RepoStatus.success,
          repos: repos,
          hasReachedMax: false,
          sort: event.sort,
          order: event.order,
        ));
      } else if( event is RepoFetched) {
        emit(state.copyWith(hasInternet: event.hasInternet));
        if (state.status == RepoStatus.initial) {
          final repos = await _fetchPosts();
          return emit(state.copyWith(
            status: RepoStatus.success,
            repos: repos,
            hasReachedMax: false,
          ));
        }
        final repos = await _fetchPosts(
          page: state.repos.length ~/ _repoLimit + 1,
          sort: state.sort,
          order: state.order,
        );
        emit(repos.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                status: RepoStatus.success,
                repos: (state.hasInternet)
                    ? (List.of(state.repos)..addAll(repos))
                    : repos,
                hasReachedMax: false,
              ));
      }
    } catch (e) {
      emit(state.copyWith(status: RepoStatus.failure));
    }
  }

  Future<List<Repo>> _fetchPosts(
      {int page = 1, String sort = 'stars', String order = 'desc'}) async {
    final Query query = Query(
        q: 'topic:Flutter',
        page: page,
        perPage: _repoLimit,
        sort: sort,
        order: order);
    final repos = await repository.getRepositories(query);
    return repos;
  }

  final Repository repository;
}
