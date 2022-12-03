import 'dart:convert';

class Patient {
  String id;
  String name;
  String gender;
  String address;
  String dob;
  String phoneNumber;
  String status;
  String? avt;
  String? symptom;

  Patient({
    this.symptom,
    required this.id,
    required this.name,
    required this.gender,
    required this.address,
    required this.dob,
    required this.phoneNumber,
    required this.status,
    this.avt,
  });

  static Patient fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json['_id'] ?? '',
        name: json['name'] ?? '',
        gender: json['gender'] ?? '',
        address: json['address'] ?? '',
        dob: json['dob'] ?? '',
        status: json['status'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        avt: json['avt'] ?? '',
        symptom: json['symptom']);
  }

  String toJson() {
    Map<String, dynamic> data = {};
    data['_id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['gender'] = gender;
    data['dob'] = dob;
    data['phoneNumber'] = phoneNumber;
    data['avt'] = avt;
    data['status'] = status;
    data['symptom'] = symptom;
    return jsonEncode(data);
  }
}
