import 'package:provitask_app/models/provider/provider_lite_model.dart';
import 'package:provitask_app/models/provider/review_model.dart';
import 'package:provitask_app/models/provider/skill_lite_model.dart';

class TaskApprovalDetail {
  int id;
  String status;
  String taskLength;
  DateTime datetime;
  String createType;
  int idCreador;
  String transportation;
  String? description;
  String? location;
  String? brutePrice;
  String? netoPrice;
  String? totalPrice;
  String? descriptionProvis;
  ProviderLite provider;
  int? conversation;
  SkillLite skill;
  List<String> images;
  List<String> mediaConversation;
  Review? review;

  TaskApprovalDetail({
    required this.id,
    required this.status,
    required this.taskLength,
    required this.datetime,
    required this.createType,
    required this.idCreador,
    required this.transportation,
    this.description = '',
    this.location = '',
    this.brutePrice,
    this.netoPrice,
    this.totalPrice,
    this.descriptionProvis,
    required this.provider,
    this.conversation,
    required this.skill,
    required this.images,
    required this.mediaConversation,
    this.review,
  });

  factory TaskApprovalDetail.fromJson(Map<String, dynamic> json) {
    return TaskApprovalDetail(
      id: json['data']['id'],
      status: json['data']['status'],
      taskLength: json['data']['taskLength'],
      datetime: DateTime.parse(json['data']['datetime']),
      createType: json['data']['createType'],
      idCreador: json['data']['idCreador'],
      transportation: json['data']['transportation'],
      description: json['data']['description'],
      location: json['data']['location'],
      brutePrice: json['data']['brutePrice'],
      netoPrice: json['data']['netoPrice'],
      totalPrice: json['data']['totalPrice'],
      descriptionProvis: json['data']['descriptionProvis'],
      provider: ProviderLite.fromJson(json['data']['provider']),
      conversation: json['data']['conversation'],
      skill: SkillLite.fromJson(json['data']['skill']),
      images: List<String>.from(json['data']['images']),
      mediaConversation: List<String>.from(json['data']['mediaConversation']),
      review: json['data']['review'] != null
          ? Review.fromJson(json['data']['review'])
          : null,
    );
  }
}
