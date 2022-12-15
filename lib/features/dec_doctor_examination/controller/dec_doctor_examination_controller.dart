import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:get/get.dart';

class DecDoctExaminationController extends GetxController {
  late RxMap<String, HealthRecord> listRecords =
      HealthRecordService.listHealthRecord;

  @override
  void onInit() {
    // HealthRecordService.listHealthRecord.listen((record) => fetchData(record));
    super.onInit();
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
