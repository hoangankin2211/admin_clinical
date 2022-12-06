import 'dart:convert';

import 'package:admin_clinical/models/medicine.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/api_link.dart';
import '../../constants/error_handing.dart';

class MedicineService {
  MedicineService._privateConstructor();
  static final MedicineService instance = MedicineService._privateConstructor();
  RxList<Medicine> listMedicine = <Medicine>[].obs;

  Future<void> fetchAllMedicineData() async {
    print('fetch all medicine data is called');
    try {
      final res = await http.get(
        Uri.parse('${ApiLink.uri}/api/medicine/get_all'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        print(res.body);
        listMedicine.clear();
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          Map<String, dynamic> map = jsonDecode(res.body)[i];
          listMedicine.add(Medicine.fromMap(map));
        }
        DataService.instance.checkFetchData.add(1);
      }
    } catch (e) {
      print("Fetch data is error: $e");
      return;
    } finally {}
  }

  Future<List<Medicine>> searchMedicine(String searchQuery) async {
    print('search medicine is called');
    List<Medicine> searchMedicine = [];
    try {
      final res = await http.get(
        Uri.parse('${ApiLink.uri}/api/medicine/search/$searchQuery'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        print(res.body);
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          Map<String, dynamic> map = jsonDecode(res.body)[i];
          searchMedicine.add(Medicine.fromMap(map));
        }
      }
    } catch (e) {
      searchMedicine = [];
    }
    return searchMedicine;
  }

  Future<Medicine?> updateAMountMedicine(BuildContext context,
      {required String id, required int amount}) async {
    Medicine? result;
    print("Update amount medicine is called");
    try {
      http.Response res = await http.post(
        Uri.parse('${ApiLink.uri}/api/medicine/update_amount'),
        body: jsonEncode({
          'id': id,
          'amount': amount,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          result = Medicine.fromMap(jsonDecode(res.body));
        },
      );
    } catch (e) {
      result = null;
    }
    return result;
  }

  Future<bool> deleteMedicine(BuildContext context,
      {required String id}) async {
    bool result = false;
    print("delete medicine is called");
    try {
      final res = await http.post(
        Uri.parse('${ApiLink.uri}/api/medicine/delete_medicine'),
        body: jsonEncode({'id': id}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          result = true;
        },
      );
    } catch (e) {
      //
      result = false;
    }
    return result;
  }

  Future<Medicine?> editMedcine(
    BuildContext context, {
    required String id,
    required String thumbnails,
    required double price,
    required String type,
    required String description,
    required String name,
  }) async {
    Medicine? result;
    try {
      final res = await http.post(
        Uri.parse('${ApiLink.uri}/api/medicine/edit_medicine'),
        body: jsonEncode({
          "name": name,
          "thumbnails": thumbnails,
          "price": price,
          "type": type,
          "description": description,
          "id": id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          result = Medicine.fromMap(jsonDecode(res.body));
        },
      );
    } catch (e) {
      result = null;
    }
    return result;
  }

  Future<Medicine?> insertNewMedcine(
    BuildContext context, {
    required String name,
    required String thumbnails,
    required double price,
    required double cost,
    required String type,
    required String description,
    required String unit,
    required int amount,
  }) async {
    print("insert new medicines is called");
    Medicine? result;
    try {
      final res = await http.post(
        Uri.parse('${ApiLink.uri}/api/medicine/insert_medicine'),
        body: jsonEncode(
          {
            'name': name,
            'thumbnails': thumbnails,
            'price': price,
            'cost': cost,
            'type': type,
            'description': description,
            'unit': unit,
            'amount': amount,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          result = Medicine.fromMap(jsonDecode(res.body));
        },
      );
    } catch (e) {
      result = null;
    }
    return result;
  }
}
