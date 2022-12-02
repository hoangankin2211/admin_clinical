import 'dart:convert';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../constants/api_link.dart';
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

  void insertNewDoctor(VoidCallback callBack,
      {required String name,
      required String address,
      required String phoneNumber,
      required String av,
      required String departMent,
      required String description,
      required DateTime dateBorn,
      required int experience}) async {
    try {
      print("Insert new Doctor function is called");
      var timeStamp = dateBorn.millisecondsSinceEpoch;

      http.Response res = await http.post(
        Uri.parse('${ApiLink.uri}/api/doctors/insertDoctor'),
        body: jsonEncode(
          {},
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (res.statusCode == 200) {
        callBack();
      }
    } catch (e) {
      // print('err: ${e.toString()}');
    } finally {
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
      callBack();
    }
  }
}
