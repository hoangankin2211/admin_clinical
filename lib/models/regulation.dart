import 'dart:convert';

class Regulation {
  String? id;
  int? examinationFee;
  int? maxPatientPerDay;
  Regulation({
    required this.id,
    required this.examinationFee,
    required this.maxPatientPerDay,
  });

  factory Regulation.fromMap(Map<String, dynamic> json) => Regulation(
      id: json['_id'] ?? '',
      examinationFee: json['examinationFee'] ?? 0,
      maxPatientPerDay: json['maxPatientPerDay'] ?? 0);

  // factory Regulation.fromJson(String source) =>
  //     Regulation.fromMap(json.decode(source));
  Regulation.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    examinationFee = json['examinationFee'];
    maxPatientPerDay = json['maxPatientPerDay'];
  }
}
