import 'package:equatable/equatable.dart';
import 'package:repo_scout/models/owner.dart';

class Repo extends Equatable{
  final Owner owner;
  final String name;
  final String description;
  final bool private;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime pushedAt;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;
  final int openIssuesCount;
  final String? language;

  const Repo({
    required this.owner,
    required this.name,
    required this.description,
    required this.private,
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
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      private: json['private'] ?? false,
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

  factory Repo.fromDb(Map<String, dynamic> db) {
    return Repo(
      owner: Owner(avatarUrl: db['owner_img'], login: db['owner_name']),
      name: db['name'],
      description: db['description'],
      private: db['private'] == 1 ? true : false,
      createdAt: DateTime.parse(db['created_at']) ,
      updatedAt: DateTime.parse(db['updated_at']),
      pushedAt: DateTime.parse(db['pushed_at']),
      stargazersCount: db['stargazers_count'],
      watchersCount: db['watchers_count'],
      forksCount: db['forks_count'],
      openIssuesCount: db['open_issues_count'],
      language: db['language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'name': name,
      'description': description,
      'private': private,
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

  Map<String, dynamic> toDb() {
    return {
      'owner_img': owner.avatarUrl,
      'owner_name': owner.login,
      'name': name,
      'description': description,
      'private': private ? 1 : 0,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
      'pushed_at': pushedAt.toString(),
      'stargazers_count': stargazersCount,
      'watchers_count': watchersCount,
      'forks_count': forksCount,
      'open_issues_count': openIssuesCount,
      'language': language,
    };
  }
  
  @override
  List<Object?> get props => [
    owner,
    name,
    description,
    private,
    createdAt,
    updatedAt,
    pushedAt,
    stargazersCount,
    watchersCount,
    forksCount,
    openIssuesCount,
    language,
  ];
}
