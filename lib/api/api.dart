import 'http_manager.dart';

class Api{

  static const String _baseUrl = "https://api.github.com/";
  static const String _searchRepositories = "${_baseUrl}search/repositories";
  static String get baseUrl => _baseUrl;

  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();


  Future getRepositories(Map<String, dynamic> query) async {
   
    final response = await httpManager.get(url: _searchRepositories, params: query);
    return response;
  }



}