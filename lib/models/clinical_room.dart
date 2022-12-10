import 'dart:convert';

class ClinicalRoomModel {
  ClinicalRoomModel userFromJson(String str) =>
      ClinicalRoomModel.fromJson(json.decode(str));

  static String userToJson(ClinicalRoomModel data) =>
      json.encode(data.toJson());

  String id;
  String name;
  int reception;
  int exmained;
  ClinicalRoomModel({
    required this.id,
    required this.name,
    required this.reception,
    required this.exmained,
  });

  factory ClinicalRoomModel.fromMap(Map<String, dynamic> json) =>
      ClinicalRoomModel(
        id: json['_id'],
        name: json['name'],
        reception: json['reception'],
        exmained: json['exmained'],
      );
  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'exmained': exmained,
        'reception': reception,
      };

  factory ClinicalRoomModel.fromJson(String source) =>
      ClinicalRoomModel.fromMap(json.decode(source));
}
