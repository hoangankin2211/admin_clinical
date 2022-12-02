import 'dart:convert';

class Patient {
  String id;
  String name;
  String gender;
  String address;
  String dob;
  String phoneNumber;
  String status;
  String avt;

  Patient({
    required this.id,
    required this.name,
    required this.gender,
    required this.address,
    required this.dob,
    required this.phoneNumber,
    required this.status,
    required this.avt,
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
    );
  }

  String toJson() {
    Map<String, dynamic> data = {};
    data['name'] = name;
    data['address'] = address;
    data['gender'] = gender;
    data['dob'] = dob;
    data['phoneNumber'] = phoneNumber;
    data['avt'] = avt;
    data['status'] = status;
    return jsonEncode(data);
  }
}
