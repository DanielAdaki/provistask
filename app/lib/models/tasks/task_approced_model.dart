import 'package:provitask_app/models/pagination/pagination_model.dart';

class TaskAssigned {
  List<TaskData> data;
  Pagination meta;

  TaskAssigned({
    required this.data,
    required this.meta,
  });

  factory TaskAssigned.fromJson(Map<String, dynamic> json) {
    return TaskAssigned(
      data: List<TaskData>.from(json['data'].map((x) => TaskData.fromJson(x))),
      meta: Pagination.fromJson(json['meta']['pagination']),
    );
  }
}

class TaskData {
  int id;
  String status;
  String taskLength;
  DateTime datetime;
  String time;
  String createType;
  String transportation;
  int idCreador;
  ProviderLite provider;
  int conversation;
  SkillLite skill;

  TaskData({
    required this.id,
    required this.status,
    required this.taskLength,
    required this.datetime,
    required this.time,
    required this.createType,
    required this.transportation,
    required this.idCreador,
    required this.provider,
    required this.conversation,
    required this.skill,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      id: json['id'],
      status: json['status'],
      taskLength: json['taskLength'],
      datetime: DateTime.parse(json['datetime']),
      time: json['time'],
      createType: json['createType'],
      transportation: json['transportation'],
      idCreador: json['idCreador'],
      provider: ProviderLite.fromJson(json['provider']),
      conversation: json['conversation'],
      skill: SkillLite.fromJson(json['skill']),
    );
  }
}

class ProviderLite {
  int id;
  String name;
  String lastname;
  String avatar;

  ProviderLite({
    required this.id,
    required this.name,
    required this.lastname,
    required this.avatar,
  });

  factory ProviderLite.fromJson(Map<String, dynamic> json) {
    return ProviderLite(
      id: json['id'],
      name: json['name'],
      lastname: json['lastname'],
      avatar: json['avatar'],
    );
  }
}

class SkillLite {
  int id;
  String name;
  String shortName;

  SkillLite({
    required this.id,
    required this.name,
    required this.shortName,
  });

  factory SkillLite.fromJson(Map<String, dynamic> json) {
    return SkillLite(
      id: json['id'],
      name: json['name'],
      shortName: json['shortName'],
    );
  }
}
