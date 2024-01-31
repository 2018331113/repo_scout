class Query {
  final String q;
  String sort;
  String order;
  int page;
  int perPage;

  Query({
    required this.q,
    this.sort = 'stars',
    this.order = 'desc',
    this.page = 1,
    this.perPage = 30,
  });



  Map<String, dynamic> toMap() {
    return {
      'q': q,
      'sort': sort,
      'order': order,
      'page': page,
      'per_page': perPage,
    };
    
  }
}
