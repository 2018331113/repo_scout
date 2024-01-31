import 'dart:developer';

import 'package:repo_scout/db/local_db.dart';

import '../models/query.dart';
import '../models/repo.dart';
import 'repository.dart';

class LocalRepository implements Repository {
  


  
  static Future init() async {
    await LocalDB.instance.database;
  }
  
  @override
  Future<dynamic> getRepositories(Query query) async {
    LocalDB db = LocalDB.instance;
    final data = await db.getAllRepos(query.sort, query.order);
    log("local data : $data");
    List<Repo> repos = [];
    for (var repo in data) {
      repos.add(Repo.fromDb(repo));
    }
    return repos; 
  }

  static Future<void> cacheRepos(List<Repo> repos) async {
    LocalDB db = LocalDB.instance;
    for (var repo in repos) {
      await db.insert(repo.toDb());
    }
  }

  static Future deleteAllRecords() async {
    LocalDB db = LocalDB.instance;
    await db.deleteAllRecords();
  }
}