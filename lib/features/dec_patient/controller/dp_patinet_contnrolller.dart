import 'dart:convert';

import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/error_dialog.dart';
import 'package:admin_clinical/constants/global_widgets/custom_dialog_error/success_dialog.dart';
import 'package:admin_clinical/models/department.dart';
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
  RxList<Department> listDepartMent = RxList([]);
  RxBool isLoadingCreateID = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchAllBasicData();
    listPatinet = PatientService.listPatients;
    listDoctor = DataService.instance.listDoctor;
    listDepartMent = DataService.instance.listDepartMent;
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

  void addEntries(Map<String, Patient> newPatient) {
    // PatientService.listPatients.addAll(newPatient);
    PatientService.listPatients
        .putIfAbsent(newPatient.keys.first, () => newPatient.values.first);
  }

  Future<bool> addPatientToDataBase(
      Patient patient, BuildContext context) async {
    final response = await PatientService.insertPatient(patient, context);
    if (response != null) {
      if (response['isSuccess']) {
        patient.id = response['id'];
        addEntries({patient.id: patient});
        return true;
      }
    }
    return false;
  }

  Future<Map<String, dynamic>> addPatientToDataBaseReturnId(
      Patient patient, BuildContext context) async {
    final response = await PatientService.insertPatient(patient, context);
    if (response != null) {
      if (response['isSuccess']) {
        patient.id = response['id'];
        addEntries({patient.id: patient});
        return {
          'id': response['id'],
          'check': true,
        };
      }
    }
    return {
      'id': '',
      'check': false,
    };
  }

  RxBool isLoadingBooking = false.obs;
  void bookingAppointment() async {
    if (selectPatient.value.id == '') {
      Get.dialog(
          const ErrorDialog(question: "Booking Appointment", title1: "Failed"));
    } else {
      isLoadingBooking.value = true;
      bool check = false;
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
          HealthRecordService.listHealthRecord.addAll({response: newRecord});
          try {
            final updatePatientResponse = await _updatePatientRecord(
              selectPatient.value.id,
              response,
            );
            if (updatePatientResponse) {
              PatientService.listPatients[selectPatient.value.id]!.healthRecord!
                  .add(response);
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
      isLoadingBooking.value = false;
    }
  }

  Rx<Doctor1> selectDotor = DataService.instance.listDoctor.isNotEmpty
      ? DataService.instance.listDoctor[0].obs
      : Doctor1(
              iDBS: '',
              name: '',
              address: '',
              dateBorn: DateTime.now(),
              phoneNumber: '',
              avt: '',
              departMent: '',
              experience: 0,
              description: '')
          .obs;
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

  // Book appointment
  final idTextController = TextEditingController();
  final symptomControllerViewDoc = TextEditingController();

  TextEditingController dobController = TextEditingController();
  DateTime currentDateTime = DateTime.now();

  Rx<Patient> selectPatientViewDoc = Patient(
          avt: '',
          id: '',
          name: '',
          gender: '',
          address: '',
          dob: '',
          phoneNumber: '',
          status: '')
      .obs;

  void selectPatinetFuncViewDoc() async {
    Patient? temp = await PatientService.searchPatientById(Get.context!,
        id: idTextController.value.text);
    if (temp != null) {
      selectPatientViewDoc.value = temp;
    }
  }

  void bookingAppointmentViewDoc() async {
    if (selectPatientViewDoc.value.id == '') {
      Get.dialog(
          const ErrorDialog(question: "Booking Appointment", title1: "Failed"));
    } else {
      bool check = false;
      for (var item in HealthRecordService.listHealthRecord.values) {
        if (item.patientId == selectPatientViewDoc.value.id &&
            item.status == "Waiting Examination") {
          check = true;
          break;
        }
      }
      if (!check) {
        HealthRecord newRecord = HealthRecord(
          dateCreate: currentDateTime,
          departmentId: selectDotor.value.departMent!,
          patientId: selectPatientViewDoc.value.id,
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
          HealthRecordService.listHealthRecord.addAll({response: newRecord});
          try {
            final updatePatientResponse = await _updatePatientRecord(
              selectPatientViewDoc.value.id,
              response,
            );
            if (updatePatientResponse) {
              PatientService
                  .listPatients[selectPatientViewDoc.value.id]!.healthRecord!
                  .add(response);
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

  // search health record field
  final idPatinetSearchController = TextEditingController();

  RxList<HealthRecord> listHealthRecordSearch = RxList<HealthRecord>([]);

  searchHealthRecord() {
    listHealthRecordSearch.clear();
    for (var item in HealthRecordService.listHealthRecord.values) {
      if (item.patientId == idPatinetSearchController.text) {
        listHealthRecordSearch.add(item);
      }
    }
  }

  // Find ID
  final emailPatientFindController = TextEditingController();
  final phoneNoPatientFindController = TextEditingController();
  final yourId = "".obs;
  List<String> dropDownItem = ['+84', '+86', '+42', '+88', '+14', '+52', '+50'];
  late final phoneCode = dropDownItem.first.obs;

  findIdFunc() async {
    yourId.value = "";
    String result = "";
    for (var item in PatientService.listPatients.values) {
      if (item.email == emailPatientFindController.text &&
          item.phoneNumber ==
              "${phoneCode.value} ${phoneNoPatientFindController.text}") {
        result = item.id;
      }
    }
    if (result == "") {
      await Get.dialog(
          const ErrorDialog(question: "Find ID", title1: "Cann't Find "));
    } else {
      yourId.value = result;
    }
  }
}
