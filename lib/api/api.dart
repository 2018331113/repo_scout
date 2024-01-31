import '../models/api_response.dart';
import '../models/api_response_mode.dart';
import 'http_manager.dart';

//for mock api

class Api  {

  static const String _baseUrl = "https://api.github.com/";
  static const String _searchRepositories = "${_baseUrl}search/repositories";
  static String get baseUrl => _baseUrl;
  static String get searchRepositories => _searchRepositories;
  final HttpManager httpManager = HttpManager();

  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();


  Future<ApiResponse> getRepositories(Map<String, dynamic> query) async {
   
    final response = await httpManager.get(url: _searchRepositories, params: query);
    dynamic result;
    if (response.apiMode == ApiMode.online) {
      result = response.responseData;
    } else {
      //for offline logic
    }
    final responseModel = ApiResponse(
      incompleteResults: result['incomplete_results'],
      items: result['items'],
      totalCount: result['total_count'],
      message: result['message']??"success",
    );
    return responseModel;
  }



}