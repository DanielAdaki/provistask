class Skill {
  int id;
  int idCategory;
  double cost;
  String? typePrice;
  String? description;
  String? minimalHour = 'hour_1';
  List? media = [];

  Skill({
    required this.id,
    required this.idCategory,
    required this.cost,
    this.typePrice = 'per_hour',
    this.description = '',
    this.minimalHour,
    this.media,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      idCategory: json['id'],
      cost: double.parse(json['cost']),
      typePrice: json['type_price'],
      description: json['description'],
      media: json['images'],
    );
  }
}
