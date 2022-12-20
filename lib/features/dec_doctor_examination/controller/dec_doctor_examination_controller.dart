import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:get/get.dart';

import '../../../models/patient.dart';
import '../../../services/data_service/patient_service.dart';

class DecDoctExaminationController extends GetxController {
  RxMap<String, HealthRecord> listRecords =
      HealthRecordService.listHealthRecord;
  RxMap<String, Patient> listPatient = PatientService.listPatients;
  RxString selectRecords = "".obs;
  RxString selectRecords1 = "".obs;
  RxList<String> lRole = ['Waiting Patient', 'Completed'].obs;
  RxInt selectRole = 0.obs;

  // Rx

  @override
  void onInit() {
    // HealthRecordService.listHealthRecord.listen((record) => fetchData(record));
    super.onInit();
    listRecords.forEach((key, value) {
      if (value.status == "Waiting Examination" &&
          value.departmentId == AuthService.instance.doc.departMent) {
        selectRecords.value = value.patientId;
        selectRecords1.value = value.id!;
      }
    });
  }

  // void fetchData(Map<String, HealthRecord> record) {
  //   record.forEach((key, value) {
  //     listRecords.value = [];
  //     if (value.status == 'Waiting Examination' &&
  //         value.departmentId == AuthService.instance.doc.departMent) {
  //       listRecords.add(value);
  //     }
  //   });
  // }
}
