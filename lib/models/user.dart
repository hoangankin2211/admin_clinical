import 'dart:convert';

class User {
  User userFromJson(String str) => User.fromJson(json.decode(str));

  static String userToJson(User data) => json.encode(data.toJson());
  User({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.id,
    required this.token,
    required this.gender,
    required this.phoneNumber,
    required this.dateBorn,
    required this.avt,
  });

  String name;
  String email;
  String password;
  String address;
  String type;
  String id;
  String token;
  String gender;
  String phoneNumber;
  String avt;
  DateTime dateBorn;
  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        type: json["type"],
        id: json["_id"],
        token: json["token"] ?? '',
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
        dateBorn: DateTime.fromMillisecondsSinceEpoch(json["dateBorn"]),
        avt: json["avt"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "address": address,
        "type": type,
        "_id": id,
        "token": token,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "dateBorn": dateBorn,
        "avt": avt,
      };
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? type,
    String? token,
    String? gender,
    String? phoneNumber,
    DateTime? dateBorn,
    String? avt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateBorn: dateBorn ?? this.dateBorn,
      avt: avt ?? this.avt,
    );
  }
}
