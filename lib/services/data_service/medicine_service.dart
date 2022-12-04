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
  RxList<Medicine1> listMedicine = <Medicine1>[].obs;

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
          listMedicine.add(Medicine1.fromMap(map));
        }
        DataService.instance.checkFetchData.add(1);
      }
    } catch (e) {
      print("Fetch data is error: $e");
      return;
    } finally {}
  }

  Future<Medicine1?> updateAMountMedicine(BuildContext context,
      {required String id, required int amount}) async {
    Medicine1? result;
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
          result = Medicine1.fromMap(jsonDecode(res.body));
        },
      );
    } catch (e) {
      result = null;
    }
    return result;
  }

  // void deleteMedicine(BuildContext context, Function(List<Medicine1>) callBack,
  //     {required String id}) async {
  //   print("delete medicine is called");
  //   try {
  //     final res = await http.post(
  //       Uri.parse('${ApiLink.uri}/api/medicine/delete_medicine'),
  //       body: jsonEncode({'id': id}),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         listMedicine.value.removeWhere((item) => item.id == id);
  //         callBack(listMedicine.value);
  //       },
  //     );
  //   } catch (e) {
  //     //
  //   } finally {
  //     listMedicine.value.removeWhere((item) => item.id == id);
  //     callBack(listMedicine.value);
  //   }
  // }

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

  Future<Medicine1?> insertNewMedcine(
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
    Medicine1? result;
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
          result = Medicine1.fromMap(jsonDecode(res.body));
        },
      );
    } catch (e) {
      result = null;
    }
    return result;
  }
}
