import 'dart:convert';

class Doctor {
  String? email;
  String? name;
  String? address;
  String? gender;
  DateTime? dateBorn;
  String? avt;
  String? type;
  String? description;
  int? timeStart;
  int? timeFinish;
  int? experience;

  Doctor(
      {this.email,
      this.name,
      this.address,
      this.gender,
      this.dateBorn,
      this.avt,
      this.type,
      this.description,
      this.timeStart,
      this.timeFinish,
      this.experience});

  Doctor.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    name = json['name'];
    address = json['address'];
    gender = json['gender'];
    dateBorn = DateTime.fromMillisecondsSinceEpoch(json["dateBorn"]);
    avt = json['avt'];
    type = json['type'];
    description = json['description'];
    timeStart = (json['timeStart']);
    timeFinish = (json['timeFinish']);
    experience = (json['experience']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["email"] = email;
    data['name'] = name;
    data['address'] = address;
    data['gender'] = gender;
    data['dateBorn'] = dateBorn;
    data['avt'] = avt;
    data['type'] = type;
    data['description'] = description;
    data['timeStart'] = timeStart;
    data['timeFinish'] = timeFinish;
    data['experience'] = experience;
    return data;
  }

  Doctor userFromJson(String str) => Doctor.fromJson(json.decode(str));
  factory Doctor.fromMap(Map<String, dynamic> json) => Doctor();
}
