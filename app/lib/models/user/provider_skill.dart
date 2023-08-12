import 'package:logger/logger.dart';

class ProviderSkill {
  int id;
  String? typePrice;
  double? cost;
  List<String>? media;
  String categoriasSkill;
  int categoriasSkillId;
  String? description;
  String hourMinimum;

  ProviderSkill({
    required this.id,
    this.typePrice,
    this.cost,
    this.media,
    required this.categoriasSkill,
    required this.categoriasSkillId,
    this.description,
    this.hourMinimum = 'per_hour',
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_price': typePrice,
      'cost': cost,
      'media': media,
      'categorias_skill': {
        'name': categoriasSkill,
        'id': categoriasSkillId,
      },
      'description': description,
      'hourMinimum': hourMinimum,
    };
  }

  factory ProviderSkill.fromJson(Map<String, dynamic> json) {
    final nombreCategoria = json['categorias_skill'] is Map
        ? json['categorias_skill']['name']
        : json['categorias_skill'];

    final categoriaID = json['categorias_skill'] is Map
        ? json['categorias_skill']['id']
        : json['categorias_skill_id'];

    // recorro la media para obtener solo la url

    final media = json['media'] ?? [];

    List<String> mediaUrl = [];

    media.forEach((element) {
      // si el elemento es un mapa y tiene la key url lo agrego a la lista de mediaUrl sino no hago nada

      if (element is Map && element.containsKey('url')) {
        mediaUrl.add(element['url']);
      }

      if (element is String) {
        mediaUrl.add(element);
      }
    });

    return ProviderSkill(
      id: json['id'],
      typePrice: json['type_price'],
      cost: json['cost']?.toDouble(),
      media: mediaUrl,
      categoriasSkill: nombreCategoria,
      categoriasSkillId: categoriaID,
      description: json['description'] ?? '',
      hourMinimum: json['hourMinimum'] ?? 'per_hour',
    );
  }

  static List<ProviderSkill> map(List<dynamic> jsonList) {
    return jsonList.map((json) => ProviderSkill.fromJson(json)).toList();
  }
}
