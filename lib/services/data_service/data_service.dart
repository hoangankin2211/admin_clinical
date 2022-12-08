import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:admin_clinical/services/data_service/invoice_service.dart';
import 'package:admin_clinical/services/data_service/medicine_service.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:admin_clinical/services/data_service/service_data_service.dart';
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

  RxList<int> checkFetchData = <int>[].obs;

  RxList<Doctor1> listDoctor = <Doctor1>[].obs;
  RxList<Department> listDepartMent = <Department>[].obs;

  fetchAllData() async {
    if (listDoctor.value.isEmpty) {
      fetchAllDoctor((value) {
        checkFetchData.value.add(1);
        listDoctor.value = value;
      });
    }
    if (listDepartMent.value.isEmpty) {
      fetchAllDeparMent((value) {
        checkFetchData.value.add(1);
        listDepartMent.value = value;
      });
    }
    if (PatientService.listPatients.isEmpty) {
      PatientService.fetchAllPatientData();
    }
    if (MedicineService.instance.listMedicine.isEmpty) {
      MedicineService.instance.fetchAllMedicineData();
    }
    if (HealthRecordService.listHealthRecord.isEmpty) {
      HealthRecordService.fetchAllHealthRecordData();
    }
    if (InvoiceService.instance.listInvoice.isEmpty) {
      InvoiceService.instance.fetchAllDataInvoice();
      if (ServiceDataService.instance.service.isEmpty) {
        ServiceDataService.instance.fetchAllDataService();
      }
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

  Future<bool> deleteDoctor(BuildContext context, {required String id}) async {
    bool result = false;
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
          // callBack(listDoctor.value);
          result = true;
        },
      );
    } catch (e) {
      result = false;
    } finally {
      // listDoctor.value.removeWhere((item) => item.iDBS == id);
      // callBack(listDoctor.value);
    }
    return result;
  }

  Future<List<Doctor1>> searchDoctor(
      BuildContext context, String searchQuery, String filter) async {
    List<Doctor1> doctorList = [];
    print(filter);
    try {
      http.Response res = await http.get(
        Uri.parse(
            '${ApiLink.uri}/api/doctors/searchDoctor/$searchQuery/$filter'),
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

  Future<Doctor1?> editDoctor(BuildContext context,
      // Function(List<Doctor1>) callBack,
      {required String id,
      required String name,
      required String address,
      required String phoneNumber,
      required String av,
      required String departMent,
      required String description,
      required DateTime dateBorn,
      required int experience}) async {
    Doctor1? result;
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
          result = Doctor1.fromJson(jsonDecode(res.body));
        },
      );
    } catch (e) {
      result = null;
    } finally {}
    return result;
  }

  Future<Doctor1?> insertNewDoctor(BuildContext context,
      //  Function(List<Doctor1>) callBack,
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
    Doctor1? result;
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
          result = Doctor1.fromJson(jsonDecode(res.body));
        },
      );
    } catch (e) {
      result = null;
    } finally {}
    return result;
  }
}
