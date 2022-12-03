import 'dart:convert';

import 'package:admin_clinical/constants/error_handing.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constants/api_link.dart';
import '../../models/patient.dart';
import 'package:http/http.dart' as http;

class PatientService {
  static RxMap<String, Patient> listPatients = RxMap({});
  static Future<void> fetchAllPatientData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiLink.uri}/api/getAllPatient/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final decodeResponse = jsonDecode(response.body);

      print(decodeResponse);

      if (decodeResponse['isSuccess'] ?? false) {
        listPatients.clear();

        List<dynamic> extractedData = decodeResponse['patients'];
        for (int i = 0; i < extractedData.length; i++) {
          Map<String, dynamic> map = extractedData[i];
          listPatients.addAll({map['_id']: Patient.fromJson(map)});
        }
      }
    } catch (e) {
      print('fetchAllPatientData:$e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> insertPatient(
      Patient patient, BuildContext context) async {
    Map<String, dynamic>? result;

    try {
      final response = await http.post(
        Uri.parse('${ApiLink.uri}/api/addPatient/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: patient.toJson(),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          final decodeResponse = jsonDecode(response.body);

          print(decodeResponse);
          result = decodeResponse;
        },
      );
    } catch (e) {
      result = null;
      print('insertPatient:$e');
    }
    return result;
  }

  static Future<bool> deletePatient(String id, BuildContext context) async {
    bool result = false;

    try {
      final response = await http.post(
        Uri.parse('${ApiLink.uri}/api/deletePatient/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"patientId": id}),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          final decodeResponse = jsonDecode(response.body);

          print(decodeResponse);
          result = decodeResponse['isSuccess'] ?? false;
          if (result) {
            print(decodeResponse['patient']);
          }
        },
      );
    } catch (e) {
      result = false;
      print('deletePatient:$e');
    }
    return result;
  }
}
