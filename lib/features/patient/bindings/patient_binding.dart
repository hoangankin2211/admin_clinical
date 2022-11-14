import 'package:admin_clinical/features/patient/controller/patient_page_controller.dart';
import 'package:get/get.dart';

class PatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientPageController>(() => PatientPageController());
  }
}
