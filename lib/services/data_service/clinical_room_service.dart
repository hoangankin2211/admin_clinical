import 'dart:convert';

import 'package:admin_clinical/constants/error_handing.dart';
import 'package:admin_clinical/features/clinical_room/screens/clinical_room_screen.dart';
import 'package:admin_clinical/models/clinical_room.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/api_link.dart';

class ClinicalRoomService {
  ClinicalRoomService._privateConstructor();
  static final ClinicalRoomService instance =
      ClinicalRoomService._privateConstructor();
  RxList<ClinicalRoomModel> listClinicalRoom = <ClinicalRoomModel>[].obs;
  Future<void> fetchAllClinicalRoomData() async {
    try {
      print("Fetch all clinical room data is called");
      http.Response res = await http.get(
        Uri.parse('${ApiLink.uri}/api/clinical_room/get_all'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        listClinicalRoom.clear();
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          Map<String, dynamic> map = jsonDecode(res.body)[i];
          listClinicalRoom.add(ClinicalRoomModel.fromMap(map));
        }
        DataService.instance.checkFetchData.add(1);
      }
    } catch (e) {
      print("Fetch all data error: ${e.toString()}");
    }
  }

  Future<ClinicalRoomModel?> editClinicalRoom(
    BuildContext context, {
    required String name,
    required int reception,
    required int examined,
  }) async {
    ClinicalRoomModel? result;
    try {
      print('edit clinical room is called');
      http.Response res = await http.post(
        Uri.parse('${ApiLink.uri}/api/clinical_room/edit_room'),
        body: jsonEncode({
          'name': name,
          'reception': reception,
          'exmained': examined,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            result = ClinicalRoomModel.fromMap(jsonDecode(res.body));
          });
    } catch (e) {
      result = null;
    } finally {}
    return result;
  }

  Future<ClinicalRoomModel?> insertClinicalRoom(
    BuildContext context, {
    required String name,
  }) async {
    ClinicalRoomModel? result;
    try {
      print('insert clinical room is called');
      http.Response res = await http.post(
        Uri.parse('${ApiLink.uri}/api/clinical_room/insert'),
        body: jsonEncode({
          'name': name,
          'reception': 0,
          'exmained': 0,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            result = ClinicalRoomModel.fromMap(jsonDecode(res.body));
          });
    } catch (e) {
      result = null;
    } finally {}
    return result;
  }
}
