import 'package:admin_clinical/models/patient.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:get/get.dart';

import '../../../models/department.dart';
import '../../../models/doctor.dart';
import '../../../models/health_record.dart';
import '../../../services/data_service/health_record_service.dart';

class DoctorDetailController extends GetxController {
  Department getDepartMent(String id, List<Department> list) =>
      list.firstWhere((element) => element.id == id);
  Doctor1 doctor = Get.arguments['doctor'] as Doctor1;
  RxMap<String, HealthRecord> listRecord = RxMap({});
  RxMap<String, Patient> listPatient = PatientService.listPatients;
  RxString selectRecord = "".obs;
  bool checkPatient = false;
  RxString select_patient_record = "".obs;

  int get checkNull => listRecord.isEmpty
      ? 0
      : select_patient_record.value == "" ||
              !listPatient.containsKey(select_patient_record.value)
          ? 1
          : 2;

  @override
  void onInit() {
    super.onInit();
    doctor = Get.arguments['doctor'] as Doctor1;
    listPatient = PatientService.listPatients;
    for (var item in HealthRecordService.listHealthRecord.values) {
      if (item.doctorId == doctor.iDBS) {
        listRecord.addAll({item.id!: item});
      }
    }
    if (listRecord.isNotEmpty) {
      selectRecordFunc(listRecord.keys.first);
    }
  }

  selectRecordFunc(String id) {
    selectRecord.value = id;
    select_patient_record.value = listRecord[selectRecord.value]!.patientId;
  }
}
