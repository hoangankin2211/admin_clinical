import 'package:admin_clinical/features/decentralization_doctor/controller/event.dart';
import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/models/patient.dart';
import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:get/get.dart';

class DoctorOverviewController extends GetxController {
  RxList<Patient> listPatient = <Patient>[].obs;
  Rx<HealthRecord?> lastHealthRecord = Rx<HealthRecord?>(null);
  RxMap<String, List<Event>> lEvent = RxMap({});
  RxList<Event> sEvent = <Event>[].obs;
  RxInt selectPatinet = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (AuthService.instance.user.type == "Doctor" &&
        PatientService.listPatients.isNotEmpty) {
      for (var item1 in HealthRecordService.listHealthRecord.values) {
        int check =
            listPatient.indexWhere((element) => element.id == item1.patientId);
        if (item1.doctorId == AuthService.instance.doc.iDBS && check == -1) {
          if (PatientService.listPatients.containsKey(item1.patientId)) {
            listPatient.add(PatientService.listPatients[item1.patientId]!);
          }
        }
      }

      selectPatinet.value = (listPatient.isNotEmpty) ? 0 : -1;
      if (listPatient.isNotEmpty) {
        selectHealthPatine(0);
      } else {
        selectPatinet.value = -1;
      }
      fetchAllEventOfCalender();
    }
  }

  void fetchAllData() {
    listPatient.clear();
    sEvent.clear();
    lEvent.clear();
    if (AuthService.instance.user.type == "Doctor" &&
        PatientService.listPatients.isNotEmpty) {
      for (var item1 in HealthRecordService.listHealthRecord.values) {
        int check =
            listPatient.indexWhere((element) => element.id == item1.patientId);
        if (item1.doctorId == AuthService.instance.doc.iDBS && check == -1) {
          if (PatientService.listPatients.containsKey(item1.patientId)) {
            listPatient.add(PatientService.listPatients[item1.patientId]!);
          }
        }
      }

      selectPatinet.value = (listPatient.isNotEmpty) ? 0 : -1;
      if (listPatient.isNotEmpty) {
        selectHealthPatine(0);
      } else {
        selectPatinet.value = -1;
      }
      fetchAllEventOfCalender();
    }
  }

  void fetchAllEventOfCalender() {
    for (var item in HealthRecordService.listHealthRecord.values) {
      if (item.doctorId == AuthService.instance.doc.iDBS ||
          item.departmentId == AuthService.instance.doc.departMent) {
        if (PatientService.listPatients.containsKey(item.patientId)) {
          String key =
              '${item.dateCreate.year}/${item.dateCreate.month}/${item.dateCreate.day}';
          if (lEvent.containsKey(key)) {
            lEvent[key]!.add(
              Event(
                type: item.status == "Waiting Examination" ? 0 : 1,
                time: item.dateCreate,
                description: PatientService.listPatients[item.patientId]!.name,
                location: '',
                title: '',
              ),
            );
          } else {
            lEvent.addAll({
              key: [
                Event(
                  type: item.status == "Waiting Examination" ? 0 : 1,
                  time: item.dateCreate,
                  description:
                      PatientService.listPatients[item.patientId]!.name,
                  location: '',
                  title: '',
                ),
              ],
            });
          }
        }
      }
    }
  }

  void selectHealthPatine(int index) {
    selectPatinet.value = index;
    lastHealthRecord.value = null;
    for (var item in HealthRecordService.listHealthRecord.values) {
      if (item.patientId == listPatient[index].id &&
          item.conclusionAndTreatment != null) {
        // ignore: prefer_conditional_assignment
        if (lastHealthRecord.value == null) {
          lastHealthRecord.value = item;
        } else {
          if (item.dateCreate.isAfter(lastHealthRecord.value!.dateCreate)) {
            lastHealthRecord.value = item;
          }
        }
      }
      // print(lastHealthRecord.value!.conclusionAndTreatment);
    }
  }
}
