import 'dart:convert';

import 'package:admin_clinical/constants/error_handing.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
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

      if (decodeResponse['isSuccess'] ?? false) {
        listPatients.clear();

        List<dynamic> extractedData = decodeResponse['patients'];
        for (int i = 0; i < extractedData.length; i++) {
          Map<String, dynamic> map = extractedData[i];
          listPatients.addAll({map['_id']: Patient.fromJson(map)});
        }
        DataService.instance.checkFetchData.add(1);
      }
    } catch (e) {
      print('fetchAllPatientData:$e');
      rethrow;
    }
  }

  static Future<List<String>> searchPatient(
      String query, String attribute) async {
    List<String> result = [];
    try {
      final response = await http.get(
        Uri.parse('${ApiLink.uri}/api/searchPatient/$attribute/$query'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> extractedData =
            jsonDecode(response.body)['patient'];
        for (Map<String, dynamic> element in extractedData) {
          result.add(element['_id'] as String);
          print(result.last);
        }
      }
    } catch (e) {
      print('searchPatient: $e');
    }
    return result;
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

  static Future<Map<String, dynamic>?> editPatient(
      Patient patient, BuildContext context) async {
    Map<String, dynamic>? result;

    try {
      final response = await http.post(
        Uri.parse('${ApiLink.uri}/api/editPatient/'),
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
      print('editPatient:$e');
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
