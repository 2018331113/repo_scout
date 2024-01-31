import 'dart:developer';

import 'package:repo_scout/models/api_response.dart';
import 'package:repo_scout/models/query.dart';

import '../api/api.dart';
import '../models/repo.dart';
import 'repository.dart';

class RemoteRepository implements Repository {
  //create a constructor taking parameter of Api
  late Api _api;

  RemoteRepository({required  Api api}) {
    _api = api;
  }
  @override
  Future<dynamic> getRepositories(Query query) async {
    final params = query.toMap();
    ApiResponse apiResponse = await _api.getRepositories(params); 
    List<Repo> repos = [];
    for (var repo in apiResponse.items) {
      repos.add(Repo.fromJson(repo));
    }
    
  

    return repos;
  }
}
