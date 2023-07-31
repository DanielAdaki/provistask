class HomeCategory {
  final int id;
  final String slug;
  final String title;
  final String image;
  final double? costAverage;
  final double? rating;
  final int? countPurchase;
  final String? description;
  final int categoryId;

  HomeCategory({
    required this.id,
    this.slug = '',
    required this.title,
    required this.image,
    this.costAverage = 0.0,
    this.rating = 0.0,
    this.countPurchase = 0,
    this.description = '',
    required this.categoryId,
  });
}
