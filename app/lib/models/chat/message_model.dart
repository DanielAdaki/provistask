class Mensaje {
  Author author;
  int createdAt;
  String id;
  String status;
  String text;
  String type;
  String roomId;
  Mensaje({
    required this.author,
    required this.createdAt,
    required this.id,
    required this.status,
    required this.text,
    required this.type,
    required this.roomId,
  });
  factory Mensaje.fromJson(Map<String, dynamic> json) {
    return Mensaje(
      author: Author.fromJson(json['author']),
      createdAt: json['createdAt'],
      id: json['id'],
      status: json['status'],
      text: json['text'],
      type: json['type'],
      roomId: json['roomId'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author.toJson();
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['status'] = status;
    data['text'] = text;
    data['type'] = type;
    data['roomId'] = roomId;
    return data;
  }
}

class Author {
  String firstName;
  String id;
  String imageUrl;
  String lastName;
  Author({
    required this.firstName,
    required this.id,
    required this.imageUrl,
    required this.lastName,
  });
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      firstName: json['firstName'],
      id: json['id'],
      imageUrl: json['imageUrl'],
      lastName: json['lastName'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['lastName'] = lastName;
    return data;
  }
}
