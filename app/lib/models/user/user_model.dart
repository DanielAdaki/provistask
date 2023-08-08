import 'package:logger/logger.dart';
import 'package:provitask_app/models/user/provider_skill.dart';

class UserMe {
  int id;
  String? token;
  String email;
  bool isProvider;
  String postalCode;
  String phone;
  String name;
  String lastname;
  double lat;
  double lng;
  String? typeProvider;
  String description;
  bool isStripeConnect;
  bool motorcycle;
  bool car;
  bool truck;
  String openDisponibility;
  String closeDisponibility;
  String skillAndExperience;
  String? avatarImage;
  List<ProviderSkill> providerSkills;

  UserMe({
    required this.id,
    this.token,
    required this.email,
    this.isProvider = false,
    this.postalCode = '',
    this.phone = '',
    required this.name,
    this.lastname = '',
    this.lat = 90.0,
    this.lng = 180.0,
    this.typeProvider,
    this.description = '',
    this.isStripeConnect = false,
    this.motorcycle = false,
    this.car = false,
    this.truck = false,
    this.openDisponibility = '',
    this.closeDisponibility = '',
    this.skillAndExperience = '',
    this.avatarImage = '',
    required this.providerSkills,
  });

  // un metodo para setear el token

  void setToken(String token) {
    this.token = token;
  }

  Map<String, dynamic> toJson() {
    final avatarImageJson = {'url': avatarImage};
    final providerSkillsJson =
        providerSkills.map((skill) => skill.toJson()).toList();

    return {
      'id': id,
      'token': token,
      'email': email,
      'isProvider': isProvider,
      'postal_code': postalCode,
      'phone': phone,
      'name': name,
      'lastname': lastname,
      'lat': lat,
      'lng': lng,
      'type_provider': typeProvider,
      'description': description,
      'is_stripe_connect': isStripeConnect,
      'motorcycle': motorcycle,
      'car': car,
      'truck': truck,
      'open_disponibility': openDisponibility,
      'close_disponibility': closeDisponibility,
      'skillAndExperience': skillAndExperience,
      'avatar_image': avatarImageJson,
      'provider_skills': providerSkillsJson,
    };
  }

  factory UserMe.fromJson(Map<String, dynamic> json) {
    Logger().i(json);
    late final Map<String, dynamic>? avatarImageJson;
    if (json['avatar_image'] != null) {
      avatarImageJson = json['avatar_image'] as Map<String, dynamic>;
    } else {
      avatarImageJson = null;
    }

    final providerSkillsJson = json['provider_skills'];

    return UserMe(
      id: json['id'],
      email: json['email'],
      isProvider: json['isProvider'],
      postalCode: json['postal_code'] ?? '',
      phone: json['phone'] ?? '',
      name: json['name'],
      lastname: json['lastname'] ?? '',
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
      typeProvider: json['type_provider'],
      description: json['description'] ?? '',
      isStripeConnect: json['is_stripe_connect'],
      motorcycle: json['motorcycle'],
      car: json['car'],
      truck: json['truck'],
      openDisponibility: json['open_disponibility'] ?? '',
      closeDisponibility: json['close_disponibility'] ?? '',
      skillAndExperience: json['skillAndExperience'] ?? '',
      avatarImage: avatarImageJson != null ? avatarImageJson['url'] : '',
      providerSkills: ProviderSkill.map(providerSkillsJson),
    );
  }
}
