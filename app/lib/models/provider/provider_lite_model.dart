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
