import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_link.dart';
import '../../constants/error_handing.dart';
import '../../models/department.dart';
import '../../models/doctor.dart';

class DataService extends GetxController {
  DataService._privateConstructor();
  static final DataService instance = DataService._privateConstructor();
  RxList<Doctor1> listDoctor = <Doctor1>[].obs;
  RxList<Department> listDepartMent = <Department>[].obs;

  fetchAllData() async {
    if (listDoctor.value.isEmpty) {
      fetchAllDoctor((value) => listDoctor.value = value);
    }
    if (listDepartMent.value.isEmpty) {
      fetchAllDeparMent((value) => listDepartMent.value = value);
    }
    if (PatientService.listPatients.isEmpty) {
      PatientService.fetchAllPatientData();
    }
  }

  void fetchAllDoctor(Function(List<Doctor1>) callBack) async {
    List<Doctor1> listDoctor = [];
    try {
      print('Get all doctor function is called');
      http.Response res = await http.get(
        Uri.parse('${ApiLink.uri}/api/doctors/getAll'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        print(res.body);
        listDoctor.clear();
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          Map<String, dynamic> map = jsonDecode(res.body)[i];
          listDoctor.add(Doctor1.fromJson(map));
        }
      }
    } catch (e) {
      // print('err ${e.toString()}');
    } finally {
      callBack(listDoctor);
    }
  }

  void fetchAllDeparMent(Function(List<Department>) callBack) async {
    List<Department> listDepartMent = [];
    try {
      print("Get all departmeent function is called");
      http.Response res = await http.get(
        Uri.parse('${ApiLink.uri}/api/departments/getAll'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        print(res.body);
        listDepartMent.clear();
        for (int i = 0; i < jsonDecode(res.body).length; i++) {
          Map<String, dynamic> map = jsonDecode(res.body)[i];
          listDepartMent.add(Department.fromJson(map));
        }
        callBack(listDepartMent);
      }
    } catch (e) {
      //print error
    } finally {
      callBack(listDepartMent);
    }
  }

  void deleteDoctor(BuildContext context, Function(List<Doctor1>) callBack,
      {required String id}) async {
    try {
      print("Delete doctor function is called");
      http.Response res = await http.post(
        Uri.parse('${ApiLink.uri}/api/doctors/deleteDoctor'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'id': id,
        }),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          callBack(listDoctor.value);
        },
      );
    } catch (e) {
//
    } finally {
      listDoctor.value.removeWhere((item) => item.iDBS == id);
      callBack(listDoctor.value);
    }
  }

  Future<List<Doctor1>> searchDoctor(
      BuildContext context, String searchQuery) async {
    List<Doctor1> doctorList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('${ApiLink.uri}/api/doctors/searchDoctor/$searchQuery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            doctorList.clear();
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              Map<String, dynamic> map = jsonDecode(res.body)[i];
              doctorList.add(Doctor1.fromJson(map));
            }
          }
        },
      );
    } catch (e) {
      //
    } finally {}
    return doctorList;
  }

  editDoctor(BuildContext context, Function(List<Doctor1>) callBack,
      {required String id,
      required String name,
      required String address,
      required String phoneNumber,
      required String av,
      required String departMent,
      required String description,
      required DateTime dateBorn,
      required int experience}) async {
    try {
      print("Edit Doctor function is called");
      var timeStamp = dateBorn.millisecondsSinceEpoch;
      http.Response res = await http.post(
        Uri.parse(
          '${ApiLink.uri}/api/doctors/editDoctor',
        ),
        body: jsonEncode({
          'id': id,
          'name': name,
          'address': address,
          'avt': av,
          'dateBorn': timeStamp,
          'departMent': departMent,
          'experience': experience,
          'phoneNumber': phoneNumber,
          'description': description,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          callBack(listDoctor.value);
        },
      );
    } catch (e) {
      //
    } finally {
      final index =
          listDoctor.value.indexWhere((element) => element.iDBS == id);
      listDoctor.value[index] = Doctor1(
        name: name,
        address: address,
        avt: av,
        dateBorn: dateBorn,
        departMent: departMent,
        experience: experience,
        iDBS: listDoctor.value[index].iDBS,
        phoneNumber: phoneNumber,
        description: description,
      );
      callBack(listDoctor.value);
    }
  }

  void insertNewDoctor(BuildContext context, Function(List<Doctor1>) callBack,
      {required String name,
      required String address,
      required String phoneNumber,
      required String av,
      required String departMent,
      required String description,
      required String email,
      required String password,
      required DateTime dateBorn,
      required int experience}) async {
    try {
      print("Insert new Doctor function is called");
      var timeStamp = dateBorn.millisecondsSinceEpoch;

      http.Response res = await http.post(
        Uri.parse('${ApiLink.uri}/api/doctors/insertDoctor'),
        body: jsonEncode(
          {
            'iDBS': '0',
            'name': name,
            'address': address,
            'dateBorn': timeStamp,
            'phoneNumber': phoneNumber,
            'avt': av,
            'departMent': departMent,
            'description': description,
            'experience': experience,
            'email': email,
            'password': password,
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
          callBack(listDoctor.value);
        },
      );
    } catch (e) {
      // print('err: ${e.toString()}');
    } finally {
      // ignore: invalid_use_of_protected_member
      listDoctor.value.add(Doctor1(
        name: name,
        address: address,
        avt: av,
        dateBorn: dateBorn,
        departMent: departMent,
        experience: experience,
        iDBS: null,
        phoneNumber: phoneNumber,
        description: description,
      ));
      callBack(listDoctor.value);
    }
  }
}
