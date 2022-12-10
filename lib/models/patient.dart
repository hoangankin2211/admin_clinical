import 'dart:convert';

class Patient {
  String id;
  String name;
  String gender;
  String address;
  String dob;
  String phoneNumber;
  String? email;
  String status;
  String? avt;
  String? symptom;
  List<String>? healthRecord;

  Patient({
    this.healthRecord,
    this.symptom,
    required this.id,
    required this.name,
    required this.gender,
    required this.address,
    required this.dob,
    required this.phoneNumber,
    required this.status,
    this.avt,
    this.email,
  });

  static Patient fromJson(Map<String, dynamic> json) {
    List<String> healthRecordTemp = [];
    List<dynamic> temp = json['healthRecord'] ?? [];
    for (var element in temp) {
      String? recordId = element;
      if (recordId != null) {
        healthRecordTemp.add(recordId);
      }
    }
    return Patient(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      gender: json['gender'] ?? '',
      address: json['address'] ?? '',
      dob: json['dob'] ?? '',
      email: json['email'] ?? '',
      status: json['status'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      avt: json['avt'] ?? '',
      symptom: json['symptom'] ?? '',
      healthRecord: healthRecordTemp,
    );
  }

  String toJson() {
    Map<String, dynamic> data = {};
    List<String> temp = [];
    data['_id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['gender'] = gender;
    data['dob'] = dob;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['avt'] = avt;
    data['status'] = status;
    data['symptom'] = symptom;
    data['healthRecord'] = healthRecord ?? temp;
    return jsonEncode(data);
  }
}
