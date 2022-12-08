import 'dart:convert';

import 'package:admin_clinical/constants/error_handing.dart';
import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constants/api_link.dart';
import '../../models/patient.dart';
import 'package:http/http.dart' as http;

class HealthRecordService {
  static RxMap<String, HealthRecord> listHealthRecord = RxMap({});

  static Future<void> fetchAllHealthRecordData() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiLink.uri}/api/getAllHealthRecord/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final decodeResponse = jsonDecode(response.body);

      print(decodeResponse);

      if (decodeResponse['isSuccess'] ?? false) {
        listHealthRecord.clear();

        List<dynamic> extractedData = decodeResponse['healthRecords'];
        print("extractedData: $extractedData");
        for (int i = 0; i < extractedData.length; i++) {
          Map<String, dynamic> map = extractedData[i];
          listHealthRecord.addAll({map['_id']: HealthRecord.fromJson(map)});
        }
        DataService.instance.checkFetchData.add(1);
      }
    } catch (e) {
      print('fetchAllHealthRecordData:::::${e.toString()}');
      rethrow;
    }
  }

  static Future<String?> insertHealthRecord(
    Map<String, dynamic> healthRecord,
    BuildContext context,
  ) async {
    String? result;

    try {
      final response = await http.post(
        Uri.parse('${ApiLink.uri}/api/addHealthRecord/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(healthRecord),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          final decodeResponse = jsonDecode(response.body);
          print(decodeResponse);
          result = decodeResponse['id'];
        },
      );
    } catch (e) {
      result = null;
      print('insertHealthRecord:$e');
    }
    return result;
  }

  static Future<Map<String, dynamic>?> editHealthRecord(
      Map<String, dynamic> healthRecord, BuildContext context) async {
    Map<String, dynamic>? result;

    try {
      final response = await http.post(
        Uri.parse('${ApiLink.uri}/api/editHealthRecord/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(healthRecord),
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
      print('editHealthRecord:$e');
    }
    return result;
  }

  static Future<bool> deleteHealthRecord(
    String id,
    BuildContext context,
  ) async {
    bool result = false;

    try {
      final response = await http.post(
        Uri.parse('${ApiLink.uri}/api/deleteHealthRecord/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"healthRecordId": id}),
      );

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          final decodeResponse = jsonDecode(response.body);

          print(decodeResponse);
          result = decodeResponse['isSuccess'] ?? false;
          if (result) {
            print(decodeResponse['healthRecord']);
          }
        },
      );
    } catch (e) {
      result = false;
      print('deleteHealthRecord:$e');
    }
    return result;
  }
}
