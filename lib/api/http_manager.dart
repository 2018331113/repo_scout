

import 'package:dio/dio.dart';
import 'package:repo_scout/models/api_response_mode.dart';

import 'api.dart';

ApiResponseMode dioErrorHandle(DioException error) {
  switch (error.type) {
    case DioExceptionType.badResponse:
      return ApiResponseMode(
        apiMode: ApiMode.online,
        responseData: {
          "incomplete_results": true,
          "items": [],
          "total_count": 0,
          "message": "json_format_error",
        },
      );
    case DioExceptionType.sendTimeout:
      return ApiResponseMode(
        apiMode: ApiMode.offline,
        responseData: {
          "incomplete_results": true,
          "items": [],
          "total_count": 0,
          "message": "send_time_out,"
        },
      );
    case DioExceptionType.receiveTimeout:
      return ApiResponseMode(
        apiMode: ApiMode.offline,
        responseData: {
          "incomplete_results": true,
          "items": [],
          "total_count": 0,
          "message": "request_time_out",
        },
      );

    default:
      return ApiResponseMode(
        apiMode: ApiMode.offline,
        responseData: {
          "incomplete_results": true,
          "items": [],
          "total_count": 0,
          "message": "connect_to_server_fail",
        },
      );
  }
}

class HttpManager {
  static final HttpManager _instance = HttpManager._internal();

  factory HttpManager() {
    return _instance;
  }

  HttpManager._internal();

  BaseOptions baseOptions = BaseOptions(
    baseUrl: Api.baseUrl,
    connectTimeout: const Duration(milliseconds: 10000),
    receiveTimeout: const Duration(milliseconds: 10000),
    contentType: Headers.formUrlEncodedContentType,
    responseType: ResponseType.json,
  );

  Future<ApiResponseMode> get({
    required String url,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    Dio dio = Dio(baseOptions);
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
      );

      return ApiResponseMode(
        apiMode: ApiMode.online,
        responseData: response.data,
      );
    } on DioException catch (error) {
      //log(error.toString());
      return dioErrorHandle(error);
    }
  }
}

HttpManager httpManager = HttpManager();
