import 'dart:convert';

import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/error_dialog.dart';
import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/success_dialog.dart';
import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/models/patient.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:admin_clinical/services/data_service/notification_service.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constants/api_link.dart';
import '../../../models/doctor.dart';

class DpPatinetController extends GetxController {
  RxMap<String, Patient> listPatinet = RxMap({});
  RxList<Doctor1> listDoctor = RxList([]);
  @override
  void onInit() {
    super.onInit();
    fetchAllBasicData();
    listPatinet = PatientService.listPatients;
    listDoctor = DataService.instance.listDoctor;
  }

  Future<bool> fetchAllBasicData() async {
    print("Fetch all data is called");
    return await DataService.instance.fetchAllData();
  }

  //Booking appointment field
  final selectIdController = TextEditingController();
  Rx<Patient> selectPatient = Patient(
          avt: '',
          id: '',
          name: '',
          gender: '',
          address: '',
          dob: '',
          phoneNumber: '',
          status: '')
      .obs;

  void selectPatinetFunc() async {
    Patient? temp = await PatientService.searchPatientById(Get.context!,
        id: selectIdController.value.text);
    if (temp != null) {
      selectPatient.value = temp;
    }
  }

  Future<bool> _updatePatientRecord(
      String patientId, String newHealthRecord) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiLink.uri}/api/addPatientRecord/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          '_id': patientId,
          'healthRecord': newHealthRecord,
        }),
      );

      final extractedData = jsonDecode(response.body);

      if (extractedData['isSuccess'] != null && extractedData['isSuccess']) {
        return true;
      }
    } catch (e) {
      print('_updatePatientRecord: ${e.toString()}');
    }
    return false;
  }

  void bookingAppointment() async {
    if (selectPatient.value.id == '') {
      Get.dialog(
          const ErrorDialog(question: "Booking Appointment", title1: "Failed"));
    } else {
      bool check = false;
      // HealthRecordService.listHealthRecord.forEach((key, value) {});

      for (var item in HealthRecordService.listHealthRecord.values) {
        if (item.patientId == selectPatient.value.id &&
            item.status == "Waiting Examination") {
          check = true;
          break;
        }
      }
      if (!check) {
        HealthRecord newRecord = HealthRecord(
          dateCreate: DateTime.now(),
          departmentId: "01",
          patientId: selectPatient.value.id,
          status: "Waiting Examination",
          doctorId: "",
          totalMoney: 0,
          services: [],
          medicines: [],
        );
        Map<String, dynamic> newRecordMap = newRecord.toMap();
        final response = await HealthRecordService.addHealthRecord(
            newRecordMap, Get.context!);
        if (response != null) {
          try {
            final updatePatientResponse = await _updatePatientRecord(
              selectPatient.value.id,
              response,
            );
            if (updatePatientResponse) {
              NotificationService.instance
                  .insertNotification("You have appointment from Patient");
              Get.dialog(const SuccessDialog(
                  question: "Booking Appointment", title1: "Success"));
            }
          } catch (err) {
            print("Some error: $err");
          }
        }
      } else {
        Get.dialog(const ErrorDialog(
            question: "Create Health Record", title1: "Wating  Examination"));
      }
    }
  }

  void canceleForm() {
    selectPatient.value = Patient(
        avt: '',
        id: '',
        name: '',
        gender: '',
        address: '',
        dob: '',
        phoneNumber: '',
        status: '');
  }
}
