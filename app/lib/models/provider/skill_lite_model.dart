class SkillLite {
  int id;
  String name;
  String shortName;
  String? image;
  String? typePrice;
  double? cost;
  String? hourMinimum;

  SkillLite({
    required this.id,
    required this.name,
    required this.shortName,
    this.image,
    this.typePrice,
    this.cost,
    this.hourMinimum,
  });

  factory SkillLite.fromJson(Map<String, dynamic> json) {
    return SkillLite(
      id: json['id'],
      name: json['name'],
      shortName: json['shortName'],
      image: json['image'],
      typePrice: json["type_price"] ?? "per_hour",
      // ignore: prefer_null_aware_operators
      cost: json["cost"] == null ? null : json["cost"].toDouble(),
      hourMinimum: json["hourMinimum"] ?? "hour_1",
    );
  }
}
