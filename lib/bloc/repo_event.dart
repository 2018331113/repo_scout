part of 'repo_bloc.dart';

sealed class RepoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class RepoFetched extends RepoEvent {}