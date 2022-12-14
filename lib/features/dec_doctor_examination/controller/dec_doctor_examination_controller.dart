import 'package:admin_clinical/models/health_record.dart';
import 'package:admin_clinical/services/data_service/health_record_service.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:get/get.dart';

import '../../../models/patient.dart';

class DecDoctExaminationController extends GetxController {
  RxMap<String, HealthRecord> listRecords =
      HealthRecordService.listHealthRecord;
  @override
  void onInit() {
    super.onInit();
  }
}
