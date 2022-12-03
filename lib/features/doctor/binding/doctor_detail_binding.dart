import 'package:admin_clinical/features/doctor/controller/doctor_detai_controller.dart';
import 'package:get/get.dart';

class DoctorDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorDetailController>(() => DoctorDetailController());
  }
}
