import 'dart:convert';

import 'package:admin_clinical/constants/error_handing.dart';
import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constants/api_link.dart';
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

      if (decodeResponse['isSuccess'] ?? false) {
        listHealthRecord.clear();

        List<dynamic> extractedData = decodeResponse['healthRecords'];
        for (int i = 0; i < extractedData.length; i++) {
          Map<String, dynamic> map = extractedData[i];
          map['id'] = map['_id'];
          listHealthRecord.addAll({map['_id']: HealthRecord.fromJson(map)});
        }
        DataService.instance.checkFetchData.add(1);
      }
    } catch (e) {
      print('fetchAllHealthRecordData:::::${e.toString()}');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> getHealthRecordById(String id) async {
    Map<String, dynamic>? healthRecordMap;

    try {
      final response = await http.get(
        Uri.parse("${ApiLink.uri}/api/getHealthRecordById"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'id': id,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final extractData = jsonDecode(response.body);
        print(extractData);
        healthRecordMap = extractData['healthRecord'];
      }
    } catch (e) {
      print("getHealthRecordById:  $e");
    }

    return healthRecordMap;
  }

  static Future<String?> addHealthRecord(
      Map<String, dynamic> healthRecord, BuildContext context) async {
    String? result;
    try {
      final response = await http.post(
        Uri.parse('${ApiLink.uri}/api/addHealthRecord/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(healthRecord),
      );
      print(response.body);
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

  static Future<String?> insertHealthRecord(
    Map<String, dynamic> healthRecord,
    BuildContext context,
  ) async {
    String? result;

    try {
      DateTime now = DateTime.now();
      int noHealthRecordToday = 0;
      for (var item in listHealthRecord.values) {
        if (item.dateCreate.day == now.day &&
            item.dateCreate.month == now.month &&
            item.dateCreate.year == now.year) {
          noHealthRecordToday += 1;
        }
      }
      if (noHealthRecordToday <
          DataService.instance.regulation.value.maxPatientPerDay!) {
        final response = await http.post(
          Uri.parse('${ApiLink.uri}/api/addHealthRecord/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(healthRecord),
        );
        print(response.body);
        httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            final decodeResponse = jsonDecode(response.body);
            print(decodeResponse);
            result = decodeResponse['id'];
          },
        );
      } else {
        result = null;
      }
    } catch (e) {
      result = null;
      print('insertHealthRecord:$e');
    }
    return result;
  }

  static Future<Map<String, dynamic>?> editHealthRecord(
      Map<String, dynamic> healthRecord) async {
    Map<String, dynamic>? result;

    try {
      final response = await http.post(
        Uri.parse('${ApiLink.uri}/api/editHealthRecord/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(healthRecord),
      );
      final decodeResponse = jsonDecode(response.body);

      if (decodeResponse != null &&
          decodeResponse['isSuccess'] != null &&
          decodeResponse['isSuccess']) {
        result = decodeResponse;
      } else {
        result = null;
      }
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
