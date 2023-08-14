class Pagination {
  int page;
  int limit;
  int total;
  int lastPage;

  Pagination({
    this.page = 1,
    this.limit = 5,
    this.total = 0,
    this.lastPage = 0,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      lastPage: json['lastPage'],
    );
  }
}
