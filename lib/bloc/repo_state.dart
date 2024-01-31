part of 'repo_bloc.dart';

enum RepoStatus { initial, success, failure }

final class RepoState extends Equatable {
  const RepoState( {
    this.hasInternet = true,
    this.status = RepoStatus.initial,
    this.repos = const <Repo>[],
    this.sort = 'stars',
    this.order = 'desc',
    this.hasReachedMax = false,
  });

  final RepoStatus status;
  final List<Repo> repos;
  final bool hasReachedMax;
  final String order;
  final String sort;
  final bool hasInternet;
  RepoState copyWith({
    RepoStatus? status,
    List<Repo>? repos,
    bool? hasReachedMax,
    String? order,
    String? sort,
    bool? hasInternet,
  }) {
    return RepoState(
      status: status ?? this.status,
      repos: repos ?? this.repos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      order: order ?? this.order,
      sort: sort ?? this.sort,
      hasInternet: hasInternet?? this.hasInternet,
    );
  }

  @override
  String toString() {
    return '''Repostate { status: $status, hasReachedMax: $hasReachedMax, repos: ${repos.length} }''';
  }

  @override
  List<Object> get props => [status, repos, hasReachedMax];
}
