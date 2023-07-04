import 'dart:convert';

RegisterUserModel registerUserModelFromJson(String str) => RegisterUserModel.fromJson(json.decode(str));

String registerUserModelToJson(RegisterUserModel data) => json.encode(data.toJson());

class RegisterUserModel {
    RegisterUserModel({
        required this.data,
    });

    final RegisterData data;

    factory RegisterUserModel.fromJson(Map<String, dynamic> json) => RegisterUserModel(
        data: RegisterData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class RegisterData {
    RegisterData({
        required this.name,
        required this.surname,
        required this.email,
        required this.password,
        required this.status,
        required this.role,
        required this.confirm,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
    });

    final String name;
    final String surname;
    final String email;
    final String password;
    final bool status;
    final String role;
    final bool confirm;
    final String id;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        password: json["password"],
        status: json["status"],
        role: json["role"],
        confirm: json["confirm"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
        "status": status,
        "role": role,
        "confirm": confirm,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        required this.token,
        required this.user,
    });

    final String token;
    final User user;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
    };
}

class User {
    User({
        required this.id,
        required this.name,
        required this.surname,
        required this.email,
        required this.phone,
        required this.password,
        required this.status,
        required this.role,
        required this.confirm,
        required this.createdAt,
        required this.updatedAt,
    });

    final String id;
    final String name;
    final String surname;
    final String email;
    final int phone;
    final String password;
    final bool status;
    final String role;
    final bool confirm;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        surname: json["surname"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        status: json["status"],
        role: json["role"],
        confirm: json["confirm"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "surname": surname,
        "email": email,
        "phone": phone,
        "password": password,
        "status": status,
        "role": role,
        "confirm": confirm,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
