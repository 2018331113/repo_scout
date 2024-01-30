class ApiResponse {
  final bool incompleteResults;
  final dynamic items;
  final int totalCount;
  final String? message;

  ApiResponse({
    required this.incompleteResults,
    required this.items,
    required this.totalCount,
    required this.message,
  });
 
}
