import 'dart:developer';

import 'package:dio/dio.dart';

import 'api.dart';

class HttpManager{

  static final HttpManager _instance = HttpManager._internal();

  factory HttpManager(){
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

  Future get({
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

      log(response.data.toString());

    } on DioException catch (error) {
      log(error.toString());
      // return dioErrorHandle(error);
    }
  }
}

HttpManager httpManager = HttpManager();