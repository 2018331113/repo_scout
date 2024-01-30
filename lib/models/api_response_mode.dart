enum ApiMode { online, offline }

class ApiResponseMode {
  final ApiMode apiMode;
  final dynamic responseData;

  ApiResponseMode({
    required this.apiMode,
    required this.responseData,
  });
}
