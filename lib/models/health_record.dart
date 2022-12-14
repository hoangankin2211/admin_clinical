import 'dart:convert';

import 'package:admin_clinical/constants/utils.dart';

class HealthRecord {
  String? id;
  String patientId;
  String doctorId;
  String departmentId;
  DateTime dateCreate;
  double totalMoney;
  String status;
  String? note;
  String? clinicalExamination;
  String? symptom;
  String? diagnostic;
  String? conclusionAndTreatment;
  double? weight;
  double? height;
  double? heartBeat;
  double? temperature;
  double? bloodPressure;
  String? allergy;
  List<Map<String, dynamic>>? services;
  List<Map<String, dynamic>>? medicines;

  HealthRecord({
    this.allergy,
    this.bloodPressure,
    this.conclusionAndTreatment,
    this.clinicalExamination,
    required this.dateCreate,
    required this.departmentId,
    this.diagnostic,
    required this.doctorId,
    this.heartBeat,
    this.height,
    this.id,
    required this.patientId,
    this.medicines,
    this.note,
    this.services,
    this.symptom,
    this.temperature,
    required this.totalMoney,
    required this.status,
    this.weight,
  });

  static HealthRecord fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> extractedServices = [];
    List<Map<String, dynamic>> extractedMedicines = [];

    try {
      List<dynamic> tempServices = json['services'] ?? [];
      extractedServices = Utils.convertList2ListMap(
        tempServices,
        (map) {
          Map<String, dynamic> result = {};

          map.forEach((key, value) {
            if (key == "service") {
              result.addAll({key: value as String});
            } else if (key == "provider") {
              result.addAll({key: value as String});
            } else if (key == "quantity") {
              result.addAll({key: value as int});
            } else if (key == "amount") {
              result.addAll({key: value as double});
            }
          });

          return result;
        },
      );

      List<dynamic> tempMedicines = json['medicines'] ?? [];
      extractedMedicines = Utils.convertList2ListMap(
        tempMedicines,
        (map) {
          Map<String, dynamic> result = {};

          map.forEach((key, value) {
            if (key == "medicine") {
              result.addAll({key: value as String});
            } else if (key == "provider") {
              result.addAll({key: value as String});
            } else if (key == "quantity") {
              result.addAll({key: value as int});
            } else if (key == "amount") {
              result.addAll({key: value as double});
            }
          });

          return result;
        },
      );
    } on Exception catch (e) {
      print('here:::${e.toString()}');
    }

    return HealthRecord(
        id: json['id'].toString(),
        patientId: json['patientId'] ?? "",
        dateCreate:
            DateTime.parse(json['dateCreate'] ?? DateTime.now().toString()),
        departmentId: json['departmentId'] ?? "",
        doctorId: json['doctorId'] ?? '',
        totalMoney: (json['totalMoney'] ?? 0.0) as double,
        allergy: json['allergy'] ?? "",
        bloodPressure: (json['bloodPressure'] ?? 0.0) as double,
        clinicalExamination: json['clinicalExamination'],
        conclusionAndTreatment: json['conclusionAndTreatment'],
        diagnostic: json['diagnostic'],
        heartBeat: (json['heartBeat'] ?? 0.0) as double,
        symptom: json['symptom'],
        height: (json['height'] ?? 0.0) as double,
        medicines: extractedMedicines,
        services: extractedServices,
        note: json['note'] ?? "",
        temperature: (json['temperature'] ?? 0.0) as double,
        weight: (json['weight'] ?? 0.0) as double,
        status: json['status'] ?? "Waiting Examination");
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    data['patientId'] = patientId;
    data['dateCreate'] = dateCreate.toIso8601String();
    data['totalMoney'] = totalMoney;
    data['departmentId'] = departmentId;
    data['status'] = status;
    data['note'] = note;
    data['doctorId'] = doctorId;
    data['clinicalExamination'] = clinicalExamination;
    data['symptom'] = symptom;
    data['diagnostic'] = diagnostic;
    data['conclusionAndTreatment'] = conclusionAndTreatment;
    data['weight'] = weight;
    data['height'] = height;
    data['heartBeat'] = heartBeat;
    data['temperature'] = temperature;
    data['bloodPressure'] = bloodPressure;
    data['allergy'] = allergy;
    data['services'] = services;
    data['medicines'] = medicines;
    return data;
  }

  String toJson() {
    return jsonEncode(toMap());
  }
}
