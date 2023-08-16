class Review {
  final String avatarUrl;
  final String username;
  final int rating;
  final String review;
  final String date;

  Review({
    required this.avatarUrl,
    required this.username,
    required this.rating,
    required this.review,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      avatarUrl: json['avatarUrl'],
      username: json['username'],
      rating: json['rating'],
      review: json['review'],
      date: json['date'],
    );
  }
}
