import 'package:admin_clinical/features/dashboard/controller/dashboard_controller.dart';
import 'package:admin_clinical/features/dec_patient/controller/dp_patinet_contnrolller.dart';
import 'package:get/get.dart';

class DpPatientBinding extends Bindings {
  @override
  void dependencies() async {
    // await Get.putAsync(() => Future.value(DashboardController()));
    Get.lazyPut<DpPatinetController>(() => DpPatinetController());
  }
}
