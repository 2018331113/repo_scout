import 'dart:developer';

import 'package:repo_scout/models/api_response.dart';
import 'package:repo_scout/models/query.dart';

import '../api/api.dart';
import '../models/repo.dart';
import 'repository.dart';

class RemoteRepository implements Repository{
  @override
  Future<dynamic> getRepositories(Query query) async{
    
    final params = query.toMap();
   
    ApiResponse apiResponse = await Api().getRepositories(params);

   
    List<Repo> repos = [];

    for (var repo in apiResponse.items) {
      repos.add(Repo.fromJson(repo));
    }

    log(repos.length.toString());
   
    return repos;

   
  }
}