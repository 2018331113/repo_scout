part of 'repo_bloc.dart';

sealed class RepoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class RepoFetched extends RepoEvent {
  final bool hasInternet;

  RepoFetched({required this.hasInternet});
}

final class SortRepo extends RepoEvent {
  final String sort;
  final String order;

  SortRepo({required this.sort, required this.order});

  @override
  List<Object> get props => [sort, order];
}