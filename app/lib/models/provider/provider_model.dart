class Provider {
  int id;
  bool isProvider;
  String name;
  String? lastname;
  double? averageScore;
  int? averageCount;
  String? typeProvider;
  String? description;
  bool? motorcycle;
  bool? car;
  bool? truck;
  String openDisponibility;
  String closeDisponibility;
  String? avatarImage;
  Map? skillSelect;
  double distanceLineal;
  List<ProviderSkill>? allSkills;
  OnlineStatus? online;
  Provider({
    required this.id,
    required this.isProvider,
    required this.name,
    this.lastname,
    this.averageScore,
    this.averageCount,
    this.typeProvider,
    this.description,
    this.motorcycle,
    this.car,
    this.truck,
    required this.openDisponibility,
    required this.closeDisponibility,
    this.avatarImage,
    this.skillSelect,
    required this.distanceLineal,
    this.allSkills,
    this.online,
  });
}

class ProviderSkill {
  String? typePrice;
  double? cost;
  List<String>? media;
  String categoriasSkill;
  int categoriasSkillId;
  String? description;
  ProviderSkill({
    this.typePrice,
    this.cost,
    this.media,
    required this.categoriasSkill,
    required this.categoriasSkillId,
    this.description,
  });
  factory ProviderSkill.fromJson(Map<String, dynamic> json) {
    return ProviderSkill(
      typePrice: json['type_price'],
      // ignore: prefer_null_aware_operators
      cost: json['cost'] != null ? json['cost'].toDouble() : null,
      media: json['media'] != null ? List<String>.from(json['media']) : [],
      categoriasSkill: json['categorias_skill'] ?? "",
      categoriasSkillId: json['categorias_skill_id'] ?? 0,
      description: json['description'] ?? "",
    );
  }
  static List<ProviderSkill> map(List<dynamic> jsonList) {
    return jsonList.map((json) => ProviderSkill.fromJson(json)).toList();
  }
}

class OnlineStatus {
  String? socketId;
  String? lastConnection;
  String? status;
  OnlineStatus({
    this.socketId,
    this.lastConnection,
    this.status,
  });
  factory OnlineStatus.fromJson(Map<String, dynamic> json) {
    return OnlineStatus(
      socketId: json['socket_id'],
      lastConnection: json['lastConnection'],
      status: json['status'],
    );
  }
}
