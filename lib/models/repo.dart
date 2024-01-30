import 'package:repo_scout/models/owner.dart';

class Repo {
  final Owner owner;
  final String name;
  final String description;
  final bool private;
  final bool fork;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime pushedAt;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;
  final int openIssuesCount;
  final String? language;

  Repo({
    required this.owner,
    required this.name,
    required this.description,
    required this.private,
    required this.fork,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.openIssuesCount,
    this.language,
  });

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      owner: Owner.fromJson(json['owner']),
      name: json['name'],
      description: json['description'],
      private: json['private'],
      fork: json['fork'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      pushedAt: DateTime.parse(json['pushed_at']),
      stargazersCount: json['stargazers_count'],
      watchersCount: json['watchers_count'],
      forksCount: json['forks_count'],
      openIssuesCount: json['open_issues_count'],
      language: json['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'name': name,
      'description': description,
      'private': private,
      'fork': fork,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pushed_at': pushedAt,
      'stargazers_count': stargazersCount,
      'watchers_count': watchersCount,
      'forks_count': forksCount,
      'open_issues_count': openIssuesCount,
      'language': language,
    };
  }
}
