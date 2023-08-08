import 'package:provitask_app/models/user/provider_skill.dart';

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
